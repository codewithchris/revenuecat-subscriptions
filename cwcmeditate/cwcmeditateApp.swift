//
//  cwcmeditateApp.swift
//  cwcmeditate
//
//  Created by Chris Ching on 2022-06-28.
//

import SwiftUI
import RevenueCat

@main
struct cwcmeditateApp: App {
    
    @StateObject var userViewModel = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .environmentObject(userViewModel)
        }
    }
    
    init() {
        
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "YOUR_OWN_API_KEY_FROM_REVENUECAT.COM")
    }
}
