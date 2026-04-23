FROM ghcr.io/cirruslabs/flutter:stable AS build

ENV FLUTTER_ALLOW_ROOT=true

WORKDIR /app

COPY pubspec.yaml pubspec.lock* ./
RUN flutter pub get

COPY . .

RUN flutter build web --release

FROM nginx:alpine AS runtime

COPY --from=build /app/build/web /usr/share/nginx/html
COPY docker/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENV API_BASE_URL=https://app.project-deploy.shop/api

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
