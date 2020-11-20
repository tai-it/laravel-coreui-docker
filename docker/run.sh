#!/bin/bash
rm -rf /var/run/apache2/
php artisan serve --host=0.0.0.0 --port=80
apache2ctl -D FOREGROUND