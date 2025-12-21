# CoffeeOk iOS App

Нативное iOS приложение CoffeeOk, переписанное с React/TypeScript на Swift/SwiftUI для сборки через Xcode.

## Структура проекта

```
CoffeeOk/
├── CoffeeOkApp.swift          # Точка входа приложения
├── Models/                    # Модели данных
│   ├── User.swift
│   ├── CoffeeShop.swift
│   └── Post.swift
├── Views/                     # SwiftUI экраны
│   ├── AuthView.swift
│   ├── NavBarView.swift
│   ├── UsersView.swift
│   ├── PostsView.swift
│   ├── CoffeeShopsView.swift
│   ├── UserProfileView.swift
│   ├── CoffeeShopProfileView.swift
│   └── SubscriptionsView.swift
├── ViewModels/                # View Models
│   └── AppViewModel.swift
├── Data/                      # Mock данные
│   └── MockData.swift
├── Assets.xcassets/           # Ресурсы
└── Info.plist                # Конфигурация приложения
```

## Требования

- Xcode 15.0 или выше
- iOS 17.0 или выше
- Swift 5.0

## Установка и сборка

1. Откройте `CoffeeOk.xcodeproj` в Xcode
2. Выберите симулятор или устройство для запуска
3. Нажмите ⌘R для сборки и запуска

## Особенности

- ✅ Полностью нативный SwiftUI код
- ✅ Все экраны из оригинального React приложения
- ✅ Сохранен дизайн и функциональность
- ✅ Навигация между экранами
- ✅ Работа с mock данными
- ✅ Поддержка темной темы

## Основные компоненты

### Модели
- `User` - модель пользователя
- `CoffeeShop` - модель кофейни
- `Post` - модель поста с поддержкой автора (User или CoffeeShop)

### Экраны
- `AuthView` - экран авторизации
- `UsersView` - список пользователей
- `PostsView` - лента постов
- `CoffeeShopsView` - список кофеен
- `UserProfileView` - профиль пользователя
- `CoffeeShopProfileView` - профиль кофейни
- `SubscriptionsView` - подписки

### Навигация
- `NavBarView` - нижняя навигационная панель
- `AppViewModel` - управление состоянием и навигацией

## Примечания

- Приложение использует mock данные из `MockData.swift`
- Для загрузки изображений используется `AsyncImage` (требует iOS 15+)
- Все цвета определены через расширение `Color` с поддержкой hex значений
- Настройки безопасности сети в `Info.plist` разрешают загрузку изображений с внешних URL



