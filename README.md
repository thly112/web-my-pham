# Website Mỹ Phẩm
# Cài Đặt Môi Trường Phát Triển Ứng Dụng Java Web

## 1. Cài Đặt Java Development Kit (JDK 17)
### 1.1 Tải JDK
- Tải JDK 17 từ trang web chính thức:
  - [Oracle JDK](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html)
  - [OpenJDK](https://jdk.java.net/17/)
- Cài đặt JDK theo hướng dẫn tiêu chuẩn.

### 1.2 Thiết Lập Biến Môi Trường
1. Nhấp chuột phải vào **My Computer** → **Properties** → **Advanced system settings** → **Advanced** → **Environment Variables**.
2. Nhấn **New** để tạo một biến môi trường mới:
   - **Tên biến:** `JAVA_HOME`
   - **Giá trị biến:** Đường dẫn đến thư mục cài đặt JDK (ví dụ: `C:\Program Files\Java\jdk-17`).
3. Cập nhật biến `Path`:
   - Thêm `%JAVA_HOME%\bin` vào đầu danh sách giá trị của biến.

## 2. Cài Đặt Eclipse IDE cho Java EE Developers
### 2.1 Tải Xuống và Cấu Hình Eclipse
- Tải **Eclipse IDE for Java EE Developers** từ [Eclipse Downloads](https://www.eclipse.org/downloads/).
- Giải nén file tải xuống và chạy `eclipse.exe` (Windows) hoặc `eclipse` (Linux/Mac).

## 3. Cài Đặt Apache Tomcat 9
### 3.1 Tải Xuống và Giải Nén
- Tải Tomcat 9 (file ZIP) từ [Apache Tomcat website](https://tomcat.apache.org/download-90.cgi).
- Giải nén file ZIP vào một thư mục (ví dụ: `C:\DevTools\Tomcat9`).

### 3.2 Cấu Hình Tomcat
1. Mở thư mục Tomcat đã giải nén, vào `bin`, chạy `startup.bat` (Windows) hoặc `startup.sh` (Linux/Mac).
2. Mở trình duyệt và nhập `http://localhost:8080` để kiểm tra Tomcat đã chạy thành công.

### 3.3 Tích Hợp Tomcat với Eclipse
1. Mở **Eclipse** → **Window** → **Preferences**.
2. Điều hướng đến **Server** → **Runtime Environments** → **Add**.
3. Chọn **Apache Tomcat 9** và nhập đường dẫn thư mục Tomcat.

## 4. Cài Đặt Cơ Sở Dữ Liệu MySQL
### 4.1 Tải Xuống và Cài Đặt MySQL Community Edition
- Tải MySQL Community Server từ [trang web MySQL](https://dev.mysql.com/downloads/mysql/).
- Cài đặt **MySQL Server** và **MySQL Workbench**.
- Trong quá trình cài đặt, thiết lập mật khẩu root và các cài đặt mặc định.

### 4.2 Cấu Hình Kết Nối MySQL
- Mở **MySQL Workbench**.
- Tạo kết nối mới với thông tin đăng nhập root.
- Đảm bảo MySQL Server đang chạy.