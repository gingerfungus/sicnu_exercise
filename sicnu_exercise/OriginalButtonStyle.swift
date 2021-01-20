//
//  OriginalButtonStyle.swift
//  sicnu_exercise
//  按钮设置、主页点击整个微博组件不会对内部按钮产生事件
//  Created by apple on 2021/1/17.
//

import SwiftUI

struct OriginalButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
