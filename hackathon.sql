CREATE DATABASE Hackathon;
USE Hackathon;
CREATE TABLE Passengers(
  passenger_id VARCHAR(5) PRIMARY KEY NOT NULL,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  phone VARCHAR(15) UNIQUE NOT NULL 
);
CREATE TABLE Airlines(
  airline_id VARCHAR(5) PRIMARY KEY NOT NULL,
  airline_name VARCHAR(100) UNIQUE NOT NULL
);
CREATE TABLE Flights(
  flight_id VARCHAR(5) PRIMARY KEY NOT NULL,
  route_name VARCHAR(100) NOT NULL,
  airline_id VARCHAR(5) NOT NULL,
  ticket_price DECIMAL(12,2) NOT NULL,
  available_seats INT NOT NULL,
  FOREIGN KEY (airline_id) REFERENCES Airlines(airline_id) ON DELETE CASCADE
);
CREATE TABLE Bookings(
  booking_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  passenger_id VARCHAR(5) NOT NULL,
  flight_id VARCHAR(5) NOT NULL,
  status VARCHAR(20) NOT NULL,
  booking_date DATE NOT NULL,
  FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id) ON DELETE CASCADE,
  FOREIGN KEY (flight_id) REFERENCES Flights(flight_id) ON DELETE CASCADE
);
INSERT INTO Passengers (passenger_id,full_name,email,phone) VALUES
  ('P01','Trần Văn Bình','binh.tv@gmail.com','0981111111'),
  ('P02','Lê Thị Hoa','hoa.lt@gmail.com','0981111111'),
  ('P03','Nguyễn Trọng Tuấn','tuan.nt@gmail.com','0981111111'),
  ('P04','Hoàng Minh Châu','chau.hm@gmail.com','0981111111'),
  ('P05','Đinh Kiều Oanh','oanh.dk@gmail.com','0981111111');
INSERT INTO Airlines (airline_id,airline_name) VALUES
  ('A01','Vietnam Airlines'),
  ('A02','VietJet Air'),
  ('A03','Bamboo Airways'),
  ('A04','Pacific Airlines'),
  ('A05','Vasco');
INSERT INTO Flights (flight_id,route_name,airline_id,ticket_price,available_seats) VALUES
  ('F01','HN-HCM','A01',2500000.00,50),
  ('F02','HN-DN','A02',1500000.00,30),
  ('F03','HCM-DN','A03',1200000.00,40),
  ('F04','HN-PQ','A04',300000.00,20),
  ('F05','HCM-DL','A05',1000000.00,15);
INSERT INTO Bookings (booking_id,passenger_id,flight_id,status,booking_date) VALUES
  (1,'P01','F01','Booked','2025-10-01'),
  (2,'P02','F02','Booked','2025-10-02'),
  (3,'P03','F03','Booked','2025-10-03'),
  (4,'P04','F04','Cancelled','2025-10-04'),
  (5,'P05','F05','Booked','2025-10-05');

-- 3
UPDATE Flights
SET available_seats = available_seats + 10,
    ticket_price = ticket_price * 1.05
WHERE route_name = 'HN-PQ';

-- 4
UPDATE Passengers
SET phone = '0999999999'
WHERE passenger_id = 'P03';

-- 5
DELETE FROM Bookings
WHERE status = 'Cancelled'
  AND booking_date < '2020-10-03';

-- PHAN 2:
-- 6 Liệt kê các chuyến bay gồm flight_id,route_name,ticket_price có giá vé từ 1200000 đến 15000000 và đang có available_seats > 0
SELECT flight_id, route_name, ticket_price
FROM Flights
WHERE ticket_price BETWEEN 1200000 AND 15000000
  AND available_seats > 0;

-- 7 lấy thông tin full_name, email của những khách hàng có họ Trần
SELECT full_name, email
FROM Passengers
WHERE full_name LIKE 'Trần%';

-- 8 Hiển thị danh sách các vé đặt gồm booking_id, passenger_id, booking_date; sắp xếp theo booking_date giảm dần
SELECT booking_id, passenger_id, booking_date
FROM Bookings
ORDER BY booking_date DESC;

-- 9 Lấy ra 3 chuyến bay có giá vé lớn nhất (ticket_price) trong hệ thống
SELECT *
FROM Flights
ORDER BY ticket_price DESC
LIMIT 3;

-- 10 Hiển thị danh sách route_name, available_seats từ bảng Flights bỏ qua 2 chuyến bay đầu tiên và lấy 2 chuyến bay tiếp theo
SELECT route_name, available_seats
FROM Flights
LIMIT 2 OFFSET 2;

-- 11 Hiển thị danh sách gồm booking_id, full_name (của khách hàng), route_name (của chuyến bay) và booking_date; chỉ lấy những vé trạng thái 'Booked'
SELECT b.booking_id,
       p.full_name,
       f.route_name,
       b.booking_date
FROM Bookings b
JOIN Passengers p ON b.passenger_id = p.passenger_id
JOIN Flights f ON b.flight_id = f.flight_id
WHERE b.status = 'Booked';

-- 12 Liệt kê tất cả các hãng hàng không (airlines) và tên chặng bay (route_name) thuộc hãng đó. Hiển thị những hãng chưa có chuyến bay nào khai thác
SELECT a.airline_name,
       f.route_name
FROM Airlines a
LEFT JOIN Flights f ON a.airline_id = f.airline_id
ORDER BY a.airline_name, f.route_name;

-- 13 Tính tổng số lượt đặt vé theo từng trạng thái (status); kết quả gồm hai cột: status và total_bookings
SELECT status,
       COUNT(*) AS total_bookings
FROM Bookings
GROUP BY status;

-- 14 Thống kê số lượng vé mà mỗi hành khách đã đặt. Chỉ hiển thị tên hành khách (full_name) có từ 2 lượt đặt vé trở lên
SELECT p.full_name,
       COUNT(*) AS booking_count
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
GROUP BY p.full_name
HAVING COUNT(*) >= 2;

-- 15 Lấy thông tin chi tiết các chuyến bay (flight_id, route_name, ticket_price) có giá vé nhỏ hơn giá vé trung bình của tất cả chuyến bay
SELECT flight_id, route_name, ticket_price
FROM Flights
WHERE ticket_price < (
  SELECT AVG(ticket_price)
  FROM Flights
);

-- 16 Hiển thị full_name và phone của những hành khách đã đặt vé cho chuyến bay có tên chặng 'HN-HCM'
SELECT DISTINCT p.full_name,
       p.phone
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
JOIN Flights f ON b.flight_id = f.flight_id
WHERE f.route_name = 'HN-HCM';
