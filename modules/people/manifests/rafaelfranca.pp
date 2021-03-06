class people::rafaelfranca {
  $home = "/Users/${::boxen_user}"

  # Mac OSX Defaults
  osx::recovery_message { 'Se este Mac foi encontrado por favor ligue para 011 96062-0948': }

  class { 'osx::global::key_repeat_delay':
    delay => 25
  }

  class { 'osx::global::key_repeat_rate':
    rate => 2
  }

  repository { "rafaelfranca dotfiles":
    source => 'rafaelfranca/dotfiles',
    path => "${home}/.dotfiles"
  }

  exec { "install rafaelfranca dotfiles":
    command => "${home}/.dotfiles/install.sh",
    unless => "test -L ${home}/.bash_profile",
    require => Repository["rafaelfranca dotfiles"]
  }

  git::config::global {
    'push.default':
      value => 'current';
  }

  nodejs::version { 'iojs-3.0.0': }

  npm_module { 'react-native-cli for all nodes':
    module       => 'react-native-cli',
    node_version => '*',
  }

  include python::virtualenvwrapper

  python::mkvirtualenv{ 'hightfive':
    project_dir => "${::boxen_srcdir}/rails/rails-bot"
  }
}
