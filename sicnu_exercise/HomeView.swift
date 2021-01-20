//
//  HomeView.swift
//  sicnu_exercise
//  主页面
//  Created by apple on 2021/1/8.
//

import SwiftUI

struct HomeView: View {
    @State var leftPercent : CGFloat = 0
    
    var body: some View {
        NavigationView {
            HScrollViewController(pageWidth: UIScreen.main.bounds.width,
                                  contentSize: CGSize(width: UIScreen.main.bounds.width * 2, height: UIScreen.main.bounds.height),
                                  leftPercent: self.$leftPercent) {
                HStack(spacing: 0) {
                    WeiboListView(category: .recommend)
                        .frame(width:UIScreen.main.bounds.width)
                    WeiboListView(category: .hot)
                        .frame(width:UIScreen.main.bounds.width)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarItems(leading: HomeNavigationBar(leftPercent: $leftPercent))
            .navigationBarTitle("首页",displayMode: .inline)

        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(UserData())
    }
}
