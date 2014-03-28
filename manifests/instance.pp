# Define: resque_scheduler::instance
#
# Create a resque-scheduler service
#
# Parameters:
#
# [*pidfile*] - path to the pidfile
# [*user*] - user to run the process as
# [*group*] - group to run the process as
# [*app_root*] - path to the rack application, should contain a config.ru file
# [*bin_path*] - path to the resque-scheduler binary (resque-scheduler)
# [*bundler_executable*] - path to the bundler binary (bundle)
# [*rack_env*] - rack environment (production)
# [*log_path*] - path to the stderr log ($app_root/log/resque_scheduler_${name}.stderr.log)
#
# Usage example:
#
#   $rack_root = "/home/acme/rack-app"
#
#   resque_scheduler::instance { "acme":
#     app_root => $rack_root,
#     pidfile => "$rack_root/tmp/pids/resque-scheduler.pid",
#     user => "acme",
#     group => "acme",
#   }
#
# Commands available from example above:
#
#   $ service resque_scheduler_acme
#   Usage: /etc/init.d/resque_scheduler_acme {start|stop|restart|status}
#
define resque_scheduler::instance (
  $pidfile,
  $user,
  $group,
  $app_root,
  $bundler_executable = 'bundle',
  $rack_env = 'production',
  $log_path = undef,
) {

  if $log_path {
    $_log_path = $log_path
  } else {
    $_log_path = "${app_root}/log/resque_scheduler_${name}.log"
  }

  $daemon      = $bundler_executable
  $daemon_opts = "exec rake resque:scheduler"

  service { "resque_scheduler_${name}":
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    start      => "/etc/init.d/resque_scheduler_${name} start",
    stop       => "/etc/init.d/resque_scheduler_${name} stop",
    restart    => "/etc/init.d/resque_scheduler_${name} restart",
    require    => [
      File["/etc/init.d/resque_scheduler_${name}"],
      File["/etc/default/resque_scheduler_${name}"],
    ],
  }

  file { "/etc/default/resque_scheduler_${name}":
    owner   => root,
    group   => root,
    mode    => 644,
    content => template("resque_scheduler/default.erb"),
    notify  => Service["resque_scheduler_${name}"];
  }

  file { "/etc/init.d/resque_scheduler_${name}":
    owner   => root,
    group   => root,
    mode    => 755,
    content => template("resque_scheduler/init.erb"),
    notify  => Service["resque_scheduler_${name}"];
  }
}
