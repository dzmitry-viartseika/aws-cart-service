CREATE extension IF NOT exists "uuid-ossp";

CREATE TABLE carts (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  created_at date NOT NULL,
  updated_at date NOT NULL
)

CREATE TABLE cart_items (
  cart_id d uuid,
  product_id uuid,
  count integer,
  FOREIGN KEY ("cart_id") REFERENCES "carts" ("id")
)

INSERT INTO carts (created_at,updated_at) VALUES
(now(),now())

INSERT INTO cart_items (cart_id, product_id, count) VALUES
('wertey1', uuid_generate_v4(), 5),
('wertey2', uuid_generate_v4(), 11),
('wertey3', uuid_generate_v4(), 55)