//
//  VIPPattern.swift
//  sicnu_exercise
//  微博vip图标
//  Created by apple on 2021/1/3.
//

import SwiftUI


struct VIPPattern: View {
    let isVIP:Bool
    var body:some View{
        if isVIP {
            Text("v")
                .bold()
                .font(.system(size: 13))
                .frame(width: 15, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.yellow)
                .background(Color.red)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .overlay(
                    RoundedRectangle(cornerRadius: 7.5)
                        .stroke(Color.white,lineWidth: 1)
                )
                .offset(x: 16, y: 16)
        }
    }
}


struct VIPPattern_Previews: PreviewProvider {
    static var previews: some View {
        VIPPattern(isVIP: true)
    }
}
