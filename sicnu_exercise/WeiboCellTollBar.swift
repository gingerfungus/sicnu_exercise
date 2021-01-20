//
//  WeiboCellTollBar.swift
//  sicnu_exercise
//  微博按钮
//  Created by apple on 2021/1/4.
//

import SwiftUI

struct WeiboCellTollBar: View {
    let image: String   //按钮图标
    let text: String    //按钮文字
    let color: Color    //按钮颜色
    let action: () -> Void  //点击效果
    
    var body: some View {
        Button(action: action){
            HStack(spacing:5){
                Image(systemName: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 18, height: 18, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text(text)
                    .font(.system(size: 15))
            }
            .foregroundColor(color)
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}

struct WeiboCellTollBar_Previews: PreviewProvider {
    static var previews: some View {
        WeiboCellTollBar(image: "heart", text: "点赞", color: .red){
            print("Click like button")
        }
    }
}
