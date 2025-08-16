# WordPress on Railway with Managed MySQL + phpMyAdmin

This repo deploys **WordPress** on Railway, connected to **Railway’s Managed MySQL Plugin**, with optional **phpMyAdmin** for database management.

---

## 🚀 Setup Steps

### 1. Add Managed MySQL
1. In your Railway project → click **New → Add Plugin → MySQL**.
2. Railway will generate env vars:
   
MYSQLHOST=containers-us-west-xxx.railway.app
MYSQLPORT=xxxxx
MYSQLUSER=xxxxx
MYSQLPASSWORD=xxxxx
MYSQLDATABASE=railway

### 2. Deploy WordPress
1. Deploy this repo as a **new Railway service** (call it `wordpress`).
2. Add the following environment variables (map them from the plugin):

WORDPRESS_DB_HOST=${MYSQLHOST}:${MYSQLPORT}
WORDPRESS_DB_USER=${MYSQLUSER}
WORDPRESS_DB_PASSWORD=${MYSQLPASSWORD}
WORDPRESS_DB_NAME=${MYSQLDATABASE}

3. Railway will build the custom Dockerfile and launch WordPress with higher upload limits.
4. Visit the service URL → you’ll see the WordPress install screen 🎉

---

### 3. Deploy phpMyAdmin (optional)
1. Add a new Railway service with the image:
   ~phpmyadmin/phpmyadmin:latest
2. Add environment variables (map them from the same MySQL plugin):
PMA_HOST=${MYSQLHOST}
PMA_PORT=${MYSQLPORT}
PMA_USER=${MYSQLUSER}
PMA_PASSWORD=${MYSQLPASSWORD}

3. Expose port `80`. Railway will give you a public URL for phpMyAdmin.

---

### 4. Done!
- WordPress → Your Railway URL  
- phpMyAdmin → Another Railway URL  
- Both connect to the same **Managed MySQL database** 🚀
