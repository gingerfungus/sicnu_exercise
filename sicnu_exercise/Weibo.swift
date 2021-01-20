//
//  Weibo.swift
//  sicnu_exercise
//  微博数据解析
//  Created by apple on 2021/1/3.
//

import SwiftUI
import SDWebImageSwiftUI

struct WeiboList: Codable {
    var list:[Weibo]
}

//微博用户信息
struct Weibo: Codable, Identifiable {
    let id:Int  //用户id
    let avatar:String   //用户头像
    let vip:Bool    //是否是vip
    let name:String //用户姓名
    let date:String //发送日期
    var isFollowed:Bool   //是否关注
    
    let text:String //内容文本
    let images:[String] //内容图片
    
    var commentCount:Int    //评论数
    var likeCount:Int   //点赞数
    var isLiked:Bool    //是否点赞
    
}

extension Weibo: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

extension Weibo {
    //评论数显示文本,1000以内正常显示，大于10000采用1w、2w..的格式
    var commentCountText: String{
        if commentCount == 0 { return "评论" }
        if commentCount < 10000 { return "\(commentCount)" }
        return String(format: "%.1fw", Double(commentCount) / 10000)
    }
    
    //点赞数显示文本,1000以内正常显示，大于10000采用1w、2w..的格式
    var likeCountText: String{
        if likeCount == 0 { return "点赞" }
        if likeCount < 10000 { return "\(likeCount)" }
        return String(format: "%.1fw", Double(likeCount) / 10000)
    }
}


//解析微博用户数据文件
func loadWeiboListData(_ filename:String) -> WeiboList {
    guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Can't find \(filename) in main bundle")
    }
    
    guard let data = try? Data(contentsOf: url) else {
        fatalError("Can't load \(url)")
    }
    
    guard let list = try? JSONDecoder().decode(WeiboList.self, from: data) else {
        fatalError("Can't parse file to json data")
    }
    return list
}

//加载网络图片,采用SDWebImage开源库
func loadImage(name: String) -> WebImage {
    WebImage(url: URL(string: imagesURL + name))
        .placeholder { Color.gray }
}
