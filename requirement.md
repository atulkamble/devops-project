````markdown
# 📦 CI/CD Pipeline with EKS & Terraform – Project Requirements

## 🎯 Objective

To implement a CI/CD pipeline using Jenkins (or any preferred CI/CD tool) and deploy a containerized **Employee Management System** application on **Amazon EKS (Elastic Kubernetes Service)**. All infrastructure should be provisioned via **Terraform**.

---

## 📁 Application Overview

Sample App Repo: [GitHub - TechVerito Fullstack App](https://github.com/TechVerito-Software-Solutions-LLP/devops-fullstack-app.git)

This is a full-stack microservices-based application for managing employee data.

### 🔧 Backend
- **Language:** Golang (version 1.19)
- **Port:** 8080
- **Startup Command:**
  ```bash
  DB_HOST=<POSTGRES_HOST> DB_USER=<POSTGRES_USER> DB_PASSWORD=<POSTGRES_PASSWORD> DB_NAME=<POSTGRES_DB_NAME> DB_PORT=<POSTGRES_PORT> ALLOWED_ORIGINS=<ALLOWED_ORIGINS_VALUE> go run main.go
````

### 🎨 Frontend

* **Framework:** ReactJS
* **Node Version:** 14.17.0
* **Port:** 3000
* **Startup Command:**

  ```bash
  npm install
  npm start
  ```

---

## 🛠️ Requirements

### ✅ Functional

* [ ] Containerize both **frontend** and **backend** using Docker.
* [ ] Create and configure **CI/CD pipeline** (Jenkins preferred) to:

  * Build Docker images.
  * Push to a container registry (e.g., ECR).
  * Deploy to EKS using Kubernetes manifests.
* [ ] Provision all infrastructure using **Terraform**, including:

  * VPC, Subnets, Security Groups
  * EKS Cluster & Node Groups
  * IAM roles and policies
* [ ] Deploy both services (frontend/backend) on Kubernetes.
* [ ] Expose services using LoadBalancer/Ingress so the app is publicly accessible.
* [ ] Ensure data flow is functional — adding/viewing employee records.

### 📂 Infrastructure as Code (IaC)

* [ ] Use **Terraform** for:

  * Networking (VPC, subnets, routes)
  * EKS Cluster & Worker Nodes
  * IAM Roles for EKS, EC2, etc.

### 🔄 CI/CD Pipeline Tasks

* [ ] GitHub Webhook (Optional)
* [ ] Build and Test app
* [ ] Docker Image Creation
* [ ] Push to Docker/ECR
* [ ] Kubernetes Deploy/Apply

---

## ✅ Success Criteria

* ✅ Application deployed successfully on AWS EKS.
* ✅ Frontend is publicly accessible.
* ✅ You can add/view employee data via the UI.
* ✅ Jenkins pipeline runs automatically on code changes (CI/CD).
* ✅ Infrastructure is reproducible using Terraform.

---

## 🔗 References

* Terraform AWS Provider: [https://registry.terraform.io/providers/hashicorp/aws/latest/docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
* AWS EKS Docs: [https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)
* Jenkins Docs: [https://www.jenkins.io/doc/](https://www.jenkins.io/doc/)
* Docker: [https://docs.docker.com/](https://docs.docker.com/)

---

🧑‍💻 *Project by:* \[Atul Kamble / Cloudnautic]
📅 *Created on:* `May 2025`

```
