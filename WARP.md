# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Repository Overview

This is a Docker learning repository containing progressive examples demonstrating Docker concepts from basic images to multi-container applications with Docker Compose. Each numbered directory represents a complete, self-contained lesson with working code.

## Project Structure

```
01_images/         # Basic Dockerfile and image building (Node.js web app)
02_interactive/    # Interactive containers with stdin/stdout (Python RNG)
03_volumes/        # Volume mounting and data persistence (Node.js feedback app)
04_networking/     # Container networking and external API calls (MongoDB + Star Wars API)
05_multicon/       # Multi-container setup without Compose (React + Node + MongoDB)
06_compose/        # Docker Compose orchestration (React + Node + MongoDB)
```

## Common Commands

### Building and Running Individual Examples

**01_images (Basic Image)**
```bash
cd 01_images
docker build -t node-demo .
docker run -p 80:80 --rm node-demo
# Access at http://localhost
```

**02_interactive (Interactive Container)**
```bash
cd 02_interactive
docker build -t python-rng .
docker run -it --rm python-rng
```

**03_volumes (Volume Mounting)**
```bash
cd 03_volumes
docker build -t feedback-node .
docker run -p 80:80 --rm -v feedback:/app/feedback -v "$(pwd):/app" -v /app/node_modules feedback-node
# Named volume 'feedback' persists data, bind mount for live reload
```

**04_networking (Container Networking)**
```bash
cd 04_networking
# Start MongoDB first
docker run -d --name mongodb --network goals-net mongo
docker build -t favorites-node .
docker run -p 3000:3000 --rm --network goals-net favorites-node
```

**05_multicon (Multi-Container Manual Setup)**
```bash
cd 05_multicon
# Create network
docker network create goals-net
# Start MongoDB
docker run -d --name mongodb --network goals-net -e MONGO_INITDB_ROOT_USERNAME=samedy -e MONGO_INITDB_ROOT_PASSWORD=secret mongo
# Build and run backend
docker build -t goals-backend ./backend
docker run -d --name goals-backend --network goals-net -p 80:80 goals-backend
# Build and run frontend
docker build -t goals-frontend ./frontend
docker run -it --rm --name goals-frontend -p 3000:3000 goals-frontend
```

**06_compose (Docker Compose - PREFERRED)**
```bash
cd 06_compose
docker-compose up -d          # Start all services
docker-compose down           # Stop and remove containers
docker-compose down -v        # Stop and remove containers + volumes
docker-compose logs           # View logs from all services
docker-compose logs backend   # View logs from specific service
docker-compose build          # Rebuild images
docker-compose up --build     # Rebuild and start
```

## Architecture Patterns

### Multi-Tier Application Stack (05_multicon, 06_compose)

**Frontend (React SPA)**
- Port 3000
- Development server with hot reload via volume mounting
- Communicates with backend at `http://localhost` (port 80)
- Uses `stdin_open: true` and `tty: true` for interactive mode

**Backend (Node.js/Express API)**
- Port 80
- REST API endpoints: GET/POST /goals, DELETE /goals/:id
- Morgan logging to `/app/logs` (persisted via named volume)
- Connects to MongoDB using service name `mongodb` as hostname
- Environment variables for MongoDB credentials

**Database (MongoDB)**
- Internal port 27017 (not exposed to host in Compose setup)
- Persistent data via named volume `data:/data/db`
- Authentication enabled with credentials in env files
- Read-only volume mount in Compose for safety

### Volume Strategy

**Named Volumes** - For persistent data that shouldn't be in source control:
- `data:/data/db` (MongoDB data)
- `logs:/app/logs` (Application logs)

**Bind Mounts** - For development with hot reload:
- `./backend:/app` (Backend source code)
- `./frontend/src:/app/src` (Frontend source code)
- Always exclude `node_modules` with anonymous volume: `/app/node_modules`

### Networking

- Docker Compose automatically creates a shared network (`goals-net`)
- Services communicate using service names as hostnames (e.g., `mongodb:27017`)
- For manual multi-container: create network with `docker network create`
- Host machine access: use `host.docker.internal` (visible in 04_networking/app.js line 71)

## Docker Compose Configuration

The `06_compose/docker-compose.yaml` demonstrates:
- Service dependencies with `depends_on`
- Environment variable files in `./env/` directory
- Build context specification for custom images
- Named volumes and bind mounts
- Network isolation
- Port mapping for host access

## Development Workflow

1. **For quick iteration**: Use bind mounts to enable hot reload without rebuilding
2. **For testing builds**: Remove bind mounts and rebuild images
3. **For MongoDB changes**: Use named volumes to persist data across container restarts
4. **For multi-container**: Always prefer Docker Compose over manual container management

## Important Notes

- `.dockerignore` files exclude `node_modules`, `Dockerfile`, and `.git` from build context
- MongoDB connection strings differ between manual setup and Compose (service name vs host.docker.internal)
- Frontend requires `stdin_open` and `tty` for React development server
- Backend uses environment variables for configuration (check `env/` directory in 06_compose)
- Volume paths in docker-commands.txt contain example absolute paths that need adjustment per system
