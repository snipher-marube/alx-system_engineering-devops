# Puppet manifest to configure Nginx with X-Served-By header
class nginx_custom_header {
  # Install Nginx package if not present
  package { 'nginx':
    ensure => 'installed',
  }

  # Configure Nginx with custom header
  file { '/etc/nginx/conf.d/custom_header.conf':
    ensure  => 'present',
    content => "add_header X-Served-By \$hostname;",
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

# Apply the configuration
include nginx_custom_header