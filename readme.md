<p align="center"><img src="https://laravel.com/assets/img/components/logo-homestead.svg"></p>

<p align="center">
<a href="https://travis-ci.org/laravel/homestead"><img src="https://travis-ci.org/laravel/homestead.svg" alt="Build Status"></a>
<a href="https://packagist.org/packages/laravel/homestead"><img src="https://poser.pugx.org/laravel/homestead/d/total.svg" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/laravel/homestead"><img src="https://poser.pugx.org/laravel/homestead/v/stable.svg" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/laravel/homestead"><img src="https://poser.pugx.org/laravel/homestead/license.svg" alt="License"></a>
</p>

## Introduction

Laravel Homestead is an official, pre-packaged Vagrant box that provides you a wonderful development environment without requiring you to install PHP, a web server, and any other server software on your local machine. No more worrying about messing up your operating system! Vagrant boxes are completely disposable. If something goes wrong, you can destroy and re-create the box in minutes!

Homestead runs on any Windows, Mac, or Linux system, and includes the Nginx web server, PHP 7.4, MySQL, Postgres, Redis, Memcached, Node, and all of the other goodies you need to develop amazing Laravel applications.

Official documentation [is located here](https://laravel.com/docs/homestead).

## Installation Instructions:

### Prerequisites:

These applications should be installed and available in your terminal's $PATH

- NPM &amp; Yarn
- Vagrant
- Virtual Box

### Steps:

1. Run `vagrant plugin install vagrant-hostsupdater` (If the plugin is not already installed)
1. Run `vagrant box add laravel/homestead`
2. Run `git clone https://github.com/CHHJIT/homestead.git` (It is recommend to keep this wherever you keep your other CHHJ repos)
3. Run `cd homestead`
4. Run `bash init.sh` (or `init.bat` on windows)
5. Configure the `Homestead.yaml` file
6. Run `vagrant up`
7. Run `vagrant ssh -c "sudo cat /etc/nginx/ssl/ca.homestead.homestead.crt" > ./certs/ca.homestead.crt`
8. Go to the `/certs` directory and double click the `ca.homestead.crt` file to add it to your machine. **MAKE SURE** that the certificate is listed as a trusted certificate. (By default is not trusted)
9. Check https://hunkware-frontend.test/hunkware-frontend/dashboard-operations
10. Check https://hunkware-api.test/v1/info

