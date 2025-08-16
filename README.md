# Railway Template: WordPress with MySQL and phpMyAdmin (High Upload Limits)

This Railway template deploys a WordPress site with a MySQL database and phpMyAdmin for database management, configured with high upload limits (256MB) for WordPress media, themes, plugins, and SQL imports. It uses Docker images for consistency and leverages Railway's private networking and volume persistence for secure, reliable operation.

## Template Overview

The template defines three services:
1. **WordPress**: Runs the WordPress application with a custom `php.ini` to support 256MB uploads.
2. **MySQL**: Provides the database backend for WordPress.
3. **phpMyAdmin**: Offers a web interface for managing the MySQL database, with a 256MB SQL import limit.

The services are interconnected using Railway's private networking, and persistent volumes ensure data retention across deployments. Environment variables and Railway's variable substitution (e.g., `random(32)`) ensure secure configuration.

## Template Components

### 1. WordPress Service
- **Image**: `wordpress:latest` (official WordPress Docker image with Apache and PHP).
- **Purpose**: Runs the WordPress application, serving the website via HTTP.
- **Configuration**:
  - **Port**: Exposes port 80 for public access.
  - **Environment Variables**:
    - `WORDPRESS_DB_HOST`: Set to `${{mysql.MYSQLHOST}}` (MySQL's private network hostname).
    - `WORDPRESS_DB_USER`: Set to `${{mysql.MYSQLUSER}}` (MySQL user for WordPress).
    - `WORDPRESS_DB_PASSWORD`: Set to `${{mysql.MYSQLPASSWORD}}` (MySQL password).
    - `WORDPRESS_DB_NAME`: Set to `${{mysql.MYSQLDATABASE}}` (WordPress database name).
  - **Volumes**:
    - `wordpress-data`: Mounts at `/var/www/html` to persist WordPress files (themes, plugins, uploads).
    - `php-ini`: Mounts a custom `php.ini` at `/usr/local/etc/php/conf.d/custom.ini` to set:
      - `upload_max_filesize = 256M`: Allows uploads up to 256MB.
      - `post_max_size = 256M`: Supports large POST requests.
      - `memory_limit = 512M`: Allocates sufficient memory for PHP processing.
      - `max_execution_time = 300`: Prevents timeouts during large uploads.
      - `max_input_time = 300`: Allows sufficient time for input processing.
  - **Health Check**: Verifies WordPress is accessible by checking `/wp-admin/install.php`.
- **Why It Matters**: The custom `php.ini` ensures WordPress can handle large media files, themes, or plugins, ideal for media-heavy sites.

### 2. MySQL Service
- **Image**: `mysql:8.0` (official MySQL Docker image).
- **Purpose**: Provides the database backend for WordPress.
- **Configuration**:
  - **Environment Variables**:
    - `MYSQL_ROOT_PASSWORD`: A random 32-character string (`${{random(32)}}`) for security.
    - `MYSQL_DATABASE`: Set to `wordpress` for the WordPress database.
    - `MYSQL_USER`: Set to `wordpress_user` for WordPress access.
    - `MYSQL_PASSWORD`: A random 32-character string for the WordPress user.
  - **Volume**:
    - `mysql-data`: Mounts at `/var/lib/mysql` to persist database data.
  - **Health Check**: Runs `mysqladmin ping` to ensure the MySQL server is operational.
- **Why It Matters**: Provides a secure and persistent database for WordPress with randomized credentials.

### 3. phpMyAdmin Service
- **Image**: `phpmyadmin:latest` (official phpMyAdmin Docker image).
- **Purpose**: Offers a web interface to manage the MySQL database.
- **Configuration**:
  - **Port**: Exposes port 80 for public access.
  - **Environment Variables**:
    - `PMA_HOST`: Set to `${{mysql.MYSQLHOST}}` (MySQL's private network hostname).
    - `PMA_USER`: Set to `${{mysql.MYSQLUSER}}` (MySQL user for WordPress).
    - `PMA_PASSWORD`: Set to `${{mysql.MYSQLPASSWORD}}` (MySQL password).
    - `UPLOAD_LIMIT`: Set to `256M` to allow large SQL file imports.
  - **Health Check**: Verifies phpMyAdmin is accessible by checking `/index.php`.
- **Why It Matters**: Enables easy database management with a high upload limit for large SQL imports.

### 4. Variables
- **Purpose**: Centralize shared configuration for service interoperability.
- **Definitions**:
  - `mysql.MYSQLHOST`: Set to `${{mysql.RAILWAY_PRIVATE_DOMAIN}}` for private networking.
  - `mysql.MYSQLUSER`: Set to `wordpress_user`.
  - `mysql.MYSQLPASSWORD`: References the MySQL service's `MYSQL_PASSWORD`.
  - `mysql.MYSQLDATABASE`: Set to `wordpress`.
- **Why It Matters**: Ensures secure and dynamic connectivity between services without hardcoding sensitive values.

## Template JSON
Below is the `railway.json` file that defines the template. Save it for CLI deployment or paste it into the Railway dashboard.
