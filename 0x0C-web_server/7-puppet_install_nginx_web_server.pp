# Puppet manifest to install and configure Nginx with 301 redirect
class nginx_setup {
  # Install Nginx package
  package { 'nginx':
    ensure => 'installed',
  }

  # Create Hello World index page
  file { '/var/www/html/index.html':
    ensure  => 'present',
    content => 'Hello World!',
    mode    => '0644',
    require => Package['nginx'],
  }

  # Configure Nginx server
  file { '/etc/nginx/sites-available/default':
    ensure  => 'present',
    content => template('nginx_setup/nginx.conf.erb'),
    notify  => Service['nginx'],
    require => Package['nginx'],
  }

  # Ensure Nginx service is running
  service { 'nginx':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    require    => Package['nginx'],
  }
}

# Define the Nginx configuration template
file { '/etc/puppet/templates/nginx_setup/nginx.conf.erb':
  ensure => 'directory',
}

file { '/etc/puppet/templates/nginx_setup/nginx.conf.erb':
  ensure  => 'present',
  content => @(END),
    server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;
        index index.html index.htm;

        server_name _;

        location / {
            try_files $uri $uri/ =404;
        }

        location = /redirect_me {
            return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
        }
    }
    | END,
}

# Apply the configuration
include nginx_setup