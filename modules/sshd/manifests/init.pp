define sshd::sshd($package_list = [ 'openssh-server' ]) {

  package { $package_list:
    ensure => installed,
  }

  service { $title:
    ensure => running,
    require => Package[$package_list],
  }

  file { '/etc/ssh/sshd_config':
    content => template('sshd/sshd_config.erb'),
    notify => Service[$title],
  }

}
























