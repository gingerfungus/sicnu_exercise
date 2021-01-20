//
//  Sicnu_ExerciseApp.swift
//  sicnu_exercise
//
//  Created by apple on 2020/12/30.
//

import SwiftUI

@main
struct Sicnu_ExerciseApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(UserData())
        }
    }
}
