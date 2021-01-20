//
//  UserData.swift
//  sicnu_exercise
//  微博用户数据环境对象
//  Created by apple on 2021/1/8.
//

import Combine
import Foundation

class UserData: ObservableObject {
    @Published var recommendWeiboList: WeiboList = loadWeiboListData("UserListData_recommend_1.json")
    @Published var hotWeiboList: WeiboList = loadWeiboListData("UserListData_hot_1.json")
    @Published var isRefreshing: Bool = false
    @Published var isLoadingMore: Bool = false
    @Published var loadingError: Error?
    @Published var reloadData: Bool = false
    
    private var recommendWeiboDic: [Int: Int] = [:]
    private var hotWeiboDic: [Int: Int] = [:]
    
    init() {
        for i in 0..<recommendWeiboList.list.count {
            let weibo = recommendWeiboList.list[i]
            recommendWeiboDic[weibo.id] = i
        }
        for i in 0..<hotWeiboList.list.count {
            let weibo = hotWeiboList.list[i]
            hotWeiboDic[weibo.id] = i
        }
    }
}

enum WeiboListCategory {
    case recommend, hot
}

extension UserData {
    
    //通过微博类型找到微博列表
    func weiboList(for category: WeiboListCategory) -> WeiboList {
        switch category {
        case .recommend:
            return recommendWeiboList
        case .hot:
            return hotWeiboList
        }
    }
    
    //通过查找微博id找到微博
    func weibo(forID id: Int) -> Weibo? {
        if let index = recommendWeiboDic[id] {
            return recommendWeiboList.list[index]
        }
        if let index = hotWeiboDic[id] {
            return hotWeiboList.list[index]
        }
        return nil
    }
    
    //更新微博数据
    func updata(_ weibo:Weibo) {
        if let index = recommendWeiboDic[weibo.id] {
            return recommendWeiboList.list[index] = weibo
        }
        if let index = hotWeiboDic[weibo.id] {
            return hotWeiboList.list[index] = weibo
        }
    }
    
    
    //刷新微博列表
    func refreshWeiboList(for category: WeiboListCategory) {
        switch category {
        case .recommend:
            NetworkAPI.recommendWeiboList { result in
                switch result {
                case let .success(list): self.handleRefreshWeiboList(list, for: category)
                case let .failure(error): self.handleLoadingError(error)
                }
                self.isRefreshing = false
            }
        case .hot:
            NetworkAPI.hotWeiboList{ result in
                switch result {
                case let .success(list): self.handleRefreshWeiboList(list, for: category)
                case let .failure(error): self.handleLoadingError(error)
                }
                self.isRefreshing = false
            }
        }
    }
    
    //处理加载错误信息
    private func handleLoadingError(_ error: Error) {
        loadingError = error
        print(loadingError ?? "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.loadingError = nil
        }
    }
    
    //实现下拉刷新信息
    private func handleRefreshWeiboList(_ list: WeiboList, for category: WeiboListCategory) {
        var tempList: [Weibo] = []
        var tempDic: [Int: Int] = [:]
        for (index, weibo) in list.list.enumerated() {
            if tempDic[weibo.id] != nil { continue }
            tempList.append(weibo)
            tempDic[weibo.id] = index
        }
        switch category {
        case .recommend:
            recommendWeiboList.list = tempList
            recommendWeiboDic = tempDic
        case .hot:
            hotWeiboList.list = tempList
            hotWeiboDic = tempDic
        }
        reloadData = true
    }
    
    //实现上拉加载更多信息
    func loadMoreWeiboList(for category: WeiboListCategory) {
        if isLoadingMore || weiboList(for: category).list.count > 15 { return } //由于测试的数据数量有限，设置一个数据数量大于15时不再加载的限制
        isLoadingMore = true
        
        switch category {
        //当在推荐列表时，上拉加载出热门列表数据，在热门列表时加载推荐列表数据
        case .recommend:
            NetworkAPI.hotWeiboList{ result in
                switch result {
                case let .success(list): self.handleLoadMoreWeiboList(list, for: category)
                case let .failure(error): self.handleLoadingError(error)
                }
                self.isLoadingMore = false
            }
        case .hot:
            NetworkAPI.recommendWeiboList{ result in
                switch result {
                case let .success(list): self.handleLoadMoreWeiboList(list, for: category)
                case let .failure(error): self.handleLoadingError(error)
                }
                self.isLoadingMore = false
            }
        }
    }
    
    //判断加载的数据。
    private func handleLoadMoreWeiboList(_ list: WeiboList, for category: WeiboListCategory) {
        switch category {
        case .recommend:
            for weibo in list.list {
                if recommendWeiboDic[weibo.id] != nil { continue }
                recommendWeiboList.list.append(weibo)
                recommendWeiboDic[weibo.id] = recommendWeiboList.list.count - 1
            }
        case .hot:
            for weibo in list.list {
                if hotWeiboDic[weibo.id] != nil { continue }
                hotWeiboList.list.append(weibo)
                hotWeiboDic[weibo.id] = hotWeiboList.list.count - 1
            }
        }
        
    }
}
