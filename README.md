# puppet-resque_scheduler

Puppet module for creating and managing resque-scheduler services

### Install

To install as a git submodule, run:

    $ git submodule add git@github.com:simpleweb/puppet-resque_scheduler.git modules/resque_scheduler

### Usage

Use this module to:

* Ensure the `resque-scheduler` gem is installed
* Create `resque-scheduler` service instances

Install gem

```puppet
include resque_scheduler::install
```

Create a service

```puppet
  $rack_root = "/home/acme/rack-app"

  resque_scheduler::instance { "acme":
    app_root => $rack_root,
    config_file => "$rack_root/config/resque-scheduler.yml",
    pidfile => "$rack_root/tmp/pids/resque-scheduler.pid",
    user => "acme",
    group => "acme",
  }
```

Commands available from example above:

```sh
  $ service resque_scheduler_acme
  Usage: /etc/init.d/resque_scheduler_acme {start|stop|restart|status}
```

### Configuration

Available parameters (with defaults)

```
[*pidfile*] - path to the pidfile
[*user*] - user to run the process as
[*group*] - group to run the process as
[*app_root*] - path to the rack application, should contain a config.ru file
[*bundler_executable*] - path to bundle (bundle)
[*bin_path*] - path to the resque-scheduler binary (resque-scheduler)
[*rack_env*] - rack environment (production)
[*log_path*] - path to log to ($app_root/log/resque_scheduler_${name}.log)
```

