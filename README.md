# ✅ TODO Application – Java JSP/Servlets with CI/CD on AWS EKS

A Java-based TODO application developed using JSP, Servlet, JDBC, and MySQL. The application is containerized using Docker, deployed to **Amazon EKS** using Kubernetes, and follows a **CI/CD pipeline managed by Jenkins**. All infrastructure (EKS, VPC, IAM, ECR, etc.) is provisioned using **Terraform** and made accessible externally through an **NGINX Ingress controller**.

---

##  Features

- Add TODO
- Edit TODO
- List TODOs
- Delete TODO
- User Login
- User Signup
- Responsive layout

---

## Technology Stack

- Java 8+
- JSP & Servlets
- JDBC
- MySQL
- Apache Tomcat 9
- Maven
- Docker
- Jenkins
- Kubernetes (EKS)
- Terraform
- AWS Services (EKS, ECR, EC2, IAM, VPC, ALB)

---

## Project Tutorial (Credits)

Refer to the blog tutorial for the core TODO application logic:  
🔗 [Build TODO App using JSP, Servlet, JDBC and MySQL – JavaGuides](https://www.javaguides.net/2019/10/build-todo-app-using-jsp-servlet-jdbc-and-mysql.html)

---

## Prerequisites

Ensure the following tools are installed and configured:

- Docker
- AWS CLI
- `kubectl`
- Terraform
- Maven
- Jenkins (with AWS CLI, Docker, and Kubernetes plugins)
- An IAM user with access to:
  - EKS
  - EC2
  - ECR
  - IAM
  - VPC

---

## Jenkins Pipeline Stages

The `Jenkinsfile` automates the CI/CD process through the following stages:

1. **Checkout Code** – Clones the GitHub repository
2. **Build WAR** – Uses Maven to package the WAR file
3. **Dockerize App** – Builds the Docker image using the WAR
4. **Push to ECR** – Pushes the Docker image to AWS ECR
5. **Deploy to EKS** – Applies Kubernetes manifests to EKS
6. **Expose via Ingress** – Makes the application accessible over the internet

---

## Docker Configuration

```Dockerfile
FROM public.ecr.aws/docker/library/tomcat:9.0.97-jdk8-corretto
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY target/vamc-todo-app.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
```

- The WAR file is built using Maven and copied to Tomcat's `webapps` directory.
- Exposes the app on **port 8080**.

---

## Kubernetes Deployment

### Files in `manifests/`:

- **`mysql.yml`** – Deploys MySQL pod, persistent volume, and ClusterIP service for internal DB access.
- **`tomcat.yml`** – Deploys the TODO web app via Tomcat and connects to MySQL.
- **`ingress.yml`** – Configures Ingress to route external traffic from ALB to the Tomcat service.

### Apply to EKS:

```bash
kubectl apply -f manifests/
kubectl get ingress
```

Use the resulting Load Balancer URL to access the application in the browser.

---

## Accessing the Application

Once the pipeline runs successfully:

1. Run:
   ```bash
   kubectl get ingress
   ```
2. Copy the ALB DNS name (e.g., `http://abcd1234.elb.ap-south-1.amazonaws.com/`)
3. Open it in a browser.

You will land on the **login page**.  
Register → Add/View/Edit/Delete TODOs.

---

## Terraform Architecture Overview

Terraform scripts are located in the `ci-cd-roles/` directory and are responsible for provisioning all necessary cloud infrastructure.

### What Terraform Provisions:

1. **Custom VPC & Networking**
   - Public & private subnets across multiple Availability Zones
   - Routing tables, Internet Gateway, and NAT Gateway
   - Ensures high availability and traffic routing

2. **Amazon EKS Cluster**
   - Fully managed Kubernetes cluster
   - Managed node groups across AZs
   - Linked with correct IAM roles and security groups

3. **Jenkins EC2 Instance**
   - Launches Jenkins on EC2 using `jenkins.sh` script
   - Installs Docker, Jenkins, and AWS CLI
   - IAM roles allow secure access to EKS and ECR

4. **IAM Roles & Policies**
   - Role for EKS cluster to manage nodes and pods
   - Role for Jenkins EC2 to pull/push Docker images and access Kubernetes

5. **Amazon ECR**
   - Private container registry for storing Docker images
   - Jenkins pushes the built image after successful build

---

### Terraform Commands

```bash
cd ci-cd-roles/
terraform init
terraform plan
terraform apply
```

(Optional):
```bash
terraform plan -out=tfplan
terraform apply tfplan
```

---

## Author

**G. Vamshidhar**  
GitHub: [@Vamcdhar03](https://github.com/Vamcdhar03)


