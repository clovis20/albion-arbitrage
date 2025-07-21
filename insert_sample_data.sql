-- CIDADES
INSERT INTO cities (id, name, code) VALUES
  (1, 'Bridgewatch', 'BRIDGEWATCH'),
  (2, 'Martlock', 'MARTLOCK');

-- INGREDIENTES DE ALQUIMIA
INSERT INTO alchemy_ingredients (id, name, tier, quality, transmutation_result) VALUES
  (1, 'T3_RESOURCE_SHADOW', 3, 'Normal', NULL),
  (2, 'T5_RESOURCE_SHADOW', 5, 'Normal', NULL),
  (3, 'T7_RESOURCE_SHADOW', 7, 'Normal', NULL);

-- PREÇOS DE MERCADO
INSERT INTO market_prices (item_type_id, city_id, quality, sell_price_min, sell_price_max, buy_price_max)
VALUES
  ('T3_RESOURCE_SHADOW', 1, 1, 1000, 1200, 1100),
  ('T5_RESOURCE_SHADOW', 1, 1, 3000, 3500, 3200),
  ('T7_RESOURCE_SHADOW', 1, 1, 7000, 7500, 7200),
  ('T3_RESOURCE_SHADOW', 2, 1, 1100, 1300, 1200),
  ('T5_RESOURCE_SHADOW', 2, 1, 3200, 3700, 3400),
  ('T7_RESOURCE_SHADOW', 2, 1, 7200, 7700, 7400);

-- OPORTUNIDADES DE ARBITRAGEM
INSERT INTO arbitrage_opportunities (
  id, source_ingredient_id, target_ingredient_id, buy_city_id, sell_city_id,
  buy_price, sell_price, quantity_multiplier, gross_profit, net_profit, profit_margin, calculated_at
) VALUES
  ('1', 2, 1, 1, 2, 3000, 1200, 2, 400, 300, 10, NOW()),
  ('2', 3, 2, 2, 1, 7200, 3500, 2, 800, 600, 8, NOW()); 