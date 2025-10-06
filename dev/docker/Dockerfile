FROM ubuntu:24.04

# Accept build arguments
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG USERNAME=devuser

# Install dependencies and some build env tools
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y \
        bash git tmux vim nano htop curl supervisor unzip sudo \
        mysql-server-8.0 apache2 php8.3 \
        php8.3-fpm php8.3-curl php8.3-mbstring php8.3-ldap php8.3-xml php8.3-zip php8.3-gd php8.3-mysql php8.3-xdebug

# Create group and user with specific IDs, and give user sudo access (for service management)
RUN userdel -r ubuntu && \
    groupadd -g ${GROUP_ID} ${USERNAME} && \
    useradd -u ${USER_ID} -g ${GROUP_ID} -m -s /bin/bash ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install build tools (composer/node/npm)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    mkdir -p "/home/${USERNAME}/.nvm" && export NVM_DIR="/home/${USERNAME}/.nvm" && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash && \
        \. "/home/${USERNAME}/.nvm/nvm.sh" && \
        nvm install 22 && \
        chown -R ${USERNAME} "/home/${USERNAME}/.nvm" && \
        echo 'export NVM_DIR="${HOME}/.nvm" && source "$NVM_DIR/nvm.sh"' >> "/home/${USERNAME}/.bashrc"

# Configure apache, php & mysql
RUN a2dissite 000-default.conf && \
    a2enmod rewrite proxy_fcgi setenvif && \
    a2enconf php8.3-fpm && \
    sed -i "s/www-data/${USERNAME}/g" "/etc/php/8.3/fpm/pool.d/www.conf" && \
    sed -i "s/www-data/${USERNAME}/g" "/etc/apache2/envvars" && \
    chmod 755 /var/run/mysqld

# Copy required configuration & entrypoint script
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY apache.conf /etc/apache2/sites-enabled/bookstack.conf
COPY setup.sql /setup.sql
COPY entrypoint.sh /entrypoint.sh

# Set our user, working directory, entrypoint and default command
USER ${USERNAME}
WORKDIR /app
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
