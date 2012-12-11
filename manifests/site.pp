
# The following declaration affects the default behavior of any
# instance of 'exec'. Therefore, unless explicitly configured
# otherwise, any use of 'exec' will be verbose (logoutput is set
# to true).
Exec {
  logoutput => true,
}

# Begin stage declaration
stage { 'user-setup-stage': before => Stage['main'] }

class { 'setup_users':
  stage => 'user-setup-stage',
}

# The following class regroup of the resources that will
# be associated to the stage 'setup_users':
class setup_users {

  $members=['tiffany','kate','anna']
  user { $members:
    ensure => present,
  }

}
# Begin stage declaration

# The 'default' node is used for any node not explicitly declare. This
# manifest has no nodes declaration because it uses available facts to
# categorize the node and determine what needs to be done.
node default {

  case $operatingsystem {
      'AIX':  {
        $package_list=[ 'openssh.base.server' ]
        $sudoers_file='aix.sudoers'
        $sudoers_file_group='system'
       }
      'RedHat': {
        $package_list=[ 'openssh-server' ]
        $sudoers_file='linux.sudoers'
        $sudoers_file_group='root'
      }
      default:  {}
    }

    notice("Puppet agent on $operatingsystem")

    sshd::sshd { 'sshd':
       package_list => $package_list,
    }

    sudoers::sudoers { 'sudoers':
      sudoers_file => $sudoers_file,
      sudoers_file_group =>  $sudoers_file_group,
      sudoers_list => ['rpelisse','god','bob'],

    }

    # This is an example of a Puppet extension, see
    # module 'purpose' for more details.
    purpose { 'sanity-check': }

#   TODO: Fix !
#    $members=['tiffany','kate']
#    group { 'girl':
#      ensure => present,
#      members => $members,
#      require => User[$members],
#    }
}

