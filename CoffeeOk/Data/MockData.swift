//
//  MockData.swift
//  CoffeeOk
//
//  Created by Iakim Boiunets on 18/12/2025.
//

import Foundation

struct MockData {
    static let users: [User] = [
        User(
            id: "1",
            name: "Алекс",
            avatar: "https://i.pravatar.cc/150?img=12",
            bio: "Люблю фильтр и маленькие кофейни",
            city: "Москва",
            joinedAt: "2025-12-01"
        ),
        User(
            id: "2",
            name: "Мария Петрова",
            avatar: "https://i.pravatar.cc/150?img=2",
            bio: "Бариста с 5-летним опытом",
            city: "Санкт-Петербург",
            joinedAt: "2025-11-15"
        ),
        User(
            id: "3",
            name: "Алексей Сидоров",
            avatar: "https://i.pravatar.cc/150?img=3",
            bio: "Кофейный энтузиаст",
            city: "Москва",
            joinedAt: "2025-10-20"
        ),
        User(
            id: "4",
            name: "Елена Козлова",
            avatar: "https://i.pravatar.cc/150?img=4",
            bio: "Фотограф кофейной культуры",
            city: "Казань",
            joinedAt: "2025-09-10"
        ),
    ]
    
    static let coffeeShops: [CoffeeShop] = [
        CoffeeShop(
            id: "shop1",
            name: "Surf Coffee x Mussen",
            avatar: "https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800",
            address: "ул. Большая Покровская, 52",
            city: "Нижний Новгород",
            description: "Атмосферное место с виниловой музыкой, тропическим интерьером и лучшим флэт-уайтом в городе. Идеально подходит как для утренней работы с ноутбуком, так и для вечерних встреч с друзьями. В меню есть веганские десерты.",
            categories: "Спешелти кофейня • Центр • Wi-Fi",
            rating: 4.8,
            isPartner: true,
            loyaltyEnabled: true,
            galleryImage: "https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=400",
            workingHours: "Ежедневно 08:00 – 23:00",
            isOpenNow: true,
            closesAt: "23:00"
        ),
        CoffeeShop(
            id: "shop1_old",
            name: "Черный Зерно",
            avatar: "https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800",
            address: "ул. Ленина, 12",
            city: "Москва",
            description: "Уютная кофейня с обжаркой",
            categories: "ЭСПРЕССО, ЛАТТЕ",
            rating: 4.8,
            isPartner: true,
            loyaltyEnabled: true,
            galleryImage: "https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=400",
            workingHours: "Ежедневно 09:00 – 22:00",
            isOpenNow: true,
            closesAt: "22:00"
        ),
        CoffeeShop(
            id: "shop2",
            name: "Brew & Bean",
            avatar: "https://images.unsplash.com/photo-1501339847302-ac426a4c7c98?w=800",
            address: "пр. Мира, 25",
            city: "Москва",
            description: "Современная кофейня с авторскими напитками",
            categories: "КАПУЧИНО, ФЛАТ УАЙТ",
            rating: 4.6,
            isPartner: false,
            loyaltyEnabled: true,
            galleryImage: "https://images.unsplash.com/photo-1517487881594-2787fef5ebf7?w=400",
            workingHours: "Ежедневно 08:00 – 21:00",
            isOpenNow: true,
            closesAt: "21:00"
        ),
        CoffeeShop(
            id: "shop3",
            name: "Café Central",
            avatar: "https://images.unsplash.com/photo-1442512595331-e89e73853f31?w=800",
            address: "ул. Пушкина, 10",
            city: "Санкт-Петербург",
            description: "Европейская атмосфера и качественный кофе",
            categories: "ЭСПРЕССО, АМЕРИКАНО",
            rating: 4.7,
            isPartner: true,
            loyaltyEnabled: false,
            galleryImage: "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400",
            workingHours: "Ежедневно 09:00 – 23:00",
            isOpenNow: true,
            closesAt: "23:00"
        ),
    ]
    
    static let posts: [Post] = [
        Post(
            id: "post1",
            text: "Отличный капучино в новом месте! ☕️",
            imageUrl: "https://images.unsplash.com/photo-1517487881594-2787fef5ebf7?w=800",
            author: .user(users[0]),
            likes: 24,
            comments: 5,
            createdAt: Date().addingTimeInterval(-3600)
        ),
        Post(
            id: "post2",
            text: "Сегодня в меню новый сорт эспрессо из Эфиопии",
            imageUrl: "https://images.unsplash.com/photo-1517487881594-2787fef5ebf7?w=800",
            author: .coffeeShop(coffeeShops[0]),
            likes: 45,
            comments: 12,
            createdAt: Date().addingTimeInterval(-7200)
        ),
        Post(
            id: "post3",
            text: "Утро начинается с кофе ☀️",
            imageUrl: nil,
            author: .user(users[1]),
            likes: 18,
            comments: 3,
            createdAt: Date().addingTimeInterval(-1800)
        ),
        Post(
            id: "post4",
            text: "Приглашаем на дегустацию новых сортов!",
            imageUrl: "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800",
            author: .coffeeShop(coffeeShops[1]),
            likes: 32,
            comments: 8,
            createdAt: Date().addingTimeInterval(-5400)
        ),
    ]
    
    static let subscriptions: [Post] = posts
    
    static func getComments(for postId: String) -> [Comment] {
        switch postId {
        case "post1":
            return [
                Comment(
                    id: "comment1",
                    text: "Согласен, отличное место!",
                    author: users[1],
                    createdAt: Date().addingTimeInterval(-1800),
                    likes: 3
                ),
                Comment(
                    id: "comment2",
                    text: "Был там на прошлой неделе, очень понравилось",
                    author: users[2],
                    createdAt: Date().addingTimeInterval(-1200),
                    likes: 1
                ),
                Comment(
                    id: "comment3",
                    text: "Какой адрес?",
                    author: users[3],
                    createdAt: Date().addingTimeInterval(-900),
                    likes: 0
                ),
                Comment(
                    id: "comment4",
                    text: "Обязательно зайду!",
                    author: users[0],
                    createdAt: Date().addingTimeInterval(-600),
                    likes: 2
                ),
                Comment(
                    id: "comment5",
                    text: "Фото классное!",
                    author: users[1],
                    createdAt: Date().addingTimeInterval(-300),
                    likes: 5
                )
            ]
        case "post2":
            return [
                Comment(
                    id: "comment6",
                    text: "Интересно, какой вкус?",
                    author: users[0],
                    createdAt: Date().addingTimeInterval(-3600),
                    likes: 2
                ),
                Comment(
                    id: "comment7",
                    text: "Обязательно попробую",
                    author: users[2],
                    createdAt: Date().addingTimeInterval(-2400),
                    likes: 1
                )
            ]
        default:
            return []
        }
    }
}


