#!/bin/bash

# Скрипт для быстрого запуска CoffeeOk в симуляторе

echo "☕ Запуск CoffeeOk в симуляторе..."
echo ""

# Путь к проекту
PROJECT_PATH="$(cd "$(dirname "$0")" && pwd)/CoffeeOk.xcodeproj"

# Проверка существования проекта
if [ ! -d "$PROJECT_PATH" ]; then
    echo "❌ Ошибка: Проект не найден по пути: $PROJECT_PATH"
    exit 1
fi

echo "📱 Открытие проекта в Xcode..."
open "$PROJECT_PATH"

echo ""
echo "✅ Проект открыт в Xcode!"
echo ""
echo "📝 Следующие шаги:"
echo "   1. Выберите симулятор (например, iPhone 15 Pro)"
echo "   2. Нажмите ⌘R для запуска"
echo ""

