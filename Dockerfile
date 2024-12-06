# Étape 1 : Utiliser une image Ruby de base
FROM ruby:3.2

# Étape 2 : Installer les dépendances nécessaires
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    yarn

# Étape 3 : Configurer le répertoire de travail
WORKDIR /app

# Étape 4 : Copier les fichiers nécessaires
COPY Gemfile Gemfile.lock ./

# Étape 5 : Installer les gems
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Étape 6 : Copier le reste de l'application
COPY . .

# Étape 7 : Exposer le port pour l'application
EXPOSE 3000

# Étape 8 : Définir la commande de démarrage
CMD ["rails", "server", "-b", "0.0.0.0"]
