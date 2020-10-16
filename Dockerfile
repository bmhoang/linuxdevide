FROM ubuntu:18.04
ENV app=hobot-dev
RUN apt-get update && \
    apt-get -y install sudo openssh-server nodejs npm libx11-xcb-dev libasound2 git xauth && \
    mkdir /var/run/sshd && \
    mkdir /root/.ssh && \
    chmod 700 /root/.ssh && \
    ssh-keygen -A && \
    sed -i "s/^.*X11Forwarding.*$/X11Forwarding yes/" /etc/ssh/sshd_config && \
    sed -i "s/^.*X11UseLocalhost.*$/X11UseLocalhost no/" /etc/ssh/sshd_config && \
    grep "^X11UseLocalhost" /etc/ssh/sshd_config || echo "X11UseLocalhost no" >> /etc/ssh/sshd_mkdir /var/run/sshd && \
    chmod 700 /root/.ssh && \
    ssh-keygen -A && \
    sed -i "s/^.*X11Forwarding.*$/X11Forwarding yes/" /etc/ssh/sshd_config && \
    sed -i "s/^.*X11UseLocalhost.*$/X11UseLocalhost no/" /etc/ssh/sshd_config && \
    grep "^X11UseLocalhost" /etc/ssh/sshd_config || echo "X11UseLocalhost no" >> /etc/ssh/sshd_config
RUN wget -O /tmp/code.deb https://go.microsoft.com/fwlink/?LinkID=760868 && \
    apt install -y /tmp/code.deb && rm /tmp/code.deb && \
    apt-get install -y build-essential gdb libxcb-dri3-dev libdrm2 libgbm-dev cmake libpcre3-dev zlib1g-dev libgcrypt11-dev libicu-dev python
RUN wget -O /tmp/cppcms-1.2.1.tar.gz https://github.com/artyom-beilis/cppcms/archive/v1.2.1.tar.gz && \
    cd /tmp && tar -xf cppcms-1.2.1.tar.gz && \
    mkdir -p /tmp/cppcms-1.2.1/build && \
    cd /tmp/cppcms-1.2.1/build && cmake .. && make && make install && \
    rm -rf /tmp/cppcms-1.2.1 && rm /tmp/cppcms-1.2.1.tar.gz
RUN apt-get update && apt-get install -y libcurl4-openssl-dev
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN useradd -m -p '$1$5S2c1nJQ$C8.DfrGIIj8LyhHqihhUg0' -s /bin/bash ahihi && \
    usermod -aG sudo ahihi
USER ahihi
RUN code --install-extension ms-vscode.cpptools && \
    code --install-extension ms-vscode.cmake-tools
USER root
ENV LD_LIBRARY_PATH=/usr/local/lib
ENTRYPOINT ["sh", "-c", "/usr/sbin/sshd && tail -f /dev/null"]
