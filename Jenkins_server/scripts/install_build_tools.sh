#!/bin/bash

set -e
export DEBIAN_FRONTEND=noninteractive

echo "========== Updating System =========="
sudo apt update -y
sudo apt upgrade -y

# ---------------------------------------------------------------------
# INSTALL OPENJDK 21 (JAVA 21)
# ---------------------------------------------------------------------

echo "========== Installing OpenJDK 21 =========="
sudo apt install -y openjdk-21-jdk
java -version

# ---------------------------------------------------------------------
# INSTALL JENKINS
# ---------------------------------------------------------------------

echo "========== Installing Jenkins =========="
sudo apt install -y fontconfig wget gnupg

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/" | \
  sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y
sudo apt install -y jenkins

sudo systemctl enable jenkins
sudo systemctl start jenkins

# ---------------------------------------------------------------------
# INSTALL GIT
# ---------------------------------------------------------------------

echo "========== Installing Git =========="
sudo apt install -y git

# ---------------------------------------------------------------------
# INSTALL DOCKER
# ---------------------------------------------------------------------

echo "========== Installing Docker =========="
sudo apt remove -y docker docker-engine docker.io containerd runc || true

sudo apt update -y
sudo apt install -y ca-certificates curl gnupg lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker $USER
sudo usermod -aG docker jenkins
sudo chmod 666 /var/run/docker.sock

sudo systemctl enable docker
sudo systemctl start docker

# ---------------------------------------------------------------------
# RUN SONARQUBE CONTAINER
# ---------------------------------------------------------------------

#echo "========== Starting SonarQube Container =========="
#docker run -d --name sonar -p 9000:9000 sonarqube:lts-community

# ---------------------------------------------------------------------
# INSTALL AWS CLI
# ---------------------------------------------------------------------

echo "========== Installing AWS CLI =========="
sudo apt install unzip -y

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -q awscliv2.zip
sudo ./aws/install

# ---------------------------------------------------------------------
# INSTALL TERRAFORM
# ---------------------------------------------------------------------

echo "========== Installing Terraform =========="
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg

echo \
  "deb [signed-by=/usr/share/keyrings/hashicorp.gpg] \
  https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
  sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update -y
sudo apt install -y terraform

# ---------------------------------------------------------------------
# INSTALL KUBECTL
# ---------------------------------------------------------------------

echo "========== Installing kubectl =========="
curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# ---------------------------------------------------------------------
# INSTALL TRIVY
# ---------------------------------------------------------------------

echo "========== Installing Trivy =========="
sudo apt install -y wget apt-transport-https gnupg lsb-release

wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | \
  sudo gpg --dearmor -o /usr/share/keyrings/trivy.gpg

echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] \
  https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -cs) main" | \
  sudo tee /etc/apt/sources.list.d/trivy.list

sudo apt update -y
sudo apt install -y trivy

# ---------------------------------------------------------------------
# INSTALL HELM
# ---------------------------------------------------------------------

echo "========== Installing Helm =========="
curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

echo ""
echo "======================================================"
echo " ✔ All Tools Installed Successfully on Ubuntu"
echo " ✔ Java 21 Installed"
echo " ✔ Jenkins running on port 8080"
echo " ✔ SonarQube running on port 9000"
echo " ⚠ Reboot recommended (docker group permissions)"
echo "======================================================"
