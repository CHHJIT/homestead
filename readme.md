<p align="center"><img src="https://laravel.com/assets/img/components/logo-homestead.svg"></p>

<p align="center">
<a href="https://travis-ci.org/laravel/homestead"><img src="https://travis-ci.org/laravel/homestead.svg" alt="Build Status"></a>
<a href="https://packagist.org/packages/laravel/homestead"><img src="https://poser.pugx.org/laravel/homestead/d/total.svg" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/laravel/homestead"><img src="https://poser.pugx.org/laravel/homestead/v/stable.svg" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/laravel/homestead"><img src="https://poser.pugx.org/laravel/homestead/license.svg" alt="License"></a>
</p>

# Introduction

Laravel Homestead is an official, pre-packaged Vagrant box that provides you a wonderful development environment without requiring you to install PHP, a web server, and any other server software on your local machine. No more worrying about messing up your operating system! Vagrant boxes are completely disposable. If something goes wrong, you can destroy and re-create the box in minutes!

Homestead runs on any Windows, Mac, or Linux system, and includes the Nginx web server, PHP 7.4, MySQL, Postgres, Redis, Memcached, Node, and all of the other goodies you need to develop amazing Laravel applications.

Official documentation [is located here](https://laravel.com/docs/homestead).

# Installation Instructions:

## Prerequisites: (PLEASE DOUBLE-CHECK EACH OF THESE)

These applications should be installed and available in your terminal's $PATH

- [NPM](https://www.npmjs.com/) - `brew install node`
- [Yarn](https://yarnpkg.com/) - `brew install yarn`
- [Composer](https://getcomposer.org/) - `brew install composer`
- [Vagrant](https://www.vagrantup.com/) - `brew cask install vagrant` ([Vagrant Manager](http://vagrantmanager.com/) is also nice to have but is optional - `brew cask install vagrant-manager`)
- [VirtualBox](https://www.virtualbox.org/) - `brew cask install virtualbox`

Also make sure that...

- You have the HunkWare API and the HunkWare Frontend cloned locally somewhere (You will need the absolute paths to them later)
- You have at least 1 existing ssh key pair (If not you will need to generate it) - [Click here for how to create SSH key](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- You have run `composer install` for both the API and Frontend repos
- After you install NPM, Yarn, Composer, Vagrant, VirtualBox you restart any open terminal windows so they will be able to use the new commands.
- You have at least testing-environment database credentials.

## Step 1: Install Vagrant Host Updater

This will make it so you don't need to manually update your `/etc/hosts` file every time you update your `Homestead.yaml` file.

NOTE: This is a global plugin so this command will only ever need to be run once for your machine.

```bash
vagrant plugin install vagrant-hostsupdater
```



## Step 2: Create the initial VM 

This command will automatically download and deploy the correct VM image.

**WARNING:** Make sure you select "virtualbox" if prompted which application you would like to use for creating the VM.

```bash
vagrant box add laravel/homestead --provider virtualbox
```



## Step 3: Clone the CHHJ Homestead Repo

It is recommend to keep this repo wherever you keep your other CHHJ repos.

```bash
git clone https://github.com/CHHJIT/homestead.git
cd homestead
```



## Step 4: Initialize The Repo

**NOTICE:** The rest of these steps assume you are in the homestead repo root directory. You may experience issues if you are not cd'd there. 

**Mac &amp; Linux:**
```bash
bash init.sh
```

**Windows:**
```dos
init.bat
```



## Step 5: Configure Homestead

Open the `Homestead.yaml` file and customize the "settings" section to your machine. It should look something like this:

**NOTICE:** Please do not add any trailing slashes to any of the paths in your `Homestead.yaml` file, as they may cause issues. 

![Settings Example](https://i.imgur.com/veCiOCy.png) 

**WARNING:** After you have run `vagrant up` (the next step) every time you update this `Homestead.yaml` file you will need to run `vagrant reload --provision` for your changes to be applied.



## Step 6: First VM Deploy

This will start the VM.

**WARNING:** The first time you run this command after a VM has been created it WILL provision the VM with the settings from your `Homestead.yaml` file. HOWEVER, it WILL NOT provision it after the first time. You must run `vagrant reload --provision` to re-provision any VM.

```bash
vagrant up
```



## Step 7: Trust The Root CA Certificate 

This will allow you to use SSL/HTTPS when making requests.

**NOTICE:** See this page if you have any issues: https://www.eaglepeakweb.com/blog/how-to-enable-ssl-https-tls-laravel-homestead

**Step 7a: Copy &amp; Open The Root CA Certificate**

```bash
vagrant ssh -c "sudo cat /etc/nginx/ssl/ca.homestead.homestead.crt" > ./certs/ca.homestead.crt && open ./certs/ca.homestead.crt
```

**Step 7b: Add The Certificate To Your Machine**

![7b](https://i.imgur.com/MNlyNz1.png)

**Step 7c: Find &amp; Open The Root CA Certificate**

Should be named "Homestead homestead Root CA" or similar.

![7c](https://i.imgur.com/kSwS7Q2.png)

**Step 7d: Open the "Trust" Section**

![7d](https://i.imgur.com/pvPdI4U.png)

**Step 7e: Set Everything To "Always Trust"**

![7e](https://i.imgur.com/f1OFT75.png)

**Step 7f: Exit Keychain Access (optional)**

You can now close all of the windows for "Keychain Access"

**Step 7g: Close any open Chrome windows**

Sometimes Google Chrome can have issues with new certificates, so it is best at this point to just close and reopen any open Chrome windows.



## Step 8: Test Your New Environment!

Going to both of these addresses in you browser should reveal any issues or show that you have done everything correctly:

- API: (will be JSON) https://hunkware-api.test/v1/info
- Frontend: (make sure to login) https://hunkware-frontend.test/hunkware-frontend/dashboard-operations
