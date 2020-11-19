setup:
	cp .env.example .env
	composer install
	php artisan key:generate
	php artisan migrate:refresh --seed
	rm -rf node_modules
	yarn -i
	
start:
	yarn run dev
	php artisan serve