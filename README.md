*This project has been created as part of the 42 curriculum by tmuranak*

# Inception

## Description

This project aims to broaden the knowledge of system administration by using Docker. It involves virtualizing several Docker images to create a personal virtual machine infrastructure. The goal is to set up a complete web server stack using containerization best practices, ensuring modularity, security, and scalability.

The infrastructure consists of:

* **NGINX**: A secured web server supporting TLSv1.2/1.3.
* **WordPress**: Running with PHP-FPM.
* **MariaDB**: Relational database.
* **Bonus Services**: Redis (Cache), FTP Server, Adminer, and a Static Website.

## Instructions

### Prerequisites

* Docker Engine
* Docker Compose
* Make

### Setup & Execution

1. **Configure Hostname**:
Add the following line to your `/etc/hosts` file to map the domain to your local machine

```bash
127.0.0.1   tmuranak.42.fr

```


2. **Launch the Infrastructure**:
Run the following command at the root of the repository. This will build the images and start the containers.
```bash
make

```


*Note: The Makefile automatically creates the required data directories at `/home/tmuranak/data/`.*
3. **Access the Site**:
Open your browser and visit `https://tmuranak.42.fr`.
4. **Stop and Clean**:
To stop the services and remove containers/networks:
```bash
make down

```


To completely remove everything including persistent data volumes:
```bash
make fclean

```



## Project Description & Design Choices

### Virtual Machines vs Docker

* **Virtual Machines (VM)** emulate an entire hardware stack, including the kernel, which makes them heavy and resource-intensive.
* **Docker Containers** share the host OS kernel and isolate the application processes in userspace. This makes them lightweight, fast to start, and portable ("Build once, run anywhere").

### Secrets vs Environment Variables

* **Environment Variables**: Useful for non-sensitive configuration (e.g., domain name, theme color). However, they can be inspected via `docker inspect`.
* **Docker Secrets**: The secure way to manage sensitive data (passwords, API keys). In this project, secrets are mounted as files in `/run/secrets/`, preventing them from being exposed in environment logs or inspection commands.

### Docker Network vs Host Network

* **Host Network**: The container shares the host's networking namespace. This offers performance but sacrifices isolation (port conflicts may occur).
* **Docker Network (Bridge)**: Creates an isolated network where containers communicate via DNS names (e.g., `ping mariadb`). This project uses a custom bridge network to strictly control traffic (only NGINX is exposed to the outside).

### Docker Volumes vs Bind Mounts

* **Bind Mounts**: Directly maps a host file/directory to a container path. Useful for development and persistence on a specific host path.
* **Docker Volumes**: Managed by Docker (usually in `/var/lib/docker/volumes`).
* **Project Choice**: We use **Bind Mounts via Named Volumes** (`driver_opts`) to satisfy the requirement of storing data in `/home/tmuranak/data` while maintaining the abstraction of Docker Volumes.

## Resources

-(https://docs.docker.com/)

-(https://wiki.alpinelinux.org/)

-(https://nginx.org/en/docs/)

* *AI Usage*: AI tools were used to generate boilerplate code for configuration files and to debug complex Docker network issues. All generated code was reviewed and tested manually.

