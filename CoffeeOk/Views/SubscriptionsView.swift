//
//  SubscriptionsView.swift
//  CoffeeOk
//
//  Created by Iakim Boiunets on 18/12/2025.
//

import SwiftUI

struct SubscriptionsView: View {
    let subscriptions = MockData.subscriptions
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(subscriptions) { subscription in
                    SubscriptionRow(subscription: subscription)
                }
            }
            .padding()
        }
        .background(Color.black)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Подписки")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            }
        }
    }
}

struct SubscriptionRow: View {
    let subscription: Post
    
    var body: some View {
        PostCard(post: subscription)
    }
}



