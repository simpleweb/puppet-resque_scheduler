class resque_scheduler::install {

  package { 'resque':
    ensure => installed,
    provider => 'gem',
    require => Class['redis'],
  }

  package { 'resque-scheduler':
    ensure => installed,
    provider => 'gem',
  }

}
