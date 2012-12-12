define sudoers::sudoers($sudoers_file='linux.sudoers', $sudoers_list, $sudoers_file_group='root') {

  file { '/etc/sudoers':
    owner => root,
    group => $sudoers_file_group,
    mode => 440,
    content => template("sudoers/$sudoers_file.erb"),
  }
}


