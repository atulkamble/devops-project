// ssh connect -ec2
type: large 
storage: 40GB ebs

SG: 22, 80, 8080

```
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
```

```
cd Downloads
chmod 400 server.pem
ssh -i "server.pem" ec2-user@ec2-54-167-232-164.compute-1.amazonaws.com
```
// install and configure git, docker, terraform, jenkins on ec2 
```
sudo dnf update -y
sudo dnf install git -y
git --version

sudo dnf install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
sudo docker version

# Add HashiCorp repo
sudo dnf install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

# Install Terraform
sudo dnf install terraform -y
terraform -version

sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

sudo dnf install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
systemctl status jenkins

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

// 200190bbfcd34bd18f14967faca2badb
```
// project set up 
```
git clone https://github.com/atulkamble/devops-project.git
cd devops-project/

mkdir docker
cd docker
```
// run 
```
sudo docker run -d -p 3000:3000 atuljkamble/frontend
```
```
Backend
backend is written in go version 1.19
backend server starts at port 8080

## How to run
    1. Make sure you have go version 1.19 installed
    2. go get ./...
    3. DB_HOST=<POSTGRES_HOST> DB_USER=<POSTGRES_USER> DB_PASSWORD=<POSTGRES_PASSWORD> DB_NAME=<POSTGRES_DB_NAME> DB_PORT=<POSTGRES_PORT> ALLOWED_ORIGINS=<ALLOWED_ORGINS_VALUE> go run main.go
```
// install go 
```
sudo dnf install wget -y
wget https://go.dev/dl/go1.19.13.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.19.13.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc
go version
```
// set back env and run server 
```
cd ~/devops-project/backend/
```
```
# Replace values with your DB credentials
export DB_HOST=localhost
export DB_USER=postgres
export DB_PASSWORD=admin123
export DB_NAME=employees
export DB_PORT=5432
export ALLOWED_ORIGINS=http://localhost:3000

go get ./...
go run main.go

nano backend.sh
chmod +x ./backend.sh
```
# Build Docker image
```
sudo docker build -t go-backend .
```
# Run backend container with environment variables
```
sudo docker run -d \
  --name backend \
  -p 8080:8080 \
  -e DB_HOST=localhost \
  -e DB_USER=postgres \
  -e DB_PASSWORD=admin123 \
  -e DB_NAME=employees \
  -e DB_PORT=5432 \
  -e ALLOWED_ORIGINS=http://localhost:3000 \
  go-backend
```
// docker compose 
```
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose version
sudo docker-compose up -d --build
```
```
docker logs backend
docker logs postgres
```
```
FROM golang:1.19 AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o server main.go

FROM golang:1.19
WORKDIR /app
COPY --from=build /app/server .
COPY wait-for.sh .

# Add pg_isready from official image
COPY --from=postgres:14 /usr/bin/pg_isready /usr/bin/

RUN chmod +x wait-for.sh

EXPOSE 8080
CMD ["./wait-for.sh", "postgres", "./server"]
```
```
sudo yum update -y
sudo yum install -y curl wget unzip bash-completion conntrack
```
```
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
```
# This overwrites any existing configuration in /etc/yum.repos.d/kubernetes.repo
```
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.33/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.33/rpm/repodata/repomd.xml.key
EOF
```
```
sudo yum install -y kubectl
```
```
sudo curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo chmod +x minikube-linux-amd64
sudo mv minikube-linux-amd64 /usr/local/bin/minikube
```
```
minikube start --driver=docker
```
// jenkins port change 
```
sudo nano /usr/lib/systemd/system/jenkins.service
sudo systemctl daemon-reload
sudo systemctl restart jenkins
```
// add line 
```
ExecStart=/usr/bin/java -jar /usr/lib/jenkins/jenkins.war --httpPort=8090
```
