FROM ubuntu:18.04
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
RUN apt-get install -y software-properties-common && \
    wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb && \
    dpkg -i /tmp/packages-microsoft-prod.deb && \
    rm /tmp/packages-microsoft-prod.deb && \
    apt-get install -y software-properties-common && \
    add-apt-repository universe && \
    apt-get update && \
    apt-get install -y apt-transport-https && \
    apt-get update && \
    apt-get install -y dotnet-sdk-3.1
RUN useradd -m -p $(openssl passwd -1 123456) -s /bin/bash ahihi && \
    usermod -aG sudo ahihi
RUN wget -O /tmp/code.deb https://go.microsoft.com/fwlink/?LinkID=760868 && \
    apt install -y /tmp/code.deb && rm /tmp/code.deb && \
    wget -q https://dl.google.com/go/go1.14.linux-amd64.tar.gz -O /tmp/go1.14.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf /tmp/go1.14.linux-amd64.tar.gz && \
    rm /tmp/go1.14.linux-amd64.tar.gz && \
    npm install -g @vue/cli && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
USER ahihi
RUN code --install-extension octref.vetur && \
    code --install-extension ms-dotnettools.csharp && \
    code --install-extension ms-vscode.go && \
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
USER root
ENTRYPOINT ["sh", "-c", "/usr/sbin/sshd && tail -f /dev/null"]

