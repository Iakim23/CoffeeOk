//
//  NavBarView.swift
//  CoffeeOk
//
//  Created by Iakim Boiunets on 18/12/2025.
//

import SwiftUI

struct NavBarView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                NavBarButton(
                    icon: "person.2.fill",
                    title: "Люди",
                    isActive: viewModel.currentScreen == .users
                ) {
                    viewModel.navigate(to: .users)
                }
                
                NavBarButton(
                    icon: "cup.and.saucer.fill",
                    title: "Кофейни",
                    isActive: viewModel.currentScreen == .coffeeshops
                ) {
                    viewModel.navigate(to: .coffeeshops)
                }
                
                NavBarButton(
                    icon: "square.grid.2x2.fill",
                    title: "Posts",
                    isActive: viewModel.currentScreen == .posts
                ) {
                    viewModel.navigate(to: .posts)
                }
                
                NavBarButton(
                    icon: "heart.fill",
                    title: "Подписки",
                    isActive: viewModel.currentScreen == .subscriptions
                ) {
                    viewModel.navigate(to: .subscriptions)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 9)
            .frame(height: 39)
        }
        .background(
            ZStack {
                Color(hex: "181818").opacity(1.0)
                    .background(.ultraThinMaterial)
            }
            .ignoresSafeArea(.all, edges: .bottom)
        )
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.white.opacity(0.05)),
            alignment: .top
        )
    }
}

struct NavBarButton: View {
    let icon: String
    let title: String
    let isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 26))
                    .foregroundColor(isActive ? .white : Color(hex: "8e8e93"))
                
                Text(title)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(isActive ? .white : Color(hex: "8e8e93"))
                    .tracking(0.25)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

