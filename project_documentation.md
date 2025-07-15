# 📘 PROJECT DOCUMENTATION

---

## 📌 1. PROJECT OVERVIEW

### **Project Name**
**RICHY's** – Dynamic E-commerce Platform

### **Purpose**
Develop a **secure, scalable, and dynamic e-commerce website** that allows customers to browse products by category, manage their cart, checkout, and track order history, with all product and transaction data stored centrally.

### **Scope**
- Frontend: Dynamic single-page application (SPA) with React
- Backend: Python REST API (Flask)
- Database: RDS MySQL
- Image Storage: Amazon S3
- Authentication: JWT-based
- Payments: Stripe Integration
- Notifications: SES Email Service
- Hosting and infrastructure: AWS Free Tier services

---

## 📌 2. ARCHITECTURE OVERVIEW

### **Architecture Diagram**

```
┌─────────────────────────────┐
│        Users                │
└────────────┬────────────────┘
             │ HTTPS
      ┌──────▼──────┐
      │   S3        │
      │  (React SPA)│
      └──────┬──────┘
             │
     ┌───────▼────────────┐
     │  EC2 t2.micro       │
     │ (Flask API)         │
     └───────┬─────────────┘
             │
 ┌───────────▼────────────┐
 │     RDS MySQL          │
 └────────────────────────┘
             │
 ┌───────────▼────────────┐
 │     S3 Buckets         │
 │ (Product Images)       │
 └────────────────────────┘
```

### **AWS Services**

| Service       | Role                               |
|---------------|------------------------------------|
| S3            | SPA hosting + image storage       |
| EC2           | Backend API compute               |
| RDS MySQL     | Relational data storage           |
| SES           | Email notifications               |
| ACM           | Free SSL certificates             |
| Route 53      | Domain & DNS                      |
| CloudWatch    | Logs and monitoring               |

---

## 📌 3. TECHNOLOGY STACK

| Layer           | Technology                            |
|-----------------|---------------------------------------|
| Frontend        | React, HTML5, CSS3, JavaScript       |
| Backend         | Flask (Python 3.x), Gunicorn         |
| Database        | MySQL 8.x (AWS RDS)                  |
| Object Storage  | Amazon S3                            |
| Authentication  | Flask-JWT-Extended                   |
| Payments        | Stripe SDK                           |
| Notifications   | Amazon SES                           |
| DevOps          | AWS CLI, CloudFormation (optional)   |

---

## 📌 4. FUNCTIONAL REQUIREMENTS

### 🎯 Customer Features
- User registration and login
- Browse products by category
- Search products by name
- View product detail page
- Manage shopping cart (add/remove items)
- Checkout process and payment
- Receive order confirmation email
- View order history

### 🎯 Admin Features
- Secure login
- Add/edit/delete products
- Manage categories
- View orders

---

## 📌 5. NON-FUNCTIONAL REQUIREMENTS

| Area                  | Requirement                                                   |
|-----------------------|----------------------------------------------------------------|
| Security              | All traffic over HTTPS, encrypted database, secure JWT        |
| Performance           | API responses < 500ms for catalog queries                     |
| Availability          | 99% uptime (single EC2 instance)                              |
| Scalability           | Can scale EC2 vertically (later)                              |
| Cost                  | 100% Free Tier usage (except domain)                          |
| Logging               | All API requests logged to CloudWatch                         |

---

## 📌 6. DATA MODEL

### 📂 Table: `Users`
| Column        | Type           | Notes                    |
|---------------|----------------|--------------------------|
| id            | INT (PK)       | Auto-increment ID        |
| email         | VARCHAR(255)   | Unique user email        |
| password_hash | VARCHAR(255)   | Bcrypt hashed password   |
| created_at    | TIMESTAMP      | Registration timestamp   |

---

### 📂 Table: `Categories`
| Column        | Type          | Notes            |
|---------------|---------------|------------------|
| id            | INT (PK)      | Category ID      |
| name          | VARCHAR(100)  | Category name    |

---

### 📂 Table: `Products`
| Column        | Type           | Notes                        |
|---------------|----------------|------------------------------|
| id            | INT (PK)       | Product ID                   |
| name          | VARCHAR(255)   | Product name                 |
| description   | TEXT           | Full description             |
| price         | DECIMAL(10,2)  | Product price                |
| category_id   | INT (FK)       | Linked category              |
| image_key     | VARCHAR(255)   | S3 object key                |
| stock_qty     | INT            | Units in stock               |
| created_at    | TIMESTAMP      | Added date                   |

---

### 📂 Table: `Orders`
| Column        | Type            | Notes                    |
|---------------|-----------------|--------------------------|
| id            | INT (PK)        | Order ID                 |
| user_id       | INT (FK)        | Linked user              |
| total_amount  | DECIMAL(10,2)   | Total order amount       |
| status        | VARCHAR(20)     | e.g., "Pending", "Paid"  |
| created_at    | TIMESTAMP       | Order date               |

---

### 📂 Table: `OrderItems`
| Column        | Type           | Notes                      |
|---------------|----------------|----------------------------|
| id            | INT (PK)       | Line item ID               |
| order_id      | INT (FK)       | Linked order               |
| product_id    | INT (FK)       | Linked product             |
| quantity      | INT            | Quantity purchased         |
| unit_price    | DECIMAL(10,2)  | Product price at purchase  |

---

## 📌 7. API SPECIFICATIONS

### 🟢 Authentication

**POST /api/auth/register**
- Input: email, password
- Output: success message

**POST /api/auth/login**
- Input: email, password
- Output: JWT token

---

### 🟢 Product Catalog

**GET /api/products**
- Query: `category`, `search`, `page`
- Output: product list (paginated)

**GET /api/products/{id}**
- Output: product details

**GET /api/categories**
- Output: all categories

---

### 🟢 Cart Management

**POST /api/cart**
- Input: product_id, quantity
- Output: updated cart

**GET /api/cart**
- Output: current cart contents

**DELETE /api/cart/{product_id}**
- Output: updated cart

---

### 🟢 Checkout

**POST /api/checkout**
- Input: payment token (Stripe)
- Output: order confirmation

---

### 🟢 Order History

**GET /api/orders**
- Output: user’s past orders

---

### 🟢 Admin

**POST /api/admin/products**
- Input: product data + image upload
- Output: created product

**PUT /api/admin/products/{id}**
- Input: updated fields
- Output: updated product

**DELETE /api/admin/products/{id}**
- Output: deletion status

---

## 📌 8. SECURITY PLAN

✅ **Authentication**
- JWT tokens issued on login
- Tokens expire after configurable duration

✅ **Authorization**
- Admin endpoints require `is_admin` flag

✅ **Encryption**
- HTTPS enforced via ACM certificate
- S3 buckets encrypted
- MySQL storage encryption

✅ **Password Management**
- Bcrypt hashed passwords (never stored plain)

✅ **Network Controls**
- Security Groups limiting RDS access to EC2 only

✅ **Input Validation**
- All API inputs sanitized

---

## 📌 9. DEPLOYMENT STRATEGY

### **Environments**
- Development (same stack)
- Production (Free Tier)

---

### **Deployment Steps**
1. Create VPC and subnets
2. Launch EC2 t2.micro instance
3. Install Docker, Git, Nginx, Gunicorn
4. Deploy Flask backend container
5. Create RDS MySQL db.t3.micro
6. Configure S3 bucket for SPA hosting
7. Deploy React build to S3
8. Set up Route 53 domain + ACM SSL
9. Configure SES for email sending
10. Set CloudWatch logging

---

## 📌 10. OPERATIONS & MONITORING

✅ **Logging**
- CloudWatch Logs for API access/errors

✅ **Metrics**
- CloudWatch alarms for CPU, memory

✅ **Alerts**
- SES bounce notifications
- Optional SNS notifications for order volume

---

## 📌 11. COST MANAGEMENT

**Free Tier Limits:**
- EC2 t2.micro: 750 hours/month
- RDS t3.micro: 750 hours/month
- S3: 5GB storage
- CloudFront: 1TB/year free
- SES: 62,000 emails/month
- CloudWatch: 5GB logs
- ACM: Free SSL
- Route 53: ~$12/year (domain)

✅ Regular monitoring to avoid overages

---

## 📌 12. FUTURE ENHANCEMENTS

- Elasticache Redis for caching
- Cognito-based authentication
- Auto-scaling with ECS or Kubernetes
- WAF protection layer
- Analytics dashboards

---

# 🎯 CONCLUSION

✅ This documentation covers:

- Architecture
- Tech stack
- Data model
- API contracts
- Security
- Deployment
- Cost management

---
