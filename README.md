CRUD MEAN Application with Docker and CI/CD Deployment

This repository contains a complete MEAN stack application (MongoDB, Express/Node.js, Angular, and Nginx) containerized with Docker and deployed on an Azure Virtual Machine using GitHub Actions for CI/CD.

The application includes:

 - Angular frontend

 - Node.js Express backend

 - MongoDB database

 - Nginx reverse proxy

 - Automated CI/CD pipeline

 ## Project setup

### Node.js Server

cd backend

npm install

You can update the MongoDB credentials by modifying the `db.config.js` file located in `app/config/`.

Run `node server.js`

### Angular Client

cd frontend

npm install

Run `ng serve --port 8081`

You can modify the `src/app/services/tutorial.service.ts` file to adjust how the frontend interacts with the backend.

Navigate to `http://localhost:8081/`

1. Project Structure
crud-mean-app/
    backend/
        Dockerfile
        server.js
        app/
        package.json
    frontend/
        Dockerfile
        src/
        package.json
    nginx/
        nginx.conf
        frontend.conf
    docker-compose.prod.yml
    docker-compose.yml
    .github/workflows/ci-cd.yml
    README.md

2. Prerequisites

 - Azure Virtual Machine

 - Docker and Docker Compose installed on the VM

 - GitHub repository

 - Docker Hub account

 - SSH key pair for GitHub Actions deployment

3. Local Setup (Optional)
 - Clone the repository
 - git clone https://github.com/<your-username>/crud-mean-app.git
 - cd crud-mean-app

 - Build and run locally
 - docker compose up -d


Application will be available at:

Frontend: http://localhost

API: http://localhost/api/tutorials

4. Production Deployment on Azure VM
 - Step 1: Install Docker on the VM
 - curl -fsSL https://get.docker.com -o get-docker.sh
 - sudo sh get-docker.sh
 - sudo usermod -aG docker $USER


Logout and re-login.

Step 2: Install Docker Compose
 - sudo apt install docker-compose-plugin -y


Verify:

 - docker compose version

Step 3: Upload project to VM

 - Clone your GitHub repository to the VM:

 - git clone https://github.com/<your-username>/crud-mean-app.git

Step 4: Create environment directory on VM
 - mkdir -p ~/crud-mean-app


Place the production docker-compose file there:

 - docker-compose.prod.yml

5. Docker Compose Production Configuration

Your production compose file includes:

 - frontend service

 - backend service

 - mongo database service

 - nginx reverse proxy service

To start:

 - docker compose -f docker-compose.prod.yml up -d


Check containers:

 - docker ps

6. Nginx Reverse Proxy Setup

Nginx routes:

All Angular UI traffic to frontend container

All API traffic to backend container under /api

Key section:

location /api/ {
    proxy_pass http://backend_up/api/;
}


Nginx runs inside a container, loaded from:

 - nginx/nginx.conf

7. CI/CD Pipeline Setup

GitHub Actions workflow is located at:

 - .github/workflows/ci-cd.yml


The pipeline performs:

 - Checkout repository

 - Build frontend and backend Docker images

 - Push images to Docker Hub

 - Connect to Azure VM via SSH

 - Pull latest updated images

 - Restart Docker containers

8. Configuring GitHub Secrets

 - Add the following repository secrets:

    Secret Name	Description
    DOCKERHUB_USERNAME	Your Docker Hub username
    DOCKERHUB_TOKEN	Docker Hub access token
    VM_HOST	Azure VM public IP
    VM_USER	VM username (e.g., azureuser)
    VM_SSH_PORT	SSH port (usually 22)
    SSH_PRIVATE_KEY	Contents of your private SSH key

9. Running the CI/CD Workflow

 - A deployment occurs automatically whenever:

 - Changes are pushed to the main branch

 - Workflow is triggered manually

View progress at:

    GitHub
    Actions tab
    CI/CD - Build and Deploy

10. Manual Deployment Verification
    Check running containers on VM
     - docker compose -f docker-compose.prod.yml ps

Verify backend API
 - curl http://<vm-ip>/api/tutorials

Verify frontend UI

Open in browser:

 - http://<vm-ip>

12. Troubleshooting
Issue: Cannot connect to MongoDB

 - Check connectivity:

 - docker exec -it <backend-container> nc -zv mongo 27017

Issue: Frontend cannot call backend API

 - Check Nginx configuration and ensure Angular uses:

 - const baseUrl = '/api/tutorials';

Issue: CI/CD deployment failing

Verify:

 - SSH key matches the VM authorized_keys

 - Docker Hub credentials are correct

 - docker-compose.prod.yml exists on the VM