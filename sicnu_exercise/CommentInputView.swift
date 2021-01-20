//
//  CommentInputView.swift
//  sicnu_exercise
//  评论页面
//  Created by apple on 2021/1/9.
//

import SwiftUI

struct CommentInputView: View {
    let weibo: Weibo
    
    @State private var text: String = ""
    @State private var showEmptyTextHUD: Bool = false
    
    @ObservedObject private var keyboardRenponder = KeyboardResponder()
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack(spacing: 0){
            CommentTextView(text: $text)
            
            HStack(spacing: 0) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("取消").padding()
                }
                
                Spacer()
                
                Button(action: {
                    if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        showEmptyTextHUD = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            showEmptyTextHUD = false
                        }
                        return
                    }
                    
                    var weibo = self.weibo
                    weibo.commentCount += 1
                    userData.updata(weibo)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("发送").padding()
                }
            }
            .font(.system(size: 18))
            .foregroundColor(.black)
        }
        .overlay(
            Text("评论不能为空")
                .opacity(showEmptyTextHUD ? 1 : 0)
                .animation(.easeInOut)
        )
        .padding(.bottom, keyboardRenponder.keyboardHeight)
        .edgesIgnoringSafeArea(keyboardRenponder.keyboardShow ? .bottom : [])
    }
}

struct CommentInputView_Previews: PreviewProvider {
    static var previews: some View {
        CommentInputView(weibo: UserData().recommendWeiboList.list[0])
    }
}
