//
//  ComingSoonView.swift
//  CoffeeOk
//
//  Created by Iakim Boiunets on 22/12/2025.
//

import SwiftUI

struct ComingSoonView: View {
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        ZStack {
            Color(hex: "#0e0e11").ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                // Иконка
                Image(systemName: "cup.and.saucer.fill")
                    .font(.system(size: 80))
                    .foregroundColor(Color(hex: "#8b2d6b"))

                // Заголовок
                Text("Coming soon")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)

                // Описание
                Text("Функционал для владельцев кофеен\nпоявится в ближайшее время")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)

                Spacer()

                // Кнопка назад
                Button(action: {
                    viewModel.showComingSoon = false
                    viewModel.showRoleSelection = true
                }) {
                    Text("Выбрать другую роль")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color(hex: "#8b2d6b"))
                        .cornerRadius(12)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 50)
            }
        }
    }
}
