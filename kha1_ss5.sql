create schema kha1;

CREATE TABLE kha1.products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50)
);

CREATE TABLE kha1.orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (product_id) REFERENCES kha1.products(product_id)
);

INSERT INTO kha1.products (product_id, product_name, category) VALUES
      (1, 'Laptop Dell', 'Electronics'),
      (2, 'IPhone 15', 'Electronics'),
      (3, 'Bàn học gỗ', 'Furniture'),
      (4, 'Ghế xoay', 'Furniture');

INSERT INTO kha1.orders (order_id, product_id, quantity, total_price) VALUES
     (101, 1, 2, 2200),
     (102, 2, 3, 3300),
     (103, 3, 5, 2500),
     (104, 4, 4, 1600),
     (105, 1, 1, 1100);

select p.category, sum(total_price)
from kha1.orders o inner join kha1.products p on p.product_id = o.product_id
group by p.category having sum(total_price) > 2000 order by sum(total_price) desc ;
