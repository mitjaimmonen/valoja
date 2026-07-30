# ---------- Build Flutter web app ----------
FROM dart:stable AS build-website
WORKDIR /website

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl git unzip xz-utils ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && dart pub global activate fvm
ENV PATH="$PATH:/root/.pub-cache/bin"

COPY .fvmrc ./
RUN fvm install

COPY pubspec.* ./
RUN fvm flutter pub get

COPY . .
RUN fvm flutter build web --release

# ---------- Production image ----------
FROM node:24-alpine
WORKDIR /app

# Set NODE_ENV globally
ENV NODE_ENV=production

RUN npm install -g serve

# Set non-root "app" user
RUN addgroup -S app && adduser -S app -G app
USER app

# Copy built website into public folder
COPY --from=build-website /website/build/web ./public

EXPOSE 3000
CMD ["serve", "-s", "public", "-l", "3000"]