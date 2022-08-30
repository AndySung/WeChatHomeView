//
//  WeChatHomeViewApp.swift
//  WeChatHomeView
//
//  Created by Andy on 2022/8/24.
//

import SwiftUI

@main
struct WeChatHomeViewApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(UserData())
        }
    }
}
