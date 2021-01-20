//
//  WeiboDetailView.swift
//  sicnu_exercise
//  微博详情页
//  Created by apple on 2021/1/8.
//

import SwiftUI
import BBSwiftUIKit

struct WeiboDetailView: View {
    let weibo: Weibo
    
    var body: some View {
        BBTableView(0...10) { i in
            if i == 0 {
                WeiboCell(weibo: weibo)
            } else {
                HStack {
                    Text("评论\(i)").padding()
                    Spacer()
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle("微博详情",displayMode: .inline)
        .buttonStyle(OriginalButtonStyle())
    }
}

struct WeiboDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        return WeiboDetailView(weibo: userData.recommendWeiboList.list[0]).environmentObject(userData)
    }
}
