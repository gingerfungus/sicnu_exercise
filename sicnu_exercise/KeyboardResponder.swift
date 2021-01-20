//
//  KeyboardResponder.swift
//  sicnu_exercise
//  键盘控制
//  Created by apple on 2021/1/10.
//

import SwiftUI

class KeyboardResponder: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    
    var keyboardShow: Bool { keyboardHeight > 0 }
    
    init() {
        //监听键盘弹出与消失
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIWindow.keyboardWillShowNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //键盘即将出现
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIWindow.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        keyboardHeight = frame.height
    }
    
    //键盘即将隐藏
    @objc private func keyboardWillHide(_ notification: Notification) {
        keyboardHeight = 0
    }
}
