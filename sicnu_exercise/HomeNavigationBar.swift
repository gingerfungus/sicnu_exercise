//
//  HomeNavigationBar.swift
//  sicnu_exercise
//  主页导航栏
//  Created by apple on 2021/1/8.
//

import SwiftUI

private let LableWidth:CGFloat = 41
private let ButtonWeight:CGFloat = 18

struct HomeNavigationBar: View {
    @Binding var leftPercent:CGFloat // 橙色下标移动位置，0为最左，1为最右
    
    var centerWidth:CGFloat = UIScreen.main.bounds.width * 0.5 //推荐、热门显示区域的宽度
    
    var body: some View {
        HStack{
            Button(action: {
                print("camera btn")
            }) {
                Image(systemName: "camera")
                    .resizable()
                    .scaledToFill()
                    .frame(width: ButtonWeight, height: ButtonWeight)
                    .padding(.horizontal, 15)
                    .padding(.top, 5)
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            VStack(alignment: .center, spacing: 0){
                HStack(spacing: 0) {
                    Text("推荐")
                        .bold()
                        .frame(width: LableWidth, height: LableWidth)
                        .padding(.top, 5)
                        .opacity(Double(1 - leftPercent * 0.5))
                        .onTapGesture {
                            withAnimation {
                                self.leftPercent = 0
                            }
                        }
                        
                    Spacer()
                    
                    Text("热门")
                        .bold()
                        .frame(width: LableWidth, height: LableWidth)
                        .padding(.top, 5)
                        .opacity(Double(0.5 + leftPercent * 0.5))
                        .onTapGesture {
                            withAnimation {
                                self.leftPercent = 1
                            }
                        }
                }
                .font(.system(size: 20))
                
                RoundedRectangle(cornerRadius: 2)
                    .foregroundColor(.orange)
                    .frame(width: LableWidth * 0.5, height: 4)
                    .offset(x: centerWidth * (leftPercent - 0.5) + LableWidth * (0.5 - leftPercent),y: -7)
            }
            .frame(width: centerWidth)
            
            Spacer()

            Button(action: {
                print("circle btn")
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: ButtonWeight, height: ButtonWeight)
                    .padding(.horizontal, 15)
                    .padding(.top, 5)
                    .foregroundColor(.orange)
            }
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}


struct HomeNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavigationBar(leftPercent: .constant(0))
    }
}
