class resque_scheduler::install {

  if !defined(Package['resque']) {
    package { 'resque':
      ensure => installed,
      provider => 'gem',
      require => Class['redis'],
    }
  }

  package { 'resque-scheduler':
    ensure => installed,
    provider => 'gem',
    require => Package['resque'],
  }

}
