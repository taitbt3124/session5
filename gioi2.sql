create schema gioi2;

CREATE TABLE gioi2.customers (
   customer_id SERIAL PRIMARY KEY,
   customer_name VARCHAR(100),
   city VARCHAR(50)
);

CREATE TABLE gioi2.orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES gioi2.customers(customer_id),
    order_date DATE,
    total_amount NUMERIC(10,2)
);

CREATE TABLE gioi2.order_items (
     item_id SERIAL PRIMARY KEY,
     order_id INT REFERENCES gioi2.orders(order_id),
     product_name VARCHAR(100),
     quantity INT,
     price NUMERIC(10,2)
);

INSERT INTO gioi2.customers (customer_name, city) VALUES
    ('Trần Văn An', 'Hà Nội'),
    ('Lê Thị Bao', 'Đà Nẵng'),
    ('Nguyễn Văn Cường', 'TP. Hồ Chí Minh'),
    ('Phạm Minh Dung', 'Hải Phòng'),
    ('Hoàng Anh Én', 'Cần Thơ'),
    ('Trần Văn A', 'Hà Nội'),
    ('Lê Thị B', 'Đà Nẵng'),
    ('Nguyễn Văn C', 'TP. Hồ Chí Minh'),
    ('Phạm Minh D', 'Hải Phòng'),
    ('Hoàng Anh E', 'Cần Thơ');

INSERT INTO gioi2.orders (customer_id, order_date, total_amount) VALUES
    (1, '2024-10-05', 1500000.00),
    (2, '2024-10-15', 2000000.00),
    (3, '2024-11-01', 500000.00),
    (4, '2024-10-20', 1200000.00),
    (5, '2025-01-10', 3000000.00),
    (6, '2024-10-25', 4500000.00),
    (1, '2024-10-20', 250000.00),
    (2, '2024-11-05', 150000.00),
    (3, '2024-12-12', 5500000.00),
    (1, '2024-11-15', 300000.00),
    (6, '2024-12-01', 800000.00),
    (4, '2025-01-20', 1200000.00);

INSERT INTO gioi2.order_items (order_id, product_name, quantity, price) VALUES
    (1, 'Bàn phím cơ', 2, 500000.00),
    (1, 'Chuột không dây', 1, 500000.00),
    (2, 'Màn hình Dell', 1, 2000000.00),
    (3, 'Sạc dự phòng', 4, 125000.00),
    (4, 'Tai nghe Gaming', 1, 1200000.00),
    (6, 'Laptop Asus', 1, 4000000.00),
    (6, 'Túi chống sốc', 2, 250000.00),
    (7, 'Cáp sạc Type-C', 5, 50000.00),
    (8, 'Lót chuột', 10, 15000.00),
    (9, 'iPhone 13', 1, 5500000.00),
    (10, 'Giá đỡ Laptop', 2, 150000.00),
    (11, 'Loa Bluetooth', 1, 800000.00),
    (12, 'Webcam 1080p', 1, 1200000.00);


-- 1. ALIAS:
-- Hiển thị danh sách tất cả các đơn hàng với các cột:
-- Tên khách (customer_name)
-- Ngày đặt hàng (order_date)
-- Tổng tiền (total_amount)

select c.customer_name , o.order_date, o.total_amount
from gioi2.customers c join gioi2.orders o on c.customer_id = o.customer_id;

-- 2.Aggregate Functions:
-- Tính các thông tin tổng hợp:
-- Tổng doanh thu (SUM(total_amount))
-- Trung bình giá trị đơn hàng (AVG(total_amount))
-- Đơn hàng lớn nhất (MAX(total_amount))
-- Đơn hàng nhỏ nhất (MIN(total_amount))
-- Số lượng đơn hàng (COUNT(order_id))

select sum(total_amount) "Tổng DT",
       avg(total_amount) "Tb",
       max(total_amount) max,
       min(total_amount) min,
       count(order_id)
    from gioi2.orders o;

-- 3.GROUP BY / HAVING:
-- Tính tổng doanh thu theo từng thành phố
-- chỉ hiển thị những thành phố có tổng doanh thu lớn hơn 3000000

select c.city, sum(total_amount)
    from gioi2.orders
    join gioi2.customers c on c.customer_id = orders.customer_id
    group by c.city
    having sum(total_amount) >3000000;

-- 4. JOIN:
-- Liệt kê tất cả các sản phẩm đã bán, kèm:
-- Tên khách hàng
-- Ngày đặt hàng
-- Số lượng và giá
-- (JOIN 3 bảng customers, orders, order_items)

select oi.product_name, c.customer_name, o.order_date, oi.quantity,oi.price, (oi.quantity * oi.price) "Tổng"
    from gioi2.customers c
    join gioi2.orders o on c.customer_id = o.customer_id
    join gioi2.order_items oi on o.order_id = oi.order_id;

-- 5. Subquery:
-- Tìm tên khách hàng có tổng doanh thu cao nhất.
-- Gợi ý: Dùng SUM(total_amount) trong subquery để tìm MAX

select c.customer_name, sum(o.total_amount)
    from gioi2.customers c
    join gioi2.orders o on c.customer_id = o.customer_id
group by c.customer_name
having sum(o.total_amount) = (
    select max(total_each_cus) max_total from (
          select o.customer_id ,sum(o.total_amount) total_each_cus
          from gioi2.orders o
          group by o.customer_id
      ) max_total_each_cus
)



