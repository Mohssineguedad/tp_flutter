FROM ubuntu:22.04

# Éviter les prompts interactifs
ENV DEBIAN_FRONTEND=noninteractive

# Installer les dépendances système
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    openjdk-11-jdk \
    wget \
    chromium-browser \
    && rm -rf /var/lib/apt/lists/*

# Configuration pour Chrome
ENV CHROME_EXECUTABLE=/usr/bin/chromium-browser

# Définir les variables d'environnement pour Flutter
ENV FLUTTER_HOME=/opt/flutter
ENV PATH="$FLUTTER_HOME/bin:$PATH"
ENV PUB_CACHE=/root/.pub-cache
ENV PATH="$PUB_CACHE/bin:$PATH"

# Télécharger et installer Flutter
RUN git clone https://github.com/flutter/flutter.git -b stable $FLUTTER_HOME

# Pré-télécharger les dépendances Flutter
RUN flutter precache
RUN flutter doctor

# Installer FlutterFire CLI
RUN dart pub global activate flutterfire_cli

# Créer un répertoire de travail
WORKDIR /app

# Accepter les licences Android
RUN yes | flutter doctor --android-licenses || true

CMD ["/bin/bash"]
 