# PropertyPro - Spring Boot

Converted from PHP + phpMyAdmin → **Java Spring Boot + MySQL**

## Project Structure

```
propertypro/
├── pom.xml                                  ← Maven (replaces composer.json)
├── README.md
└── src/main/
    ├── java/com/propertypro/
    │   ├── PropertyProApplication.java       ← Main entry point
    │   ├── config/
    │   │   ├── SecurityConfig.java           ← Spring Security (replaces PHP sessions)
    │   │   └── WebConfig.java               ← Static file serving for uploads
    │   ├── controller/
    │   │   ├── HomeController.java           ← index.php
    │   │   ├── BuyerController.java          ← buyerlogin.php + buyerregister.php
    │   │   ├── SellerController.java         ← sellerlogin.php + sellerregister.php
    │   │   │                                    sellerdashboard.php + seller_insert.php
    │   │   │                                    buyer_info.php
    │   │   └── PropertyController.java       ← homeexplore.php + landexplore.php
    │   │                                        rentexplore.php + contactus.php + mail.php
    │   ├── entity/
    │   │   ├── BuyerInfo.java               ← buyer_info table
    │   │   ├── SellerInfo.java              ← seller_info table
    │   │   ├── PropertyType.java            ← property_type table
    │   │   ├── SellerDashboard.java         ← seller_dashboard table
    │   │   └── BuyerBook.java              ← buyer_book table
    │   ├── repository/                       ← JPA (replaces mysqli_query)
    │   │   ├── BuyerInfoRepository.java
    │   │   ├── SellerInfoRepository.java
    │   │   ├── PropertyTypeRepository.java
    │   │   ├── SellerDashboardRepository.java
    │   │   └── BuyerBookRepository.java
    │   ├── service/
    │   │   ├── BuyerService.java
    │   │   ├── SellerService.java
    │   │   ├── PropertyService.java
    │   │   └── EmailService.java            ← PHPMailer → Spring Mail
    │   └── dto/
    │       ├── BuyerRegisterDTO.java
    │       ├── SellerRegisterDTO.java
    │       └── BuyerBookingInfoDTO.java
    └── resources/
        ├── application.properties           ← conn.php → datasource config
        ├── schema.sql                       ← phpMyAdmin export → MySQL schema
        └── templates/                       ← Thymeleaf (replaces PHP views)
            ├── index.html                   ← index.php
            ├── buyer/
            │   ├── login.html              ← buyerlogin.php
            │   └── register.html           ← buyerregister.php
            ├── seller/
            │   ├── login.html              ← sellerlogin.php
            │   ├── register.html           ← sellerregister.php
            │   ├── dashboard.html          ← sellerdashboard.php
            │   ├── insert.html             ← seller_insert.php
            │   └── buyers.html             ← buyer_info.php
            └── property/
                ├── explore.html            ← homeexplore.php + landexplore.php + rentexplore.php
                └── contact.html            ← contactus.php
```

## PHP → Java Mapping

| PHP File | Java Equivalent |
|---|---|
| `conn.php` | `application.properties` (datasource) |
| `mysqli_connect()` | Spring Data JPA + HikariCP |
| `mysqli_query()` | JpaRepository methods |
| `session_start()` / `$_SESSION` | `HttpSession` |
| `sha1($password)` | `BCryptPasswordEncoder` (more secure!) |
| `move_uploaded_file()` | `MultipartFile` + `Files.copy()` |
| `PHPMailer` | Spring Mail (`JavaMailSender`) |
| PHP `include()` for nav/footer | Thymeleaf `th:replace` / layout |
| `header('location:...')` | `return "redirect:/..."` |

## Setup Instructions

### 1. Prerequisites
- Java 17+
- Maven 3.6+
- MySQL 8.0+

### 2. Database Setup
```bash
mysql -u root -p < src/main/resources/schema.sql
```

### 3. Configure Database
Edit `src/main/resources/application.properties`:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/propertypro
spring.datasource.username=root
spring.datasource.password=YOUR_PASSWORD
```

### 4. Configure Email
```properties
spring.mail.username=your-email@gmail.com
spring.mail.password=your-app-password
```
> Use a Gmail App Password (not your real password)

### 5. Copy Images
Copy your original `images/` and `uploadimages/` folders to:
```
src/main/resources/static/images/
./uploadimages/
```

### 6. Run
```bash
mvn spring-boot:run
```

App starts at: **http://localhost:8080**

## URL Mapping

| Old PHP URL | New Spring Boot URL |
|---|---|
| `localhost/real-estate/index.php` | `localhost:8080/` |
| `buyerlogin.php` | `/buyer/login` |
| `buyerregister.php` | `/buyer/register` |
| `sellerlogin.php` | `/seller/login` |
| `sellerregister.php` | `/seller/register` |
| `sellerdashboard.php` | `/seller/dashboard` |
| `homeexplore.php` | `/property/homes` |
| `landexplore.php` | `/property/land` |
| `rentexplore.php` | `/property/rent` |
| `contactus.php` | `/property/contact` |
| `mail.php` | Handled by `PropertyController` POST |
| `buyer_info.php` | `/seller/buyers` |

## Security Improvements Over PHP Version
- ✅ **BCrypt password hashing** (PHP used SHA1 — now secure)
- ✅ **Session management** via Spring Security HttpSession
- ✅ **No SQL injection** — JPA parameterized queries
- ✅ **File upload validation** via MultipartFile
- ✅ **CSRF protection** configurable via SecurityConfig
