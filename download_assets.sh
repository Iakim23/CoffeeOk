#!/bin/bash

# Создаем структуру папок
mkdir -p "/Users/iakim/Desktop/iOS CoffeeOk App/CoffeeOk/Assets.xcassets/Images"
cd "/Users/iakim/Desktop/iOS CoffeeOk App/CoffeeOk/Assets.xcassets/Images"

# Создаем imageset папки
mkdir -p coffee-main-showcase.imageset latte.imageset ise-latte.imageset capucino.imageset matcha.imageset matcha-latte.imageset matcha-cappuccino.imageset lyra-icon-17-edit.imageset navigation-showcase-icon.imageset notifications-icon.imageset people-icon.imageset insights-icon.imageset menu-card-line.imageset showcase-tab-vector.imageset vector-clock.imageset

# Скачиваем файлы
echo "Скачиваю coffee-main-showcase..."
curl --insecure -o "coffee-main-showcase.imageset/coffee-main-showcase.png" "https://www.figma.com/api/mcp/asset/36cddb69-e101-4d15-bbb7-dac9f70298ff"

echo "Скачиваю latte..."
curl --insecure -o "latte.imageset/latte.png" "https://www.figma.com/api/mcp/asset/98ad2c9f-c45b-47fd-963b-62f240c13a65"

echo "Скачиваю ise-latte..."
curl --insecure -o "ise-latte.imageset/ise-latte.png" "https://www.figma.com/api/mcp/asset/6b0d4e90-9a53-4f3c-bdc5-de3400dc8534"

echo "Скачиваю capucino..."
curl --insecure -o "capucino.imageset/capucino.png" "https://www.figma.com/api/mcp/asset/17b3d342-6368-49a6-9e18-b2f4d7e328da"

echo "Скачиваю matcha..."
curl --insecure -o "matcha.imageset/matcha.png" "https://www.figma.com/api/mcp/asset/a5a76b04-4cb0-4900-9a4f-411bdf1c842e"

echo "Скачиваю matcha-latte..."
curl --insecure -o "matcha-latte.imageset/matcha-latte.png" "https://www.figma.com/api/mcp/asset/43175d17-74cc-4ce4-8e7e-20eddd52f415"

echo "Скачиваю matcha-cappuccino..."
curl --insecure -o "matcha-cappuccino.imageset/matcha-cappuccino.png" "https://www.figma.com/api/mcp/asset/e0c1bda1-5427-435b-a751-c784261f20f1"

echo "Скачиваю lyra-icon-17-edit..."
curl --insecure -o "lyra-icon-17-edit.imageset/lyra-icon-17-edit.png" "https://www.figma.com/api/mcp/asset/295b473c-aba1-4687-9641-e55b1ca29350"

echo "Скачиваю navigation-showcase-icon..."
curl --insecure -o "navigation-showcase-icon.imageset/navigation-showcase-icon.png" "https://www.figma.com/api/mcp/asset/d14c57ba-bb14-4345-b109-ddf7ff1fe732"

echo "Скачиваю notifications-icon..."
curl --insecure -o "notifications-icon.imageset/notifications-icon.png" "https://www.figma.com/api/mcp/asset/187a5d8d-22ad-4fb9-a00d-42b2304f6c85"

echo "Скачиваю people-icon..."
curl --insecure -o "people-icon.imageset/people-icon.png" "https://www.figma.com/api/mcp/asset/6ee1ef5a-5798-4b06-8ad5-879c3619290d"

echo "Скачиваю insights-icon..."
curl --insecure -o "insights-icon.imageset/insights-icon.png" "https://www.figma.com/api/mcp/asset/441ad6ac-c890-4f7d-9c13-e763c5c4baad"

echo "Скачиваю menu-card-line..."
curl --insecure -o "menu-card-line.imageset/menu-card-line.png" "https://www.figma.com/api/mcp/asset/ebbe1226-cdca-420b-9b06-641cde8b7e22"

echo "Скачиваю showcase-tab-vector..."
curl --insecure -o "showcase-tab-vector.imageset/showcase-tab-vector.png" "https://www.figma.com/api/mcp/asset/e57929e8-ec0e-4584-9ac6-81fc5755ea8d"

echo "Скачиваю vector-clock..."
curl --insecure -o "vector-clock.imageset/vector-clock.png" "https://www.figma.com/api/mcp/asset/eaff341a-bb0a-4bb8-8f12-7449e6be6035"

# Создаем Contents.json для каждой imageset папки
for dir in *.imageset; do
  image_name=$(basename "$dir" .imageset)
  cat > "$dir/Contents.json" << EOF
{
  "images" : [
    {
      "filename" : "$image_name.png",
      "idiom" : "universal",
      "scale" : "1x"
    },
    {
      "idiom" : "universal",
      "scale" : "2x"
    },
    {
      "idiom" : "universal",
      "scale" : "3x"
    }
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  },
  "properties" : {
    "preserves-vector-representation" : false
  }
}
EOF
done

echo "Готово!"
