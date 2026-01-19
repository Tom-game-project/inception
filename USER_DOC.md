# User Documentation

## Service Overview
This stack provides a fully functional WordPress website served securely over HTTPS.

| Service | Description | URL/Port |
| :--- | :--- | :--- |
| **Website** | The main WordPress site | [https://tmuranak.42.fr](https://tmuranak.42.fr) |
| **Database** | MariaDB backend (internal) | Port 3306 (Internal) |
| **Adminer** | Database management GUI | [https://tmuranak.42.fr/adminer](https://tmuranak.42.fr/adminer) |
| **Static Site** | Simple HTML/CSS page | [https://tmuranak.42.fr/static](https://tmuranak.42.fr/static) |

## Starting and Stopping the Project
### Start
Open a terminal in the project root and run:bash
make

```

This will configure the system and launch all services in the background. Wait a few seconds for the database to initialize.

### Stop

To pause the services:

```bash
make stop

```

To shut down and remove containers:

```bash
make down

```

## Accessing the Website

1. Ensure your browser trusts the self-signed certificate (you may see a security warning; proceed by clicking "Advanced" -> "Proceed to...").
2. Navigate to [https://tmuranak.42.fr](https://tmuranak.42.fr).

## Credentials Management

Credentials are stored securely and are not visible in the code repository.

* To view or change credentials, check the `.env` file located in `srcs/.env` (if you have access).
* **Default WordPress Admin**: Defined in `.env` as `WP_ADMIN_USER`.

## Health Checks

To verify that all services are running correctly:

```bash
docker ps

```

All containers (nginx, wordpress, mariadb, etc.) should have a status of `Up`.

If the site is unreachable:

1. Check if the containers are running.
2. Check logs for errors: `docker logs nginx` or `docker logs wordpress`.
