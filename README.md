# Docker Learning Journey 🐳

A hands-on, progressive learning path through Docker fundamentals, from basic images to full-stack multi-container applications with Docker Compose.

## 📚 What's Inside

This repository contains 6 practical lessons, each building upon the previous one:

### [01_images](./01_images) - Your First Docker Image
Learn the basics of Docker images and containers with a simple Node.js web application.
- Writing your first Dockerfile
- Building images
- Running containers with port mapping
- **Tech**: Node.js, Express

### [02_interactive](./02_interactive) - Interactive Containers
Explore interactive containers that accept user input.
- Using `-it` flags for interactive mode
- Working with stdin/stdout in containers
- **Tech**: Python

### [03_volumes](./03_volumes) - Data Persistence
Master Docker volumes for persistent data and development workflows.
- Named volumes for data persistence
- Bind mounts for live code reloading
- Anonymous volumes for dependencies
- **Tech**: Node.js, Express

### [04_networking](./04_networking) - Container Networking
Learn how containers communicate with each other and external services.
- Creating Docker networks
- Container-to-container communication
- External API calls from containers
- **Tech**: Node.js, MongoDB, Star Wars API

### [05_multicon](./05_multicon) - Multi-Container Apps (Manual)
Build a full-stack application with manually orchestrated containers.
- Setting up a 3-tier architecture
- Managing multiple containers manually
- Understanding inter-service communication
- **Tech**: React, Node.js, Express, MongoDB

### [06_compose](./06_compose) - Docker Compose Orchestration
Simplify multi-container management with Docker Compose.
- Declarative multi-container setup
- Service dependencies
- Environment variable management
- Development workflows with hot reload
- **Tech**: React, Node.js, Express, MongoDB

## 🚀 Quick Start

### Prerequisites
- Docker installed on your machine ([Get Docker](https://docs.docker.com/get-docker/))
- Basic command line knowledge

### Try Your First Example

```bash
# Navigate to the basics
cd 01_images

# Build the image
docker build -t node-demo .

# Run the container
docker run -p 80:80 --rm node-demo

# Visit http://localhost in your browser
```

### Jump to the Full Stack Example

```bash
# Navigate to the Docker Compose example
cd 06_compose

# Start all services (React frontend, Node.js backend, MongoDB)
docker-compose up

# Visit http://localhost:3000 in your browser

# Stop everything
docker-compose down
```

## 📖 Learning Path

I recommend following the lessons in order:

1. **Start with 01_images** - Get comfortable with basic Docker concepts
2. **Progress through 02-04** - Learn about interactivity, volumes, and networking
3. **Tackle 05_multicon** - See the complexity of manual orchestration
4. **Master 06_compose** - Appreciate how Docker Compose simplifies everything

Each directory contains a complete, runnable example with its own Dockerfile(s) and source code.

## 🛠️ Common Commands Reference

### Basic Docker Commands
```bash
# Build an image
docker build -t image-name .

# Run a container
docker run -p host-port:container-port image-name

# List running containers
docker ps

# Stop a container
docker stop container-name

# Remove a container
docker rm container-name

# List images
docker images

# Remove an image
docker rmi image-name
```

### Docker Compose Commands
```bash
# Start all services in detached mode
docker-compose up -d

# View logs
docker-compose logs -f

# Stop and remove containers
docker-compose down

# Stop and remove containers + volumes
docker-compose down -v

# Rebuild and start
docker-compose up --build
```

## 🎯 What You'll Learn

By completing these lessons, you'll understand:

- ✅ How to containerize applications with Dockerfiles
- ✅ Image building and container lifecycle management
- ✅ Data persistence with volumes and bind mounts
- ✅ Container networking and inter-service communication
- ✅ Multi-container application architecture
- ✅ Docker Compose for orchestration
- ✅ Development workflows with hot reload
- ✅ Environment variable management
- ✅ Best practices for `.dockerignore` files

## 🏗️ Architecture Overview

The final lessons (05 & 06) implement a complete 3-tier architecture:

```
┌─────────────────────────────────────────────────────────┐
│  Frontend (React SPA)                                   │
│  Port: 3000                                             │
│  - User interface for managing goals                    │
│  - Hot reload for development                           │
└─────────────────┬───────────────────────────────────────┘
                  │ HTTP Requests
                  ↓
┌─────────────────────────────────────────────────────────┐
│  Backend (Node.js/Express API)                          │
│  Port: 80                                               │
│  - REST API endpoints: GET/POST /goals, DELETE /goals   │
│  - Morgan logging                                       │
│  - CORS enabled                                         │
└─────────────────┬───────────────────────────────────────┘
                  │ MongoDB Protocol
                  ↓
┌─────────────────────────────────────────────────────────┐
│  Database (MongoDB)                                     │
│  Port: 27017 (internal)                                 │
│  - Persistent data storage                              │
│  - Authentication enabled                               │
└─────────────────────────────────────────────────────────┘
```

## 🔧 Tips for Learning

- **Experiment**: Modify the code and Dockerfiles to see what happens
- **Read the logs**: Use `docker logs` or `docker-compose logs` to debug
- **Clean up**: Regularly remove unused containers and images to save space
- **Compare 05 and 06**: See how Docker Compose simplifies the same application
- **Check the WARP.md**: Contains detailed technical documentation for each lesson

## 📝 Notes

- Volume paths in some examples may need adjustment for your system
- MongoDB credentials are hardcoded for learning purposes (never do this in production!)
- The React development server requires `stdin_open` and `tty` flags
- `.dockerignore` files help keep your images lean by excluding unnecessary files

## 🤝 Contributing

This is a personal learning repository, but suggestions and improvements are welcome!

## 📄 License

Free to use for learning purposes.

---

**Happy Dockerizing! 🐳**
