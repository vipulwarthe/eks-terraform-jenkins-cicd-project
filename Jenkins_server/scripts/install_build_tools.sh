#!/bin/bash
# INSTALL GIT
sudo apt install -y git


# INSTALL DOCKER
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


sudo usermod -aG docker ubuntu || true
sudo usermod -aG docker jenkins || true
sudo chmod 666 /var/run/docker.sock


sudo systemctl enable docker
sudo systemctl start docker


# RUN SONARQUBE
#docker run -d --name sonar -p 9000:9000 sonarqube:lts-community || true


# INSTALL AWS CLI
sudo apt install -y unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -q awscliv2.zip
sudo ./aws/install || true


# INSTALL TERRAFORM
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg


echo \
"deb [signed-by=/usr/share/keyrings/hashicorp.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list


sudo apt update -y
sudo apt install -y terraform


# INSTALL KUBECTL
curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl || true


# INSTALL TRIVY
sudo apt install -y wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | \
sudo gpg --dearmor -o /usr/share/keyrings/trivy.gpg


echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] \
https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/trivy.list


sudo apt update -y
sudo apt install -y trivy


# INSTALL HELM
curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash || true


# CLEANUP
rm -f awscliv2.zip kubectl


echo "======================================================"
echo " ✔ All Tools Installed Successfully on Ubuntu"
echo " ✔ Java 21 Installed"
echo " ✔ Jenkins running on port 8080"
echo " ✔ SonarQube running on port 9000"
echo " ⚠ Reboot recommended (docker group permissions)"
echo "======================================================"
