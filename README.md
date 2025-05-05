## 📁 Project Structure
```
├── backend
│   ├── Dockerfile
│   └── k8s
│       ├── deployment.yaml
│       └── service.yaml
├── frontend
│   ├── Dockerfile
│   └── k8s
│       ├── deployment.yaml
│       └── service.yaml
├── jenkins
│   └── Jenkinsfile
├── terraform
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── provider.tf
└── README.md
```

---

## 🔧 Dockerfile – Backend (Go)
```dockerfile
# backend/Dockerfile
FROM golang:1.19 AS build
WORKDIR /app
COPY . .
RUN go mod tidy && go build -o main .

FROM golang:1.19
WORKDIR /app
COPY --from=build /app/main ./main
EXPOSE 8080
CMD ["./main"]
```

---

## 🎨 Dockerfile – Frontend (React)
```dockerfile
# frontend/Dockerfile
FROM node:14.17.0 AS build
WORKDIR /app
COPY . .
RUN npm install && npm run build

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

---

## 🚀 Kubernetes Deployment – Backend
```yaml
# backend/k8s/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: backend
  template:
    metadata:
      labels:
        app: backend
    spec:
      containers:
        - name: backend
          image: <BACKEND_IMAGE_URI>
          ports:
            - containerPort: 8080
          env:
            - name: DB_HOST
              value: <DB_HOST>
            - name: DB_USER
              value: <DB_USER>
            - name: DB_PASSWORD
              value: <DB_PASSWORD>
            - name: DB_NAME
              value: <DB_NAME>
            - name: DB_PORT
              value: "5432"
```

---

## 🌐 Kubernetes Service – Backend
```yaml
# backend/k8s/service.yaml
apiVersion: v1
kind: Service
metadata:
  name: backend-service
spec:
  selector:
    app: backend
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
  type: ClusterIP
```

---

## 🚀 Kubernetes Deployment – Frontend
```yaml
# frontend/k8s/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
        - name: frontend
          image: <FRONTEND_IMAGE_URI>
          ports:
            - containerPort: 80
```

---

## 🌐 Kubernetes Service – Frontend
```yaml
# frontend/k8s/service.yaml
apiVersion: v1
kind: Service
metadata:
  name: frontend-service
spec:
  selector:
    app: frontend
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: LoadBalancer
```

---

## ⚙️ Jenkinsfile
```groovy
pipeline {
  agent any
  environment {
    DOCKER_CREDENTIALS_ID = 'dockerhub-creds'
  }
  stages {
    stage('Build Backend') {
      steps {
        dir('backend') {
          sh 'docker build -t <DOCKER_USER>/employee-backend:latest .'
        }
      }
    }
    stage('Build Frontend') {
      steps {
        dir('frontend') {
          sh 'docker build -t <DOCKER_USER>/employee-frontend:latest .'
        }
      }
    }
    stage('Push Images') {
      steps {
        withCredentials([usernamePassword(credentialsId: env.DOCKER_CREDENTIALS_ID, passwordVariable: 'PASS', usernameVariable: 'USER')]) {
          sh 'echo $PASS | docker login -u $USER --password-stdin'
          sh 'docker push <DOCKER_USER>/employee-backend:latest'
          sh 'docker push <DOCKER_USER>/employee-frontend:latest'
        }
      }
    }
    stage('Deploy to EKS') {
      steps {
        sh 'kubectl apply -f backend/k8s/'
        sh 'kubectl apply -f frontend/k8s/'
      }
    }
  }
}
```

---

## ☁️ Terraform Modules (EKS Example)
```hcl
# terraform/main.tf
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "employee-cluster"
  cluster_version = "1.27"
  subnets         = [<subnet_ids>]
  vpc_id          = <vpc_id>
  manage_aws_auth = true
  node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t3.medium"
    }
  }
}
```

