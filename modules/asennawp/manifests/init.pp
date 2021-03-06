class asennawp {
	
	#asennetaan paketit
	$paketit = ['apache2', 'php7.0','ssh','php-gd', 'php-ssh2','php7.0-phpdbg','rsync','php7.0-mysql','php-curl', 'php-mbstring', 'php-mcrypt', 'php-xml', 'php-xmlrpc' ]
	
	package { $paketit: 
		ensure=> 'installed',
		allowcdrom => 'true', 
	}

	package { 'libapache2-mod-php7.0':
		ensure => 'installed',
		require => Package[ 'apache2'],
		allowcdrom => "true",
	}
	
	#luodaan site.pp
	file { '/etc/puppet/manifests/site.pp':
		content => template ('asennawp/site.pp.erb'),
	}
	
	#Apache sopivampi asentaa ilman puppetabsin moduli
#	exec { puppetmodule-apache2:
#		command => 'sudo puppet module install puppetlabs-apache',
#		path => '/bin:/usr/bin:/sbin:/usr/sbin:',
#		creates => '/etc/puppet/modules/apache', 
#	}

	#Mysqln asennus puppetlabsin moduulilla. Toimiva ratkaisu.
	exec { puppetmodule-mysql: 
		command => "sudo puppet module install puppetlabs-mysql",
		path => "/bin:/usr/bin:/sbin:/usr/sbin:",
		creates => "/etc/puppet/modules/mysql", 
	}
	
	#Pidetään Apache käynnissä
	 service { 'apache2':
    		ensure => 'true',
		enable => 'true',
		require => Package['apache2'],
	}

	#ladataan viimeisin wordpress, puretaan se /var/www/html-kansioon
	exec { lataawp:
                command => "sudo wget -P /etc/puppet/modules/asennawp/manifests http://wordpress.org/latest.tar.gz",
                path => "/bin:/usr/bin:/sbin:/usr/sbin:",
                creates => "/etc/puppet/modules/asennawp/manifests/latest.tar.gz",
	}

	exec { purawp:
                command => "sudo tar xzvf /etc/puppet/modules/asennawp/manifests/latest.tar.gz -C /etc/puppet/modules/asennawp/manifests ",
                path => "/bin:/usr/bin:/sbin:/usr/sbin:",
		creates => "/etc/puppet/modules/asennawp/manifests/wordpress",
	}

	exec { siirrawp:
                command => "sudo rsync -avP /etc/puppet/modules/asennawp/manifests/wordpress/ /var/www/html/",
                path => '/bin:/usr/bin:/sbin:/usr/sbin:',
		creates => '/var/www/html/wp-config.php',
		require => 'File[/etc/puppet/modules/asennawp/manifests/wordpress/wp-config.php]',
	}

	#luodaan uploads kansion
	file { ['/var/www/html/wp-content', '/var/www/html/wp-content/uploads']:
		ensure => 'directory',
	}

	#konfiguraatiotiedostojen luonti
	file { '/etc/puppet/modules/asennawp/manifests/wordpress/wp-config.php':
		content => template ('asennawp/wp-config.php.erb'),
		require => Exec ['purawp'],
	}

	file { '/etc/apache2/mods-available/php7.0.conf':
		notify => Service['apache2'],
		content => template ('asennawp/php7.0.conf.erb'),
		require => Package['libapache2-mod-php7.0'],
	}
	
        file { '/etc/apache2/apache2.conf':
		notify => Service['apache2'],
                content => template ('asennawp/apache2.conf.erb'),
		require => Package['apache2'],
        }

	#poistetaan apachen oletussivu
	file { '/var/www/html/index.html':
		ensure => 'absent',
		require => Package['apache2'],
	}	
	
	#livetikun mysql ongelmat
	file {'/etc/puppet/modules/mysql/manifests/client/install.pp':
		content => template ('asennawp/mysqlclientinstall.pp.erb'),
	}

	file {'/etc/puppet/modules/mysql/manifests/server/install.pp':
		content => template ('asennawp/mysqlserverinstall.pp.erb'),
	}	

}
