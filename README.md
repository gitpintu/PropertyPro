# 🏠 PropertyPro - Spring Boot

A full-stack monolithic real estate management platform built with **Java Spring Boot**, enabling buyers and sellers to list, explore, and book property appointments online.

---

## 📁 Project Structure

```
propertypro/
├── pom.xml
├── README.md
└── src/main/
    ├── java/com/propertypro/
    │   ├── PropertyProApplication.java
    │   ├── config/
    │   │   ├── SecurityConfig.java           ← Spring Security + BCrypt
    │   │   ├── SessionAuthFilter.java        ← Session → Spring Security bridge
    │   │   └── WebConfig.java                ← Static file serving for uploads
    │   ├── controller/
    │   │   ├── HomeController.java           ← Home page
    │   │   ├── BuyerController.java          ← Buyer login & registration
    │   │   ├── SellerController.java         ← Seller login, registration,
    │   │   │                                    dashboard, property insert,
    │   │   │                                    buyer info
    │   │   └── PropertyController.java       ← Property explore pages,
    │   │                                        contact & appointment booking
    │   ├── entity/
    │   │   ├── BuyerInfo.java                ← buyer_info table
    │   │   ├── SellerInfo.java               ← seller_info table
    │   │   ├── SellerDashboard.java          ← seller_dashboard table
    │   │   └── BuyerBook.java                ← buyer_book table
    │   ├── repository/
    │   │   ├── BuyerInfoRepository.java
    │   │   ├── SellerInfoRepository.java
    │   │   ├── SellerDashboardRepository.java
    │   │   └── BuyerBookRepository.java
    │   ├── service/
    │   │   ├── BuyerService.java
    │   │   ├── SellerService.java
    │   │   ├── PropertyService.java
    │   │   └── EmailService.java
    │   └── dto/
    │       ├── BuyerRegisterDTO.java
    │       ├── SellerRegisterDTO.java
    │       └── BuyerBookingInfoDTO.java
    └── resources/
        ├── application.properties
        ├── schema.sql
        └── templates/
            ├── index.html
            ├── buyer/
            │   ├── login.html
            │   └── register.html
            ├── seller/
            │   ├── login.html
            │   ├── register.html
            │   ├── dashboard.html
            │   ├── insert.html
            │   └── buyers.html
            └── property/
                ├── explore.html
                └── contact.html
```

---

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| Language | Java 17 |
| Framework | Spring Boot 3 |
| Security | Spring Security 6, BCrypt |
| ORM | Hibernate JPA, Spring Data JPA |
| Database | MySQL 8 |
| Frontend | Thymeleaf, Bootstrap 5, HTML5, CSS3 |
| Email | Spring JavaMailSender (Gmail SMTP) |
| File Upload | MultipartFile + Local Storage |
| Build Tool | Maven |

---

## ✨ Features

- ✅ Buyer & Seller registration and login
- ✅ Session-based authentication with BCrypt password encoding
- ✅ Role-based access control (ROLE_BUYER, ROLE_SELLER)
- ✅ Property listing — Land, Home, Rental categories
- ✅ Dynamic BHK type selection for Home and Rental
- ✅ Property dimensions (Length × Width)
- ✅ Multi-image upload (up to 3 images per property)
- ✅ Appointment booking system
- ✅ Email notification on booking via Gmail SMTP
- ✅ Seller dashboard to manage listings and view bookings
- ✅ Responsive UI with Bootstrap 5

---

## ⚙️ Setup Instructions

### 1. Prerequisites
```
Java 17+
Maven 3.6+
MySQL 8.0+
```

### 2. Clone the Repository
```bash
git clone https://github.com/YOUR_USERNAME/propertypro.git
cd propertypro
```

### 3. Database Setup
```bash
mysql -u root -p < src/main/resources/schema.sql
```

### 4. Configure `application.properties`
```properties
# Database
spring.datasource.url=jdbc:mysql://localhost:3306/propertypro
spring.datasource.username=root
spring.datasource.password=YOUR_PASSWORD

# Email (Gmail SMTP)
spring.mail.host=smtp.gmail.com
spring.mail.port=587
spring.mail.username=your-email@gmail.com
spring.mail.password=your-app-password
spring.mail.properties.mail.smtp.auth=true
spring.mail.properties.mail.smtp.starttls.enable=true

# File Upload
file.upload-dir=uploadimages/
```

> Use a **Gmail App Password** — not your real Gmail password.
> Generate at: Google Account → Security → App Passwords

### 5. Add Static Images
```
src/main/resources/static/images/   ← place your images here
uploadimages/                        ← seller uploaded property images
```

### 6. Run the Application
```bash
mvn spring-boot:run
```

Application starts at: **http://localhost:8080**

---

## 🌐 URL Mapping

| Page | URL |
|---|---|
| Home | `http://localhost:8080/` |
| Buyer Login | `/buyer/login` |
| Buyer Register | `/buyer/register` |
| Seller Login | `/seller/login` |
| Seller Register | `/seller/register` |
| Seller Dashboard | `/seller/dashboard` |
| Add Property | `/seller/insert` |
| View Bookings | `/seller/buyers` |
| Explore Homes | `/property/homes` |
| Explore Land | `/property/land` |
| Explore Rental | `/property/rent` |
| Book Appointment | `/property/contact` |

---

## 🔐 Security

- **BCrypt** password hashing for all user passwords
- **Session-based authentication** via Spring `HttpSession`
- **SessionAuthFilter** bridges HTTP session with Spring Security roles
- **Role-based access control** — sellers can only access seller routes, buyers only buyer routes
- **No SQL injection** — all queries use JPA parameterized methods
- **CSRF disabled** — using session-based custom auth flow
- **File upload validation** via Spring `MultipartFile`

---

## 🗄️ Database Schema

```sql
-- Core tables
buyer_info        ← stores buyer accounts
seller_info       ← stores seller accounts
seller_dashboard  ← stores property listings
buyer_book        ← stores appointment bookings
```

---

## 🚀 Future Scope

- [ ] AWS S3 integration for cloud image storage
- [ ] Twilio SMS notification on appointment booking
- [ ] Microservices migration:
  - Netflix Eureka (Service Registry)
  - Spring Cloud Gateway (API Gateway)
  - Apache Kafka (Event-driven notifications)
- [ ] JWT authentication (replace session-based auth)
- [ ] Docker + Kubernetes deployment
- [ ] CI/CD pipeline with GitHub Actions

---

## 📸 Screenshots

>

---

## 👤 Author

**Your Name**
- GitHub: [@gitpintu](https://github.com/gitpintu)
- LinkedIn: [pintu polai](https://linkedin.com/in/pintupolai)

##End..
