# Linux Web Container with nginx and PHP

This container containes a basic set up for a web application. It has been specifically designed for Laravel applications, but can be used for all kinds of web applications running on PHP.

## Packages

The following packages are present in this container, which has been based 
on Alpine.

 - nginx
 - PHP 8.3
 - PHP extensions: `pdo_mysql` `exif` `pcntl` `bcmath` `redis` `soap` `gd` `opcache`
 - Additional packages: `wget` `openssh-client` `git` `zip` `curl`
