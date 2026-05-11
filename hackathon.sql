CREATE DATABASE Hackathon;
USE Hackathon;
CREATE TABLE Passengers(
passenger_id VARCHAR(5) PRIMARY KEY NOT NULL,
full_name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
phone VARCHAR(15) UNIQUE
);
CREATE TABLE Airlines(
airline_id VARCHAR(5)  PRIMARY KEY NOT NULL,
airline_name VARCHAR(100) UNIQUE NOT NULL
);
CREATE TABLE Flights(
fligh_id VARCHAR(5) PRIMARY KEY NOT NULL,
route_name VARCHAR(100) NOT NULL,
airline_id VARCHAR(5) NOT NULL,
ticket_price DECIMAL(10,2) NOT NULL,
available_seats INT NOT NULL,
FOREIGN KEY (ariline_id) REFERENCES Arilines(ariline_id) ON DELETE CASCADE
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
INSERT INTO Passengers (passenger_id,full_name,email,phone) VALUE
('P01','Trần Văn Bình','binh.tv@gmail.com','0981111111'),
('P02','Lê Thị Hoa ','hoa.lt@gmail.com','0981111111'),
('P03','Nguyễn Trọng Tuấn','tuan.nt@gmail.com','0981111111'),
('P04','Hoàng Minh Châu','chau.hm@gmail.com','0981111111'),
('P05','Đinh Kiều Oanh ','oanh.dk@gmail.com','0981111111');
INSERT INTO Airlines (airline_id,airline_name) VALUE
('A01','Vietnam Airlines'),
('A02','VietJet Air'),
('A03','Bamboo Airways'),
('A04','Pacific Airlines')
;
INSERT INTO Flights(flight_id,route_name,airline_id,ticke_price,available_seats)VALUE
('F01','HN-HCM','A01','2500000.00','50'),
('F02','HN-DN','A02','1500000.00','30'),
('F03','HCM-DN','A03','1200000.00','40'),
('F04','HN-PQ','A04','300000.00','20'),
('F05','HCM-DL','A05','1000000.00','15')
;
INSERT INTO Bookings(booking_id,passenger_id,flight_id,status,booking_date) VALUE
('1','P01','F01','Booked','2025-10-01'),
('2','P02','F02','Boarked','2025-10-02'),
('3','P03','F03','Boarked','2025-10-03'),
('4','P04','F04','Cancelled','2025-10-04'),
('5','P05','F05','Booked','2025-10-05')
;

-- 3
UPDATE Flights SET available_seats =available_seats +10,ticket_price =ticket_price*1.05 WHERE route_name ='HN-PQ';
-- 4
UPDATE Passengers SET phone ='0999999999' WHERE passenger_id ='P03';
-- 5
DELETE FROM Bookings WHERE status ='Cancelled' AND booking_date < '20-10-03';

-- PHAN 2:
-- 6 Liệt kê các chuyến bay gồm flight_id,route_name,ticket_price có giá vé từ 1200000 đến 15000000 và đnag có available_seats >0 
SELECT flight_id,route_name,ticket_price 
FROM Flights 
-- 7 lấy thông tin full_name ,email của những khách hàng có họ trần 
SELECT full_name,email 
FROM Passenger 
WHERE full_name LIKE 'Trần%';
-- 8 Hiện thị danh sác các vé đặt gồm booking_id,passenger_id,booking_date .sắp xếp theo booking_date giảm dầnn
SELECT booking_id,passenger_id,booking_date
FROM Bookings
ORDER BY booking_date DESC ;
-- 9 Lấy ra 3 chuyến bay có gái vé lớn nhất (ticket_price ) trong hệ thống 
SELECT *FROM Flight 
ORDER BY ticket_price DESC LIMIT 3;
-- 10 hiển thị danh sách route_name ,available_seats từ bảng flights bỏ qua 2 chuyến bay đầu tiên và lấy 2 chuyến bay tiếp theo 
SELECT route_name,available_seats 
FROM Flight 
LIMIT 2 OFFSET 2;
-- 11 hiển thị danh sách gồm bookings_id,full_name (của khách hàng ), route_năm (của chuyêns bay )và booking_date.chỉ lấy những vé trạng thái 'booked'


-- 12 liệt kê tất cả các hãng hàng không (airlines) và tên chặng bay (route_name ) thuộc  hãng đó .hiển thị những hãng chưa co chuyến bay nào khai thác 


-- 13 tính tổng số lượt đặt vé theo từng trạng thái (status ) kết quả gồm hai cột :status và total_bookings 

-- 14 thống kê số lượng vé mà mõi hành khách đã đặt. cghir hiện thị tên hành khách (full_name ) có từ 2 lượt đặt vé trở lên 


-- 15 lấy thông tin cghi tiết các chuyển bay (flight_id,route_name,ticket_price ) có giá vé nhỏ hơn giá vé trung bình của tất cả chuyến bay 


-- 16 hiện thị full_name và phone của những hành khách đã đặt ve scho chuyến bay có tên chặng 'HN-HCM'
