//
//  CoffeeShopsView.swift
//  CoffeeOk
//
//  Created by Iakim Boiunets on 18/12/2025.
//

import SwiftUI

struct CoffeeShopsView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var searchText = ""
    
    let shops = MockData.coffeeShops
    
    private var filteredShops: [CoffeeShop] {
        if searchText.isEmpty {
            return shops
        }
        return shops.filter { shop in
            shop.name.localizedCaseInsensitiveContains(searchText) ||
            (shop.address?.localizedCaseInsensitiveContains(searchText) ?? false) ||
            (shop.city?.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                // Поисковая строка
                HStack(spacing: 12) {
                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                        
                        TextField("Поиск кофеен", text: $searchText)
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(Color(hex: "#1a1a1a"))
                    .cornerRadius(10)
                    
                    // Кнопка фильтра
                    Button(action: {}) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                            .frame(width: 44, height: 44)
                            .background(Color(hex: "#1a1a1a"))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                
                // Список кофеен
                ForEach(filteredShops) { shop in
                    CoffeeShopRow(shop: shop) {
                        viewModel.selectShop(shop.id)
                    }
                }
            }
            .padding(.bottom, 0) // Убираем лишний отступ снизу
        }
        .background(Color.black)
    }
}

struct CoffeeShopRow: View {
    let shop: CoffeeShop
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                AsyncImage(url: URL(string: shop.avatar ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.3))
                }
                .frame(width: 60, height: 60)
                .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(shop.name)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    if let address = shop.address {
                        Text(address)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .lineLimit(1)
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color(hex: "#1a1a1a"))
            .cornerRadius(12)
        }
    }
}


