//
//  AppViewModel.swift
//  CoffeeOk
//
//  Created by Iakim Boiunets on 18/12/2025.
//

import SwiftUI

enum UserRole {
    case coffeeShop
    case coffeeLover
}

enum Screen: Equatable {
    case posts
    case users
    case coffeeshops
    case subscriptions
    case userProfile(String)
    case coffeeShopProfile(String)
    case comments(String)
    
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        switch (lhs, rhs) {
        case (.posts, .posts),
             (.users, .users),
             (.coffeeshops, .coffeeshops),
             (.subscriptions, .subscriptions):
            return true
        case (.userProfile(let lhsId), .userProfile(let rhsId)):
            return lhsId == rhsId
        case (.coffeeShopProfile(let lhsId), .coffeeShopProfile(let rhsId)):
            return lhsId == rhsId
        case (.comments(let lhsId), .comments(let rhsId)):
            return lhsId == rhsId
        default:
            return false
        }
    }
}

class AppViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentScreen: Screen = .posts
    @Published var selectedUserId: String?
    @Published var selectedShopId: String?
    @Published var selectedPostId: String?

    // Состояние для выбора роли
    @Published var showRoleSelection = true
    @Published var showRegistration = false
    @Published var showComingSoon = false
    @Published var showCoffeeShopRegistration = false
    @Published var showCoffeeShopMain = false
    @Published var selectedRole: UserRole?
    
    func authenticate() {
        isAuthenticated = true
        currentScreen = .posts
    }
    
    func navigate(to screen: Screen) {
        currentScreen = screen
    }
    
    func selectUser(_ userId: String) {
        selectedUserId = userId
        currentScreen = .userProfile(userId)
    }
    
    func selectShop(_ shopId: String) {
        selectedShopId = shopId
        currentScreen = .coffeeShopProfile(shopId)
    }
    
    func selectPost(_ postId: String) {
        selectedPostId = postId
        currentScreen = .comments(postId)
    }
    
    func goBack() {
        switch currentScreen {
        case .userProfile:
            currentScreen = .users
            selectedUserId = nil
        case .coffeeShopProfile:
            currentScreen = .coffeeshops
            selectedShopId = nil
        case .comments:
            currentScreen = .posts
            selectedPostId = nil
        default:
            break
        }
    }
}

struct MainView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    // Контент экрана
                    Group {
                        switch viewModel.currentScreen {
                        case .posts:
                            PostsView()
                        case .users:
                            UsersView()
                        case .coffeeshops:
                            CoffeeShopsView()
                        case .subscriptions:
                            SubscriptionsView()
                        case .userProfile(let userId):
                            UserProfileView(userId: userId)
                        case .coffeeShopProfile(let shopId):
                            CoffeeShopProfileView(shopId: shopId)
                        case .comments(let postId):
                            CommentsView(postId: postId)
                        }
                    }
                    .frame(maxHeight: .infinity)
                    
                    // Навигационная панель (скрыта на профильных экранах)
                    if case .userProfile = viewModel.currentScreen {
                        EmptyView()
                    } else if case .coffeeShopProfile = viewModel.currentScreen {
                        EmptyView()
                    } else if case .comments = viewModel.currentScreen {
                        EmptyView()
                    } else {
                        NavBarView()
                            .environmentObject(viewModel)
                    }
                }
            }
        }
    }
}


