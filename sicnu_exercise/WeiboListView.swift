//
//  WeiboListView.swift
//  sicnu_exercise
//  微博列表显示
//  Created by apple on 2021/1/4.
//

import SwiftUI
import BBSwiftUIKit

struct WeiboListView: View {
    let category: WeiboListCategory
    
    @EnvironmentObject var userData: UserData
    
    var body: some View{
        BBTableView(userData.weiboList(for: category).list) { weibo in
            NavigationLink(destination: WeiboDetailView(weibo: weibo)) {
                WeiboCell(weibo: weibo)
            }
            .buttonStyle(OriginalButtonStyle())
        }
//        下拉刷新
        .bb_setupRefreshControl { control in
            control.attributedTitle = NSAttributedString(string: "刷新中..")
        }
        .bb_pullUpToLoadMore(bottomSpace: 30) {
            userData.loadMoreWeiboList(for: category)
        }
//        上拉加载内容
        .bb_pullDownToRefresh(isRefreshing: $userData.isRefreshing) {
            userData.refreshWeiboList(for: category)
        }
        .bb_reloadData($userData.reloadData)

//        List {
//            ForEach(userData.weiboList(for: category).list) { weibo in
//                ZStack {
//                    WeiboCell(weibo: weibo)
//                    NavigationLink(
//                        destination: WeiboDetailView(weibo: weibo)){
//                        EmptyView()
//                    }
//                    .hidden()
//                }
//                .listRowInsets(EdgeInsets())
//            }
//        }
    }
}


struct WeiboListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            WeiboListView(category: .hot)
                .navigationBarTitle("首页")
                .navigationBarHidden(true)
        }
        .environmentObject(UserData())
    }
}
