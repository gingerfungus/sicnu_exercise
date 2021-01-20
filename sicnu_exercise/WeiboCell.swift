//
//  ContentView.swift
//  sicnu_exercise
//  微博单元组件
//  Created by apple on 2020/12/30.
//

import SwiftUI

struct WeiboCell: View {
    
    @EnvironmentObject var userData: UserData
    
    @State var presentcomment: Bool = false
    
    let weibo:Weibo
    
    var bindingWeibo: Weibo {
        userData.weibo(forID: weibo.id)!
    }
    
    var body: some View {
        var weibo = bindingWeibo
        
        //微博主体
        return VStack(alignment: .leading, spacing: nil){
            //用户信息
            HStack(spacing:5){
                //头像
                loadImage(name: weibo.avatar)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50, alignment: .center)
                    .clipShape(Circle())
                    .overlay(
                        VIPPattern(isVIP: weibo.vip)
                    )
                
                //用户数据
                VStack(alignment: .leading, spacing: 5){
                    Text(weibo.name)
                        .font(Font.system(size: 16))
                        .foregroundColor(Color(red: 242/255, green: 99/255, blue: 4/255))
                        .lineLimit(1)
                    Text(weibo.date)
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                }
                .padding(.leading,10)
                
                //关注按钮
                if !weibo.isFollowed{
                    Spacer()
                    Button(action:{
                        weibo.isFollowed = true
                        userData.updata(weibo)
                    }){
                        Text("关注")
                            .font(.system(size: 14))
                            .foregroundColor(.orange)
                            .frame(width: 50, height: 26)
                            .overlay(
                                RoundedRectangle(cornerRadius: 13)
                                    .stroke(Color.orange, lineWidth: 1)
                            )
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            
            //微博正文
            Text(weibo.text)
                .font(.system(size: 17))
            if !weibo.images.isEmpty {
                WeiboImagesCell(images: weibo.images, width: UIScreen.main.bounds.width - 30)
            }
            Divider()
            
            //微博评论、点赞按钮
            HStack(spacing: 0){
                Spacer()
                
                WeiboCellTollBar(image: "message", text: weibo.commentCountText, color: .black) {
                    presentcomment = true
                }.sheet(isPresented: $presentcomment) {
                    CommentInputView(weibo: weibo).environmentObject(userData)
                }
                
                Spacer()
                
                WeiboCellTollBar(image: weibo.isLiked ? "heart.fill" : "heart", text: weibo.likeCountText, color: weibo.isLiked ?.red : .black)
                {
                    if weibo.isLiked {
                        weibo.isLiked = false
                        weibo.likeCount -= 1
                    }
                    else {
                        weibo.isLiked = true
                        weibo.likeCount += 1
                    }
                    userData.updata(weibo)
                }
                
                Spacer()
            }
            
            Rectangle()
                .padding(.horizontal, -15)
                .frame(height:10)
                .foregroundColor(Color(red: 238/255, green: 238/255, blue: 238/255))
            
        }
        .padding(.horizontal,15)
        .padding(.top, 15)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        
        return WeiboCell(weibo: userData.recommendWeiboList.list[0]).environmentObject(userData)
    }
}
