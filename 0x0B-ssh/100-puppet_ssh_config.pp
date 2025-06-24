# Configure SSH client to use private key and disable password auth
file { '/etc/ssh/ssh_config':
  ensure => file,
}

file_line { 'Declare identity file':
  path   => '/etc/ssh/ssh_config',
  line   => '    IdentityFile ~/.ssh/school',
  match  => '^ *IdentityFile',
  after  => '^Host \*',
}

file_line { 'Turn off passwd auth':
  path   => '/etc/ssh/ssh_config',
  line   => '    PasswordAuthentication no',
  match  => '^ *PasswordAuthentication',
  after  => '^Host \*',
}
file_line { 'Turn off challenge response auth':
  path   => '/etc/ssh/ssh_config',
  line   => '    ChallengeResponseAuthentication no',
  match  => '^ *ChallengeResponseAuthentication',
  after  => '^Host \*',
}