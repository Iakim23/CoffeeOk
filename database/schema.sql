-- =========================
-- CoffeeOk Database Schema
-- PostgreSQL
-- =========================
-- EXTENSIONS
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
-- =========================
-- USERS
-- =========================
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    avatar TEXT,
    bio TEXT,
    city TEXT,
    joined_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()
);
CREATE INDEX idx_users_city ON users(city);
-- =========================
-- COFFEE SHOPS
-- =========================
CREATE TABLE coffee_shops (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    city TEXT NOT NULL,
    address TEXT,
    photo TEXT,
    description TEXT,
    coffee_types TEXT [],
    -- example: ['espresso', 'filter']
    is_partner BOOLEAN DEFAULT FALSE,
    loyalty_enabled BOOLEAN DEFAULT FALSE,
    loyalty_limit INTEGER,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()
);
CREATE INDEX idx_coffee_shops_city ON coffee_shops(city);
CREATE INDEX idx_coffee_shops_partner ON coffee_shops(is_partner);
-- =========================
-- POSTS
-- =========================
CREATE TABLE posts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    author_id UUID NOT NULL,
    coffee_shop_id UUID,
    text TEXT,
    photo TEXT,
    likes_count INTEGER DEFAULT 0,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT fk_posts_author FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_posts_coffee_shop FOREIGN KEY (coffee_shop_id) REFERENCES coffee_shops(id) ON DELETE
    SET NULL
);
CREATE INDEX idx_posts_author ON posts(author_id);
CREATE INDEX idx_posts_coffee_shop ON posts(coffee_shop_id);
CREATE INDEX idx_posts_created_at ON posts(created_at DESC);
-- =========================
-- SUBSCRIPTIONS
-- user follows user OR coffee shop
-- =========================
CREATE TABLE subscriptions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    target_type TEXT NOT NULL CHECK (target_type IN ('user', 'coffee_shop')),
    target_id UUID NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT fk_subscriptions_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
CREATE INDEX idx_subscriptions_user ON subscriptions(user_id);
CREATE INDEX idx_subscriptions_target ON subscriptions(target_type, target_id);
-- =========================
-- BADGES
-- =========================
CREATE TABLE badges (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    icon TEXT,
    condition_type TEXT NOT NULL,
    condition_value INTEGER
);
-- =========================
-- USER BADGES
-- =========================
CREATE TABLE user_badges (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    badge_id UUID NOT NULL,
    earned_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT fk_user_badges_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_user_badges_badge FOREIGN KEY (badge_id) REFERENCES badges(id) ON DELETE CASCADE,
    CONSTRAINT uq_user_badge UNIQUE (user_id, badge_id)
);
-- =========================
-- LOYALTY CHECKS
-- =========================
CREATE TABLE loyalty_checks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    coffee_shop_id UUID NOT NULL,
    receipt_photo TEXT NOT NULL,
    approved BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT fk_loyalty_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_loyalty_coffee_shop FOREIGN KEY (coffee_shop_id) REFERENCES coffee_shops(id) ON DELETE CASCADE
);
CREATE INDEX idx_loyalty_user ON loyalty_checks(user_id);
CREATE INDEX idx_loyalty_shop ON loyalty_checks(coffee_shop_id);
-- =========================
-- REFERRALS
-- =========================
CREATE TABLE referrals (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    inviter_id UUID NOT NULL,
    invited_user_id UUID NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT fk_referrals_inviter FOREIGN KEY (inviter_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_referrals_invited FOREIGN KEY (invited_user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT uq_referral UNIQUE (inviter_id, invited_user_id)
);
-- =========================
-- END OF SCHEMA
-- =========================