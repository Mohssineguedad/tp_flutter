FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Installer dépendances système
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
    cmake \
    clang \
    ninja-build \
    build-essential \
    pkg-config \
    libgtk-3-dev \
    && rm -rf /var/lib/apt/lists/*

# Installer Node.js + npm (obligatoire Firebase CLI)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Vérification
RUN node -v && npm -v

# Flutter
ENV FLUTTER_HOME=/opt/flutter
ENV PATH="$FLUTTER_HOME/bin:$PATH"

RUN git clone https://github.com/flutter/flutter.git -b stable $FLUTTER_HOME

RUN flutter precache
RUN flutter doctor

WORKDIR /app

RUN yes | flutter doctor --android-licenses || true

CMD ["/bin/bash"]
