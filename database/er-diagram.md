# ER Diagram (Text)

PK — Primary Key (unique identifier)
FK — Foreign Key (reference to another table)

Users (PK id)
CoffeeShops (PK id)
Posts (PK id, FK author_id → Users.id)
Subscriptions (FK user_id → Users.id)
...
