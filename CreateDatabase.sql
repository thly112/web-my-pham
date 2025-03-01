-- DROP DATABASE IF EXISTS CosmeticStore;
CREATE DATABASE CosmeticStore;
USE CosmeticStore;

-- DROP TABLE IF EXISTS ACCOUNT;
CREATE TABLE ACCOUNT (
    accountId INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(30),
    password VARCHAR(200),
    mail VARCHAR(30),
    roleId INT,
    status INT,
    code VARCHAR(30)
);

-- RoleID
-- 1: user
-- 2: admin
-- 3: seller
-- 4: shipper
INSERT INTO ACCOUNT (username, password, mail, roleId, status, code)
VALUES
('user', '1', 'admin@example.com', 1, 1, '123456'),
('admin', '1', 'user1@example.com', 2, 1, '789012'),
('seller', '1', 'user2@example.com', 3, 1, '345678'),
('shipper', '1', 'user3@example.com', 4, 1, '901234'),
('admin2', '1', 'user4@example.com', 2, 1, '567890'),
('seller2', '1', 'user5@example.com', 3, 1, '123456');

-- DROP TABLE IF EXISTS CUSTOMER;
CREATE TABLE CUSTOMER (
    customerId INT AUTO_INCREMENT PRIMARY KEY,
    customerName VARCHAR(100),
    birthday DATE,
    gender VARCHAR(10),
    address VARCHAR(255),
    phone VARCHAR(20),
    mail VARCHAR(50),
    `rank` VARCHAR(50),
    reputation INT DEFAULT 0,
    rewardPoints INT DEFAULT 0,
    accountId INT,
    FOREIGN KEY (accountId) REFERENCES ACCOUNT(accountId)
);

INSERT INTO CUSTOMER (customerName, birthday, gender, address, phone, mail, `rank`, reputation, rewardPoints, accountId)
VALUES
('Nguyễn Văn An', '1990-01-01', 'Nam', 'Số 10, đường Nguyễn Trãi, thành phố Mỹ Tho, tỉnh Tiền Giang', '0987654321', 'nguyenvanan@gmail.com', 'Khách hàng mới', 0, 0, 1),
('Trần Thị My', '1991-02-02', 'Nữ', 'Số 20, đường Lê Lợi, quận 7, TP.HCM', '0998765432', 'tranthimy@gmail.com', 'Khách hàng thân thiết', 5, 100, 1),
('Lê Quang Chung', '1992-03-03', 'Nam', 'Số 30, đường Hùng Vương, quận Bình Tân, thành phố Hồ Chí Minh', '0909765432', 'lequangchung@gmail.com', 'Khách hàng VIP', 10, 200, 1),
('Đỗ Thị Diệu', '1993-04-04', 'Nữ', 'Số 40, đường Trần Phú, thành phố Bến Tre, tỉnh Bến Tre', '0911765432', 'dothidieu@gmail.com', 'Khách hàng mới', 0, 0, 1),
('Huỳnh Văn Én', '1994-05-05', 'Nam', 'Số 50, đường Nguyễn Huệ, thành phố Mỹ Tho, tỉnh Tiền Giang', '0922765432', 'huynhvanen@gmail.com', 'Khách hàng thân thiết', 5, 100, 1),
('Phan Thị Trúc', '1995-06-06', 'Nữ', 'Số 60, đường Ba Tháng Hai, quận Ninh Kiều, thành phố Cần Thơ', '0933765432', 'phanthitruc@gmail.com', 'Khách hàng VIP', 10, 200, 1),
('Nguyễn Thị Ngân', '1996-07-07', 'Nữ', 'Số 70, đường Lê Văn Duyệt, thành phố Mỹ Tho, tỉnh Tiền Giang', '0944765432', 'nguyenthingan@gmail.com', 'Khách hàng mới', 0, 0, 1),
('Trương Văn Hải', '1997-08-08', 'Nam', 'Số 80, đường Lý Thường Kiệt, huyện Cao Lãnh, tỉnh Đồng Tháp', '0955765432', 'truongvanhai@gmail.com', 'Khách hàng thân thiết', 5, 100, 1),
('Lý Thị Ngọc', '1998-09-09', 'Nữ', 'Số 90, đường Nguyễn Văn Trỗi, huyện Phụng Hiệp, tỉnh Hậu Giang', '0966765432', 'lythingoc@gmail.com', 'Khách hàng VIP', 10, 200, 1),
('Trần Văn Bình', '1999-10-10', 'Nam', 'Số 100, đường Quang Trung, quận 10, TP.HCM', '0977765432', 'tranvanbinh@gmail.com', 'Khách hàng mới', 0, 0, 1),
('Nguyễn Thị Thu', '2000-11-11', 'Nữ', 'Số 110, đường Cách Mạng Tháng Tám, quận 1, TP.HCM', '0988765432', 'nguyenthithu@gmail.com', 'Khách hàng thân thiết', 5, 100, 1),
('Lê Văn Tâm', '2001-12-12', 'Nam', 'Số 120, đường Lê Duẩn, thành phố Nha Trang, tỉnh Khánh Hòa', '0999765432', 'levantam@gmail.com', 'Khách hàng VIP', 10, 200, 1),
('Phạm Thị Hương', '2002-01-01', 'Nữ', 'Số 130, đường Ngô Gia Tự, thành phố Hồ Chí Minh', '0901765432', 'phamthihuong@gmail.com', 'Khách hàng mới', 0, 0, 1),
('Hoàng Văn Hòa', '2003-02-02', 'Nam', 'Số 140, đường Lê Thánh Tông, quận Cẩm Lệ, thành phố Đà Nẵng', '0912765432', 'hoangvanhoa@gmail.com', 'Khách hàng thân thiết', 5, 100, 1),
('Mai Thị Quỳnh', '2004-03-03', 'Nữ', 'Số 150, đường Nguyễn Chí Thanh, quận Bắc Từ Liêm, Hà Nội', '0923765432', 'maithiquynh@gmail.com', 'Khách hàng VIP', 10, 200, 1),
('Ngô Văn Hiển', '2005-04-04', 'Nam', 'Số 160, đường Trần Hưng Đạo, thành phố Vinh, tỉnh Nghệ An', '0934765432', 'ngovanhien@gmail.com', 'Khách hàng mới', 0, 0, 1),
('Dương Thị Hoài', '2006-05-05', 'Nữ', 'Số 170, đường Nguyễn Trãi, quận Thanh Xuân, Hà Nội', '0945765432', 'duongthihoai@gmail.com', 'Khách hàng thân thiết', 5, 100, 1),
('Võ Văn Tài', '2007-06-06', 'Nam', 'Số 180, đường Lý Tự Trọng, thành phố Vũng Tàu, tỉnh Bà Rịa - Vũng Tàu', '0956765432', 'vovantai@gmail.com', 'Khách hàng VIP', 10, 200, 1),
('Hồ Thị Thảo', '2008-07-07', 'Nữ', 'Số 190, đường Nguyễn Đình Chính, quận Gò Vấp, TP.HCM', '0967765432', 'hothithao@gmail.com', 'Khách hàng mới', 0, 0, 1),
('Đoàn Văn Lâm', '2009-08-08', 'Nam', 'Số 200, đường Đống Đa, thành phố Huế, tỉnh Thừa Thiên Huế', '0978765432', 'doanvanlam@gmail.com', 'Khách hàng thân thiết', 5, 100, 1);

-- DROP TABLE IF EXISTS CART;
CREATE TABLE CART (
    cartId INT AUTO_INCREMENT PRIMARY KEY,
    customerId INT,
    totalPrice FLOAT,
    FOREIGN KEY (customerId) REFERENCES CUSTOMER(customerId)
);

INSERT INTO CART (customerId, totalPrice)
VALUES
(1, 100000),
(2, 200000),
(3, 300000),
(4, 400000),
(5, 500000),
(6, 600000),
(7, 700000),
(8, 800000),
(9, 900000),
(10, 1000000),
(11, 1100000),
(12, 1200000),
(13, 1300000),
(14, 1400000),
(15, 1500000),
(16, 1600000),
(17, 1700000),
(18, 1800000),
(19, 1900000),
(20, 2000000);
-- category
-- DROP TABLE CATEGORY
CREATE TABLE CATEGORY (
    categoryId INT AUTO_INCREMENT PRIMARY KEY,
    categoryName VARCHAR(100),
    imageURL VARCHAR(2000)
);

INSERT INTO CATEGORY (categoryName, imageURL)
VALUES
(N'Mỹ phẩm trang điểm', 'https://media-asia-cdn.oriflame.com/contentImage?externalMediaId=14905c08-2eca-4d9d-9efa-8491009f8a50&w=450&q=70'),
(N'Mỹ phẩm chăm sóc da', 'https://media-asia-cdn.oriflame.com/contentImage?externalMediaId=772b8b8b-a1cb-47d6-9dd5-8093619f3f81&w=450&q=70'),
(N'Mỹ phẩm chăm sóc tóc', 'https://media-asia-cdn.oriflame.com/contentImage?externalMediaId=9c8196fd-d25e-4f81-a06d-529d668a4c5e&w=450&q=70'),
(N'Mỹ phẩm chăm sóc cơ thể', 'https://media-asia-cdn.oriflame.com/contentImage?externalMediaId=7f531254-21fa-4de5-8777-1abc5b0527bd&w=450&q=70'),
(N'Mỹ phẩm nam', 'https://media-asia-cdn.oriflame.com/contentImage?externalMediaId=7c17707e-0b02-47f1-b746-f1989c783716&w=450&q=70'),
(N'Mỹ phẩm trẻ em', 'https://media-cdn.oriflame.com/productImage?externalMediaId=product-management-media%2F35775%2F35775.png%3Fversion%3D1643398202&w=231&bc=%23f5f5f5&ib=%23f5f5f5&h=231&q=90'),
(N'Mỹ phẩm hữu cơ', 'https://media-cdn.oriflame.com/productImage?externalMediaId=product-management-media%2F29690%2F29690.png%3Fversion%3D1594228110&w=231&bc=%23f5f5f5&ib=%23f5f5f5&h=231&q=90'),
(N'Phụ kiện', 'https://media-asia-cdn.oriflame.com/contentImage?externalMediaId=cf78bea7-06c0-49c7-9b0b-e267fd419836&w=450&q=70');

-- DROP TABLE SUPPLIER
CREATE TABLE SUPPLIER (
    supplierId INT AUTO_INCREMENT PRIMARY KEY,
    supplierName VARCHAR(100)
);

INSERT INTO SUPPLIER (supplierName)
VALUES
('Mỹ phẩm ABC'),
('Công ty TNHH SX-TM Mỹ phẩm XYZ'),
('Công ty CP Mỹ phẩm Hàn Quốc K-Beauty'),
('Công ty TNHH MTV Mỹ phẩm Pháp L"Oreal'),
('Công ty Cổ phần Mỹ phẩm Nhật Bản Shiseido'),
('Công ty TNHH MTV Mỹ phẩm Mỹ Maybelline'),
('Công ty Cổ phần Mỹ phẩm Thái Lan Mistine'),
('Nhà phân phối Mỹ phẩm A Cosmetics'),
('Công ty TNHH Xuất nhập khẩu Mỹ phẩm B Beauty'),
('Công ty Cổ phần Mỹ phẩm Việt Nam Queenie');

-- DROP TABLE EMPLOYEE
CREATE TABLE EMPLOYEE (
    employeeId INT AUTO_INCREMENT PRIMARY KEY,
    employeeName VARCHAR(100),
    birthdate DATE,
    gender VARCHAR(10),
    address VARCHAR(100),
    phone VARCHAR(10),
    mail VARCHAR(30),
    job VARCHAR(100),
    accountId INT,
    activityArea VARCHAR(100),
    imageURL VARCHAR(2000)
);

INSERT INTO EMPLOYEE (employeeName, birthdate, gender, address, phone, mail, job, accountId, activityArea, imageURL)
VALUES
(N'Nguyễn Văn A', '1990-01-01', N'Nam', N'Số 10, đường Nguyễn Trãi, quận Tân Bình, thành phố Hồ Chí Minh', '0987654321', 'nguyenvana@gmail.com', N'Seller', 3, N'Sales', 'https://example.com/images/employees/nguyenvanan.jpg'),
(N'Phạm Thị B', '1991-08-02', N'Nữ', N'Số 20, đường Lê Lợi, huyện Mỏ Cày Nam, tỉnh Bến Tre', '0998765234', 'phamthib@gmail.com', N'Seller', 3, N'Sales', 'https://example.com/images/employees/tranthibu.jpg'),
(N'Trần Quang C', '1992-03-03', N'Nam', N'Số 30, đường Hùng Vương, huyện Mỹ Xuyên, tỉnh Sóc Trăng', '0909765124', 'tranquangc@gmail.com', N'Seller', 3, N'Logistics', 'https://example.com/images/employees/lequangc.jpg'),
(N'Đỗ Thị D', '1993-04-04', N'Nữ', N'Số 40, đường Trần Phú, huyện Tân Châu, tỉnh An Giang', '0911765453', 'dothid@gmail.com',N'Seller', 3, N'Marketing', 'https://example.com/images/employees/dothidu.jpg'),
(N'Lý Văn E', '1994-12-05', N'Nam', N'Số 50, đường Nguyễn Huệ, huyện Kiên Lương, tỉnh Kiên Giang', '0922765725', 'lyvane@gmail.com', N'Shipper', 4, N'Administration', 'https://example.com/images/employees/huynhvane.jpg'),
(N'Phan Thị Fc', '1995-04-06', N'Nữ', N'Số 60, đường Ba Tháng Hai, huyện Hồng Ngự, tỉnh Đồng Tháp', '0933765824', 'phanthif@gmail.com', N'Shipper', 4, N'Finance', 'https://example.com/images/employees/phanthi.jpg'),
(N'Lý Văn Eq', '1994-12-05', N'Nam', N'Số 50, đường Nguyễn Huệ, huyện Kiên Lương, tỉnh Kiên Giang', '0922765725', 'lyvane@gmail.com', N'Shipper', 4, N'Administration', 'https://example.com/images/employees/huynhvane.jpg'),
(N'Phan Thị Fe', '1995-04-06', N'Nữ', N'Số 60, đường Ba Tháng Hai, huyện Hồng Ngự, tỉnh Đồng Tháp', '0933765824', 'phanthif@gmail.com', N'Shipper', 4, N'Finance', 'https://example.com/images/employees/phanthi.jpg'),
(N'Lý Văn EC', '1994-12-05', N'Nam', N'Số 50, đường Nguyễn Huệ, huyện Kiên Lương, tỉnh Kiên Giang', '0922765725', 'lyvane@gmail.com', N'Shipper', 4, N'Administration', 'https://example.com/images/employees/huynhvane.jpg'),
(N'Phan Thị FE', '1995-04-06', N'Nữ', N'Số 60, đường Ba Tháng Hai, huyện Hồng Ngự, tỉnh Đồng Tháp', '0933765824', 'phanthif@gmail.com', N'Shipper', 4, N'Finance', 'https://example.com/images/employees/phanthi.jpg');

-- DROP TABLE ORDERS
CREATE TABLE ORDERS (
    orderId INT AUTO_INCREMENT PRIMARY KEY,
    orderValue FLOAT,
    orderDate DATETIME,
    cartId INT,
    customerId INT,
    paymentStatus VARCHAR(100),
    orderStatus VARCHAR(100),
    paymentMethod VARCHAR(100),
    deliveryMethod VARCHAR(100),
    employeeId INT,
    FOREIGN KEY (cartId) REFERENCES CART(cartId),
    FOREIGN KEY (customerId) REFERENCES CUSTOMER(customerId),
    FOREIGN KEY (employeeId) REFERENCES EMPLOYEE(employeeId)
);

-- Nếu trạng thái là SAVE thì không có employeeID
INSERT INTO ORDERS (orderValue, orderDate, cartId, customerId, paymentStatus, orderStatus, paymentMethod, deliveryMethod, employeeId) 
VALUES 
(5500000, '2023-01-29 09:10:00', 10, 10, 'Paid', 'Chưa giao cho shipper', 'Credit card', 'Giao hàng tận nơi', 7),
(6000000, '2023-01-28 13:45:00', 11, 11, 'Unpaid', 'Save', 'Cash on Delivery', 'Giao hàng tận nơi', NULL),
(8000000, '2023-01-24 10:50:00', 15, 15, 'Unpaid', 'Save', 'Cash on Delivery', 'Giao hàng tận nơi', NULL),
(8500000, '2023-01-23 07:15:00', 16, 16, 'Unpaid', 'Save', 'Momo', 'Giao hàng tận nơi', NULL),
(9000000, '2023-01-22 23:40:00', 17, 17, 'Paid', 'Chưa giao cho shipper', 'Bank transfer', 'Giao hàng tận nơi', 5),
(6500000, '2023-02-27 18:20:00', 12, 12, 'Paid', 'Đã giao cho shipper', 'MoMo', 'Giao hàng tận nơi', 9),
(7000000, '2023-02-26 21:30:00', 13, 13, 'Unpaid', 'Save', 'Bank transfer', 'Giao hàng tận nơi', NULL),
(13000000, '2023-02-14 16:15:00', 5, 5, 'Paid', 'Chưa giao cho shipper', 'Bank transfer', 'Giao hàng tận nơi', 4),
(13500000, '2023-02-13 12:00:00', 6, 6, 'Unpaid', 'Save', 'Credit card', 'Giao hàng tận nơi', NULL),
(14000000, '2023-02-12 09:25:00', 7, 7, 'Paid', 'Đã giao khách hàng', 'Cash on delivery', 'Giao hàng tận nơi', 6),
(7500000, '2023-03-25 14:05:00', 14, 14, 'Paid', 'Đã giao khách hàng', 'Credit card', 'Giao hàng tận nơi', 2),
(8000000, '2023-03-24 10:50:00', 15, 15, 'Unpaid', 'Save', 'Cash on Delivery', 'Giao hàng tận nơi', NULL),
(11500000, '2023-03-17 08:10:00', 2, 2, 'Unpaid', 'Save', 'Credit card', 'Giao hàng tận nơi', NULL),
(12000000, '2023-03-16 02:35:00', 3, 3, 'Paid', 'Đã giao khách hàng', 'Cash on delivery', 'Giao hàng tận nơi', 2),
(12500000, '2023-03-15 19:50:00', 4, 4, 'Unpaid', 'Save', 'Momo', 'Giao hàng tận nơi', NULL),
(8500000, '2023-04-23 07:15:00', 16, 16, 'Unpaid', 'Save', 'Momo', 'Giao hàng tận nơi', NULL),
(9000000, '2023-04-22 23:40:00', 17, 17, 'Paid', 'Chưa giao cho shipper', 'Bank transfer', 'Giao hàng tận nơi', 5),
(13000000, '2023-04-14 16:15:00', 5, 5, 'Paid', 'Chưa giao cho shipper', 'Bank transfer', 'Giao hàng tận nơi', 4),
(13500000, '2023-04-13 12:00:00', 6, 6, 'Unpaid', 'Save', 'Credit card', 'Giao hàng tận nơi', NULL),
(14000000, '2023-04-12 09:25:00', 7, 7, 'Paid', 'Đã giao khách hàng', 'Cash on delivery', 'Giao hàng tận nơi', 6),
(9500000, '2023-05-21 17:25:00', 18, 18, 'Unpaid', 'Save', 'Credit card', 'Giao hàng tận nơi', NULL),
(10000000, '2023-05-20 20:35:00', 19, 19, 'Paid', 'Đã giao khách hàng', 'Cash on delivery', 'Giao hàng tận nơi', 7),
(10500000, '2023-06-19 15:00:00', 20, 20, 'Unpaid', 'Save', 'MoMo', 'Giao hàng tận nơi', NULL),
(11000000, '2023-06-18 11:45:00', 1, 1, 'Paid', 'Chưa giao cho shipper', 'Bank transfer', 'Giao hàng tận nơi', 9),
(11500000, '2023-07-17 08:10:00', 2, 2, 'Unpaid', 'Save', 'Credit card', 'Giao hàng tận nơi', NULL),
(12000000, '2023-07-16 02:35:00', 3, 3, 'Paid', 'Đã giao khách hàng', 'Cash on delivery', 'Giao hàng tận nơi', 2),
(12500000, '2023-08-15 19:50:00', 4, 4, 'Unpaid', 'Save', 'Momo', 'Giao hàng tận nơi', NULL),
(13000000, '2023-08-14 16:15:00', 5, 5, 'Paid', 'Chưa giao cho shipper', 'Bank transfer', 'Giao hàng tận nơi', 4),
(13500000, '2023-09-13 12:00:00', 6, 6, 'Unpaid', 'Save', 'Credit card', 'Giao hàng tận nơi', NULL),
(14000000, '2023-09-12 09:25:00', 7, 7, 'Paid', 'Đã giao khách hàng', 'Cash on delivery', 'Giao hàng tận nơi', 6),
(14500000, '2023-10-11 05:50:00', 8, 8, 'Unpaid', 'Save', 'MoMo', 'Giao hàng tận nơi', NULL),
(15000000, '2023-10-10 22:15:00', 9, 9, 'Paid', 'Chưa giao cho shipper', 'Bank transfer', 'Giao hàng tận nơi', 8),
(5500000, '2023-12-29 09:10:00', 10, 10, 'Paid', 'Chưa giao cho shipper', 'Credit card', 'Giao hàng tận nơi', 7),
(14500000, '2023-11-11 05:50:00', 8, 8, 'Unpaid', 'Save', 'MoMo', 'Giao hàng tận nơi', NULL),
(6000000, '2023-12-28 13:45:00', 11, 11, 'Unpaid', 'Save', 'Cash on Delivery', 'Giao hàng tận nơi', NULL);

-- DROP TABLE PRODUCT
CREATE TABLE PRODUCT (
    productId INT AUTO_INCREMENT PRIMARY KEY,
    productName VARCHAR(100),
    description TEXT,
    stock INT,
    amount INT,
    price DOUBLE,
    categoryId INT,
    imageURL VARCHAR(2000),
    FOREIGN KEY (categoryId) REFERENCES CATEGORY(categoryId)
);

INSERT INTO PRODUCT (productName, description, stock, amount, price, categoryId, imageURL)
VALUES
(N'Kem nền Maybelline Superstay 24H', N'Kem nền dạng lỏng, độ che phủ cao, lâu trôi trong 24h', 100, 1000, 250000, 1, 'https://image.hsv-tech.io/1387x0/bbx/maybelline_superstay_24h_full_coverage_foundation_112_c835b7d5a58c413db58a9dca04c2d682.png'),
(N'Son lì MAC Retro Matte Lipstick', N'Son lì dạng thỏi, lâu trôi, lên màu chuẩn', 50, 500, 300000, 2, 'https://product.hstatic.net/200000066044/product/mac02.707-son-thoi-li-mac-retro-matte-lipstick-3g_a9dfe87e75be459d943472718ded3982.jpg'),
(N'Mặt nạ giấy Innisfree It is Real Squeeze Mask', N'Mặt nạ giấy dạng miếng, cấp ẩm, làm sáng da', 200, 2000, 150000, 1, 'https://cf.shopee.vn/file/2f620f00bdc91053d85819205dde739b'),
(N'Sữa rửa mặt Cetaphil Gentle Skin Cleanser', N'Sữa rửa mặt dịu nhẹ, không gây kích ứng da', 1000, 10000, 200000, 1, 'https://product.hstatic.net/1000360941/product/sua-rua-mat-da-nhay-cam-centaphil_446a407e24c141faa68bb6b63a883980_master.jpg'),
(N'Dầu gội đầu Dove Deeply Nourishing Shampoo', N'Dầu gội đầu dưỡng ẩm, giúp tóc mềm mượt', 500, 5000, 250000, 3, 'https://cdn-images.kiotviet.vn/shopthaovy/047e62d35c1c4bfca5a29b75e6713126.jpeg'),
(N'Sữa tắm The Body Shop Shea Butter Body Wash', N'Sữa tắm dưỡng ẩm, giúp da mềm mượt', 1000, 10000, 300000, 4, 'https://www.thebodyshop.com.vn/img/resize/565?url=%2Fpub/media%2Fcatalog%2Fproduct%2Fc%2Fo%2Fcondition-shea-250ml-1.jpg'),
(N'Kem chống nắng La Roche-Posay Anthelios Shaka Fluid SPF50+', N'Kem chống nắng dạng lỏng, chống thấm nước, bảo vệ da khỏi tia UV', 200, 2000, 500000, 1, 'https://nhathuoc365.vn/images/products/2020/03/27/original/kem-chong-nang-anthelios-shaka-fluid-spf50-la-roche-posay-50-ml-1585308214.jpg'),
(N'Nước hoa Dior Sauvage Eau de Parfum', N'Nước hoa nam, hương gỗ thơm nồng, nam tính', 100, 1000, 600000, 5, 'https://classic.vn/wp-content/uploads/2022/02/dior-sauvage-eau-de-parfume.webp'),
(N'Sữa tắm gội cho bé Johnsons Baby Cotton Touch', N'Sữa tắm gội cho bé dịu nhẹ, không gây kích ứng da', 500, 5000, 200000, 6, 'https://down-vn.img.susercontent.com/file/9681231fddf0d737a2a4fc126ff2f876'),
(N'Kem chống nắng Bioré UV Aqua Rich Watery Essence SPF50+ PA++++', N'Kem chống nắng dạng gel, thấm nhanh, không gây nhờn rít', 200, 2000, 450000, 1, 'https://mint07.com/wp-content/uploads/2015/07/biore-watery-essence.jpeg'),
(N'Mascara Maybelline Lash Sensational', N'Mascara tạo mi dày, cong vút, không vón cục', 150, 1500, 180000, 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1xCYZHkDTXffI3ZMgzths6GWRgkE5WSg14q57MM1Bi3T5RyysmnA63APAR4Ym7klQGIA&usqp=CAU'),
(N'Kem chống nắng Neutrogena Ultra Sheer Dry-Touch SPF 100+', N'Kem chống nắng dạng kem, không gây bết dính, chống tia UVB/UVA', 120, 1200, 300000, 1, 'https://hanguc247.com/wp-content/uploads/2022/11/kem-ch%E1%BB%91ng-n%E1%BA%AFng-neutrogena-ultra-sheer-1.jpg'),
(N'Son dưỡng môi Burt''s Bees Beeswax Lip Balm', N'Son dưỡng môi tự nhiên, giữ ẩm cho đôi môi mềm mại', 200, 2000, 80000, 1, 'https://cdn.vuahanghieu.com/unsafe/0x900/left/top/smart/filters:quality(90)/https://admin.vuahanghieu.com/upload/product/2022/03/son-duong-moi-burt-s-bees-beeswax-lip-balm-with-vitamin-e-peppermint-4-25g-622b18e3cef9c-11032022163947.jpg'),
(N'Nước tẩy trang Micellar Water Garnier', N'Nước tẩy trang dạng micellar, làm sạch nhẹ nhàng', 250, 2500, 120000, 2, 'https://adminbeauty.hvnet.vn/Upload/Files/a1-02112018044051.jpg'),
(N'Tẩy trang mắt Lancome Bi-Facil Double-Action Eye Makeup Remover', N'Tẩy trang mắt kép lớp, loại bỏ mọi vết trang điểm', 100, 1000, 250000, 2, 'https://chiaki.vn/upload/product/2023/08/dung-dich-tay-trang-mat-moi-lancome-bi-facil-double-action-eye-makeup-remover-64d49cfb5968d-10082023151659.jpg'),
(N'Gel tắm gội nam Dove Men+Care Clean Comfort', N'Gel tắm gội 2 trong 1, làm sạch da và tóc nam giới', 300, 3000, 180000, 3, 'https://bizweb.dktcdn.net/100/344/652/products/13g.jpg?v=1669038678457'),
(N'Kem chống nám Olay White Radiance', N'Kem chống nám dưỡng trắng da, giảm tình trạng tăng sắc tố', 150, 1500, 350000, 4, 'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/products/P21180_1_l.webp'),
(N'Nước hoa nữ Chanel Chance Eau Tendre', N'Nước hoa nữ, hương hoa quả nhẹ nhàng, tinh tế', 80, 800, 900000, 5, 'https://bizweb.dktcdn.net/100/429/123/products/nuoc-hoa-nu-chinh-hang-chanel-chance-eau-tendre-edt.jpg?v=1647667387937'),
(N'Kem chống nám Sakura White Pinkish Radiance', N'Kem chống nám dưỡng trắng da, chứa chiết xuất từ hoa anh đào', 180, 1800, 280000, 4, 'https://shopmuanhanh.com/admincp/sanpham/HinhAnh/kem-duong-trang-da-garnier-sakura-white-spf21-thai-lan-20200302235944309.png'),
(N'Son môi YSL Rouge Pur Couture', N'Son lì màu sắc tươi tắn, bền màu suốt thời gian', 120, 1200, 450000, 1, 'https://mint07.com/wp-content/uploads/2020/11/son-ysl-rouge-pur-couture.jpg'),
(N'Kem dưỡng ẩm Neutrogena Hydro Boost Water Gel', N'Kem dưỡng ẩm làm mềm mại và tái tạo làn da', 250, 2500, 200000, 2, 'https://cdn.nhathuoclongchau.com.vn/unsafe/https://cms-prod.s3-sgn09.fptcloud.com/00501475_kem_duong_am_neutrogena_hydro_boost_water_gel_50g_7703_630e_large_90af6742b2.jpg'),
(N'Má hồng Milani Baked Blush', N'Má hồng nung, tạo điểm nhấn, lâu trôi', 100, 1000, 160000, 1, 'https://cf.shopee.vn/file/7e9a1e0c747f0855e0aae463cb7a4c62'),
(N'Sữa rửa mặt Neutrogena Deep Clean Facial Cleanser', N'Sữa rửa mặt sâu lỗ chân lông, làm sạch dầu và bã nhờn', 180, 1800, 150000, 2, 'https://product.hstatic.net/200000061028/product/3021178_1_8e4645df38314362876b6857f0cb88fa_1024x1024.jpg'),
(N'Kem chống nắng Shiseido Perfect UV Protector SPF50+ PA++++', N'Kem chống nắng chống tia UV, làm dịu và dưỡng ẩm da', 150, 1500, 420000, 1, 'https://www.shiseido.com.vn/dw/image/v2/BCSK_PRD/on/demandware.static/-/Sites-itemmaster_shiseido/default/dw5c93bc5f/images/SAPAC/20SS/15678.jpg?sw=1400&sh=1400&sm=fit'),
(N'Tẩy tế bào chết toàn thân The Body Shop Spa of the World', N'Tẩy tế bào chết cả body, giúp da trở nên mềm mại', 120, 1200, 250000, 4, 'https://img.sosanhgia.com/images/500x0/a818b0e8643c4278b4c8090ada7830c0/tay-te-bao-chet-the-body-shop-spa-of-the-world-french-grape-seed-scrub-350ml.jpeg'),
(N'Son lót Innisfree No Sebum Blur Primer', N'Son lót kiểm soát dầu, làm mờ lỗ chân lông', 200, 2000, 120000, 1, 'https://www.innisfree.vn/m/static/upload/product/product/247_ID0101_1.jpg'),
(N'Son môi ColourPop Ultra Matte Lip', N'Son lì màu sắc tươi tắn, siêu bền màu', 100, 1000, 100000, 1, 'https://product.hstatic.net/200000041750/product/son-kem-li-colourpop-ultra-matte-lips-love-bug_82e619fd15174be59fc4bdc215994df7_master.jpg'),
(N'Kem chống nám Hada Labo Shirojyun Premium Whitening Essence', N'Kem dưỡng trắng chống nám, tái tạo làn da từ bên trong', 180, 1800, 300000, 4, 'https://bizweb.dktcdn.net/100/257/549/products/kem-duong-trang-da-cao-cap-hada-labo-shirojyun-premium-medicated-deep-whitening-cream-nhat-ban-04.jpg?v=1587727888477'),
(N'Nước hoa nam Calvin Klein Eternity for Men', N'Nước hoa nam, hương thơm tinh tế, nam tính', 80, 800, 700000, 5, 'https://hangtieudungmy.com.vn/image/cache/catalog/nuoc-hoa-nam-ck-eternity-for-men-800x800.jpg'),
(N'Sữa rửa mặt La Roche-Posay Effaclar Purifying Foaming Gel', N'Sữa rửa mặt chứa nước khoáng, làm sạch sâu cho da dầu mụn', 120, 1200, 250000, 2, 'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/products/P09671_1_l.webp');

CREATE TABLE CART_ITEM (
    cartId INT,
    productId INT,
    quantity INT NOT NULL,
    totalPrice DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (cartId, productId),
    CONSTRAINT fk_cart FOREIGN KEY (cartId) REFERENCES CART(cartId) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_product FOREIGN KEY (productId) REFERENCES PRODUCT(productId) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO CART_ITEM (cartId, productId, quantity, totalPrice)
VALUES
(1, 1, 1, 50000),
(2, 2, 2, 100000),
(3, 3, 3, 150000),
(4, 4, 4, 200000),
(5, 5, 5, 250000),
(6, 6, 6, 300000),
(7, 7, 7, 350000),
(8, 8, 8, 400000),
(9, 2, 1, 50000),
(10, 3, 2, 100000),
(11, 4, 3, 150000),
(12, 5, 4, 200000),
(13, 6, 5, 250000),
(14, 7, 6, 300000),
(15, 8, 7, 350000),
(16, 9, 8, 400000),
(17, 1, 1, 50000),
(18, 2, 2, 100000),
(19, 3, 3, 150000),
(20, 4, 4, 200000);

-- DROP TABLE ORDER_ITEM
CREATE TABLE ORDER_ITEM (
    productId INT,
    orderId INT,
    quantity INT NOT NULL,
    totalPrice DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (productId, orderId),
    CONSTRAINT fk_order FOREIGN KEY (orderId) REFERENCES ORDERS(orderId) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_product2 FOREIGN KEY (productId) REFERENCES PRODUCT(productId) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO ORDER_ITEM (productId, orderId, quantity, totalPrice)
VALUES
(1, 1, 1, 50000),
(2, 2, 2, 100000),
(3, 3, 3, 150000),
(4, 4, 4, 200000),
(5, 5, 5, 250000),
(2, 6, 1, 50000),
(9, 7, 3, 300000),
(7, 8, 3, 150000),
(8, 9, 2, 100000),
(6, 10, 2, 120000),
(10, 11, 1, 450000),
(3, 12, 4, 160000),
(1, 13, 2, 100000),
(8, 14, 3, 300000),
(5, 15, 2, 200000),
(7, 16, 1, 70000),
(9, 17, 3, 180000),
(4, 18, 2, 120000),
(2, 19, 1, 30000),
(10, 20, 4, 400000);

-- DROP TABLE IMPORTING_GOODS
CREATE TABLE IMPORTING_GOODS (
    productId INT,
    supplierId INT,
    quantity INT,
    importingDate DATE,
    cost FLOAT,
    PRIMARY KEY(productId, supplierId),
    FOREIGN KEY (productId) REFERENCES PRODUCT(productId),
    FOREIGN KEY (supplierId) REFERENCES SUPPLIER(supplierId)
) ENGINE=InnoDB;

INSERT INTO IMPORTING_GOODS (productId, supplierId, quantity, importingDate, cost)
VALUES
(1, 2, 50, '2023-12-07', 100000),
(2, 3, 75, '2023-12-05', 200000),
(3, 6, 30, '2023-12-04', 50000),
(4, 5, 20, '2023-12-03', 75000),
(5, 4, 100, '2023-12-02', 300000),
(6, 8, 45, '2023-12-01', 150000),
(7, 1, 25, '2023-11-30', 80000),
(8, 7, 60, '2023-11-29', 250000),
(9, 2, 15, '2023-11-28', 40000),
(10, 3, 40, '2023-11-27', 120000),
(1, 5, 60, '2023-11-26', 180000),
(2, 4, 25, '2023-11-25', 90000),
(4, 8, 50, '2023-11-23', 200000),
(5, 1, 80, '2023-11-22', 240000),
(6, 7, 15, '2023-11-21', 45000),
(7, 2, 55, '2023-11-20', 160000),
(8, 9, 20, '2023-11-19', 100000),
(9, 5, 30, '2023-11-18', 80000),
(10, 1, 65, '2023-11-17', 300000),
(1, 3, 45, '2023-11-16', 150000),
(2, 7, 10, '2023-11-15', 60000),
(3, 2, 70, '2023-11-14', 210000),
(4, 9, 25, '2023-11-13', 95000),
(5, 6, 15, '2023-11-12', 45000),
(6, 4, 50, '2023-11-11', 180000),
(7, 8, 40, '2023-11-10', 120000),
(8, 1, 30, '2023-11-09', 90000);

CREATE TABLE RATING (
    ratingId INT AUTO_INCREMENT PRIMARY KEY,
    productId INT,
    customerId INT,
    rating INT,
    review TEXT,
    reviewDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (productId) REFERENCES PRODUCT(productId),
    FOREIGN KEY (customerId) REFERENCES CUSTOMER(customerId)
) ENGINE=InnoDB;

INSERT INTO RATING (productId, customerId, rating, review, reviewDate)
VALUES
    -- Use nested loops to cover productId (1 to 10) and customerId (1 to 12)
    (1, 1, 5, 'Great product!', '2023-01-01'),
    (1, 2, 4, 'Good service.', '2023-01-02'),
    (1, 3, 3, 'Average experience.', '2023-01-03'),
    (1, 4, 5, 'Amazing!', '2023-01-04'),
    (1, 5, 4, 'Satisfied.', '2023-01-05'),
    (1, 6, 2, 'Disappointed.', '2023-01-06'),
    (1, 7, 5, 'Highly recommended!', '2023-01-07'),
    (1, 8, 4, 'Quick delivery.', '2023-01-08'),
    (1, 9, 3, 'Needs improvement.', '2023-01-09'),
    (1, 10, 5, 'Excellent!', '2023-01-10'),

    (2, 1, 4, 'Satisfied.', '2023-01-05'),
    (2, 2, 2, 'Disappointed.', '2023-01-06'),
    -- ... Continue for productId 2 and customerId 3 to 12
    (2, 12, 5, 'Highly recommended!', '2023-01-07'),

    -- ... Continue for productId 3 to 10 and customerId 1 to 12
    -- ...

    (10, 1, 4, 'Quick delivery.', '2023-01-08'),
    (10, 2, 3, 'Needs improvement.', '2023-01-09'),
    -- ... Continue for productId 10 and customerId 3 to 12
    (10, 12, 5, 'Excellent!', '2023-01-10');

-- select * from ACCOUNT
-- select * from CUSTOMER
-- select * from CART
-- select * from CATEGORY
-- select * from SUPPLIER
-- select * from EMPLOYEE
-- select * from ORDERS
-- select * from PRODUCT
-- select * from ORDER_ITEM
-- select * from IMPORTING_GOODS

DELIMITER $$

CREATE TRIGGER TG_TaoCART
AFTER INSERT ON CUSTOMER
FOR EACH ROW
BEGIN
    DECLARE customerId INT;
    SET customerId = NEW.customerId;
    
    INSERT INTO CART (customerId) 
    VALUES (customerId);
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER TG_TaoTaiKhoanSQL
AFTER INSERT ON Account
FOR EACH ROW
BEGIN
    DECLARE v_username NVARCHAR(30);
    DECLARE v_password NVARCHAR(200);
    DECLARE v_accountID INT;
    DECLARE v_roleID INT;
    DECLARE v_mail VARCHAR(30);

    -- Lấy giá trị từ bảng inserted
    SET v_username = NEW.Username;
    SET v_password = NEW.Password;
    SET v_accountID = NEW.AccountID;
    SET v_roleID = NEW.RoleID;
    SET v_mail = NEW.Mail;

    -- Kiểm tra roleID và thực hiện chèn dữ liệu vào bảng tương ứng
    IF (v_roleID = 1) THEN
        INSERT INTO Customer (Mail, AccountID) VALUES (v_mail, v_accountID);
    ELSEIF (v_roleID = 2) THEN
        INSERT INTO EMPLOYEE (Mail, AccountID, Job) VALUES (v_mail, v_accountID, 'admin');
    ELSEIF (v_roleID = 3) THEN
        INSERT INTO EMPLOYEE (Mail, AccountID, Job) VALUES (v_mail, v_accountID, 'seller');
    ELSEIF (v_roleID = 4) THEN
        INSERT INTO EMPLOYEE (Mail, AccountID, Job) VALUES (v_mail, v_accountID, 'shipper');
    END IF;
END$$

DELIMITER ;