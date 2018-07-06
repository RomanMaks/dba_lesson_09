-- 1. Создайте в товарах поле типа jsonb для хранения различных 
--    характеристик товара. Например цвет (color), размер (size), 
--    вес (weight) и так далее, что вам придет в голову. Заполните
--    это поле различными характеристиками в виде json.

  ALTER TABLE products ADD characteristic jsonb NULL;

  update products
  SET characteristic = '{"color": "red", "size": "40", "gender": "female"}'
  WHERE id = 1 -- Кеды

  update products
  SET characteristic = '{"color": "green", "weight": "400"}'
  WHERE id = 5 -- Кружка

  update products
  SET characteristic = '{"color": "blue", "size": "XXL", "gender": "male"}'
  WHERE id = 14 -- Джинсы

  update products
  SET characteristic = '{"color": "red", "size": "XXL", "weight": "1300", "gender": "male"}'
  WHERE id = 11 -- Куртка

-- 2. Найдите товары:

  -- 1. У которых есть характеристика цвет, но нет размера
    SELECT products.characteristic
    FROM products
    WHERE characteristic ? 'color'
      AND NOT characteristic ? 'size'

  -- 2. У которых вес не более килограмма
    SELECT *
    FROM products
    WHERE (characteristic->>'weight')::integer <= 1000

  -- 3. Красного цвета и размера XXL
    SELECT *
    FROM products
    WHERE characteristic->>'color' = 'red' 
      AND characteristic->>'size' = 'XXL'

-- 3. Создайте материализированное представление, которое поля jsonb
--    превратит в столбцы (color, size, weight)

-- 4. * Используя оконные функции напишите запрос, который вернет все
--    товары и для каждого - его долю в процентах в общей стоимости
--    товаров такого же цвета (разумеется, речь про цену * количество).
--    Например: 
--    У вас 4 красных майки по 100 рублей и 3 красных кепки по 200 рублей.
--    Всего красных товаров на 1000 рублей. Из них майки - это 40%, а 
--    кепки - 60%