# Enable the site configuration
sudo a2ensite curl-local.conf

# Disable default site (optional, if conflicting on port 80)
sudo a2dissite 000-default.conf

# Verify configuration syntax
sudo apache2ctl configtest

# Restart Apache to apply changes
sudo systemctl restart apache2
