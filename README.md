# WordPress Complete Stack - Railway Template

A comprehensive, production-ready WordPress deployment template for Railway that includes everything you need to run a high-performance WordPress website with database management and caching capabilities.

## 🚀 What This Template Includes

This template deploys a complete WordPress stack with the following services:

### Core Services

- **WordPress 6+ with PHP 8.2**: Latest WordPress installation running on Apache with PHP 8.2 for optimal performance and security
- **MySQL 8.0**: Robust relational database for WordPress data storage with persistent volumes
- **phpMyAdmin**: Web-based MySQL administration interface for easy database management
- **Redis 7**: High-performance in-memory caching system for WordPress acceleration

### Key Features

- **Large File Upload Support**: Configured to handle files up to 256MB
- **Persistent Storage**: Data volumes ensure your content and database survive deployments
- **Auto-Generated Security**: Secure passwords automatically generated for all services
- **Private Networking**: Services communicate securely through Railway's private network
- **Health Monitoring**: Built-in health checks for all services
- **Production Optimized**: Memory limits, execution times, and caching pre-configured

## 📋 Technical Specifications

| Service | Image | Purpose | Port | Storage |
|---------|-------|---------|------|---------|
| WordPress | `wordpress:6-php8.2-apache` | Main website | 80 | Shared volume |
| MySQL | `mysql:8.0` | Database | 3306 | Persistent volume |
| phpMyAdmin | `phpmyadmin:5-apache` | DB Management | 80 | None |
| Redis | `redis:7-alpine` | Caching | 6379 | Persistent volume |

### Upload & Performance Limits

- **Max File Upload**: 256MB
- **Max POST Size**: 256MB
- **Max Execution Time**: 300 seconds
- **Memory Limit**: 512MB
- **Redis Max Memory**: 256MB

## 🛠️ How to Deploy on Railway

### Method 1: One-Click Deploy (Recommended)

1. **Create the Template File**
   - Create a new GitHub repository
   - Add the `railway.json` template file to the repository root
   - Commit and push to GitHub

2. **Deploy via Railway**
   - Go to [Railway.app](https://railway.app)
   - Click "New Project"
   - Select "Deploy from GitHub repo"
   - Choose your repository with the `railway.json` file
   - Railway will automatically detect and deploy all services

3. **Wait for Deployment**
   - All services will deploy simultaneously
   - Check the deployment logs for any issues
   - Each service will receive its own domain

### Method 2: Manual Service Creation

1. **Create New Project**
   - Log into Railway
   - Click "New Project" → "Empty Project"

2. **Add Each Service**
   - Add WordPress service: "New Service" → "Docker Image" → `wordpress:6-php8.2-apache`
   - Add MySQL service: "New Service" → "Docker Image" → `mysql:8.0`
   - Add phpMyAdmin service: "New Service" → "Docker Image" → `phpmyadmin:5-apache`
   - Add Redis service: "New Service" → "Docker Image" → `redis:7-alpine`

3. **Configure Environment Variables**
   - Copy the variables from the template for each service
   - Set up service connections using Railway's private domains

## ⚙️ Post-Deployment Configuration

### 1. Access Your Services

After deployment, you'll receive unique URLs for:

- **WordPress Site**: `https://your-wordpress-domain.railway.app`
- **phpMyAdmin**: `https://your-phpmyadmin-domain.railway.app`

### 2. Complete WordPress Setup

1. Visit your WordPress URL
2. Select your language
3. Complete the famous 5-minute WordPress installation:
   - Site Title
   - Admin Username
   - Admin Password
   - Admin Email

### 3. Enable Redis Caching (Optional but Recommended)

1. **Install Redis Plugin**
   - Go to WordPress Admin → Plugins → Add New
   - Search for "Redis Object Cache"
   - Install and activate the plugin

2. **Configure Redis**
   - Go to Settings → Redis
   - Click "Enable Object Cache"
   - The plugin will automatically connect to your Redis service

### 4. Database Management

- **Access phpMyAdmin**: Use the generated phpMyAdmin URL
- **Login Credentials**:
  - Username: `wordpress` or `root`
  - Password: Check Railway environment variables

## 🔒 Security Notes

- All passwords are auto-generated and stored securely in Railway
- Services communicate via private network (not exposed to internet)
- Only WordPress and phpMyAdmin have public domains
- MySQL and Redis are only accessible internally

## 📈 Performance Optimization

This template is pre-configured for optimal performance:

- **Redis Caching**: Reduces database queries
- **Increased Memory Limits**: Handles resource-intensive operations
- **Extended Execution Times**: Supports large file operations
- **Optimized MySQL Settings**: UTF8MB4 charset for full Unicode support

## 🔧 Customization

You can modify the `railway.json` template to:

- Change upload limits by adjusting `upload_max_filesize` and `post_max_size`
- Modify memory limits in the WordPress configuration
- Add additional environment variables
- Include custom Docker images or build steps

## 📝 Environment Variables

The template automatically generates:

- `MYSQL_ROOT_PASSWORD`: MySQL root password
- `MYSQL_PASSWORD`: WordPress database user password  
- `REDIS_PASSWORD`: Redis authentication password

## 🆘 Troubleshooting

### Common Issues

1. **Services Won't Start**: Check Railway logs for each service
2. **WordPress Can't Connect to Database**: Verify MySQL service is running
3. **Large Files Won't Upload**: Check PHP memory and execution time limits
4. **Redis Not Working**: Ensure Redis Object Cache plugin is installed

### Getting Help

- Check Railway service logs for error messages
- Verify all environment variables are set correctly
- Ensure services are using private network connections

## 💡 Next Steps

After deployment, consider:

- Installing essential WordPress plugins (security, SEO, backup)
- Setting up automated backups for your database
- Configuring a CDN for static assets
- Setting up SSL certificates (Railway provides these automatically)
- Monitoring performance and scaling resources as needed

---

**Note**: This template provides a complete production-ready WordPress stack. All services are configured to work together seamlessly with optimal security and performance settings.
