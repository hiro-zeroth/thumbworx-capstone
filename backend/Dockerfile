# ============================================================
# Stage 1: Builder (PHP + Node + Vite)
# ============================================================
FROM php:8.2-fpm-alpine AS builder

RUN apk add --no-cache \
    git curl zip unzip npm mysql-client \
    && docker-php-ext-install pdo pdo_mysql opcache

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app
COPY . .

RUN cp .env.example .env || true

RUN composer install \
    --no-dev \
    --no-interaction \
    --optimize-autoloader

RUN php artisan key:generate || true
RUN php artisan package:discover --ansi

RUN npm install --legacy-peer-deps
RUN SKIP_WAYFINDER_GENERATION=1 npm run build

RUN mkdir -p storage/framework/sessions storage/framework/views storage/framework/cache storage/logs \
    && chmod -R 775 storage bootstrap/cache public

# ============================================================
# Stage 2: Runtime (PHP-FPM only)
# ============================================================
FROM php:8.2-fpm-alpine

RUN apk add --no-cache \
    curl zip unzip mysql-client \
    && docker-php-ext-install pdo pdo_mysql opcache

WORKDIR /app

COPY --from=builder --chown=www-data:www-data /app /app

RUN mkdir -p storage/framework/sessions storage/framework/views storage/framework/cache storage/logs \
    && chmod -R 775 storage bootstrap/cache public

EXPOSE 9000

CMD ["php-fpm"]
