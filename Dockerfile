FROM ubuntu:18.04
RUN apt-get update && \
    apt-get -y install sudo openssh-server libx11-xcb-dev libasound2 git xauth && \
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
RUN useradd -m -p $(openssl passwd -1 123456) -s /bin/bash ahihi && \
    usermod -aG sudo ahihi
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["sh", "-c", "/usr/sbin/sshd && tail -f /dev/null"]
