//
//  CoffeeOkApp.swift
//  CoffeeOk
//
//  Created by Iakim Boiunets on 18/12/2025.
//

import SwiftUI

@main
struct CoffeeOkApp: App {
    @StateObject private var viewModel = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            if viewModel.isAuthenticated {
                if viewModel.selectedRole == .coffeeShop {
                    CoffeeShopMainView()
                        .environmentObject(viewModel)
                } else {
                MainView()
                    .environmentObject(viewModel)
                }
            } else {
                AuthView()
                    .environmentObject(viewModel)
            }
        }
    }
}



