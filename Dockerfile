# Use the latest official WordPress image
FROM wordpress:latest

# Copy in custom PHP config to override defaults
COPY php.ini /usr/local/etc/php/conf.d/custom.ini

