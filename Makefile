init:
	docker-compose up -d

setup:
	docker exec -it bizcard make app-setup
	docker exec -it bizcard chmod -R 777 storage bootstrap/cache

start:
	docker exec -it bizcard make app-start

app-setup:
	cp .env.example .env
	composer update --ignore-platform-reqs
	php artisan key:generate
	php artisan migrate:refresh --seed
	rm -rf node_modules
	yarn -i

app-start:
	yarn run dev --watch
	php artisan serve