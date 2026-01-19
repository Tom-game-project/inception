# Developer Documentation

## Environment Setup
The development environment is containerized using Docker. All services are defined in `srcs/docker-compose.yml`.

### Directory Structure
.
├── Makefile
├── srcs
│   ├──.env                # Environment variables (Credentials)
│   ├── docker-compose.yml  # Orchestration file
│   └── requirements
│       ├── mariadb
│       ├── nginx
│       ├── wordpress
│       └── tools

```

### Prerequisites

* Ensure `srcs/.env` exists. A template is provided below:
```properties
DOMAIN_NAME=tmuranak.42.fr
SQL_DATABASE=wordpress
SQL_USER=wp_user
SQL_PASSWORD=wp_pass
SQL_ROOT_PASSWORD=root_pass
WP_ADMIN_USER=superuser
WP_ADMIN_PASS=super_pass

```



...

```

## Build and Launch
The `Makefile` automates the lifecycle of the project:

- **Build**: `docker-compose -f srcs/docker-compose.yml build`
- **Up**: `docker-compose -f srcs/docker-compose.yml up -d`
- **Logs**: `docker-compose -f srcs/docker-compose.yml logs -f`

To rebuild a specific service (e.g., NGINX) during development:
```bash
docker-compose -f srcs/docker-compose.yml up -d --build nginx

```

## Management Commands

### Accessing Containers

To open a shell inside a running container:

```bash
docker exec -it <container_name> /bin/sh

```

*Example: Debugging MariaDB*

```bash
docker exec -it mariadb mariadb -u root -p

```

### Managing Volumes

Data persistence is handled via Docker volumes mapped to the host system.

* **Location**: `/home/tmuranak/data/`
* **Database**: `/home/tmuranak/data/mariadb`
* **WordPress Files**: `/home/tmuranak/data/wordpress`

To check volume status:

```bash
docker volume ls
docker volume inspect srcs_mariadb

```

## Data Persistence Strategy

The `docker-compose.yml` configures volumes with `driver_opts` to bind mount specific host directories.

* This ensures that even if containers are destroyed (`docker-compose down`), the data remains in `/home/tmuranak/data`.
* To reset data completely, run `make fclean` (requires sudo permissions to delete root-owned database files).

