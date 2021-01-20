//
//  ContentView.swift
//  sicnu_exercise
//
//  Created by apple on 2020/12/30.
//

import SwiftUI

struct WeiboCell: View {
    let user:User
    
    var body: some View {
        //微博主体
        VStack(alignment: .leading, spacing: nil){
            
            //用户信息
            HStack(spacing:5){
                //头像
                loadImage(name: user.avatar)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay(
                        VIPPattern(isVIP: user.vip)
                    )
                
                //用户数据
                VStack(alignment: .leading, spacing: 5){
                    Text(user.name)
                        .font(Font.system(size: 16))
                        .foregroundColor(Color(red: 242/255, green: 99/255, blue: 4/255))
                        .lineLimit(1)
                    Text(user.date)
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                }
                .padding(.leading,10)
                
                //关注按钮
                if !user.isFollowed{
                    Spacer()
                    Button(action:{
                           print("CLick button")
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
            Text(user.text)
                .font(.system(size: 17))
            if !user.images.isEmpty {
                UserImagesCell(images: user.images, width: UIScreen.main.bounds.width - 30)
            }
            Divider()
            
            //微博按钮
            HStack(spacing: 0){
                Spacer()
                UserCellTollBar(image: "message", text: user.commentCountText, color: .black) {
                    print("Click comment button")
                }
                Spacer()
                UserCellTollBar(image: "heart", text: user.likeCountText, color: .black){
                    print("Click like button")
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
        WeiboCell(user: userList.list[5])
    }
}
