# Feed API Logic — CoffeeOk

## Goal

Показать пользователю персональный feed,
основанный на людях, которым он доверяет,
а не на рейтингах или алгоритмах вовлечения.

---

## Core Principle

Feed = posts from:

1. Users I follow
2. (опционально) Coffee shops I follow
3. + мой собственный контент

Без рекомендаций «от платформы».

---

## Entities Used

+ users

+ posts
+ subscriptions
+ coffee_shops

---

## Subscription Logic

### Subscriptions table

```text
user_id        — кто подписался
target_type    — 'user' | 'coffee_shop'
target_id      — на кого подписался
