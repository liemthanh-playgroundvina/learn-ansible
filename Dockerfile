# docker build -t ubuntu-ssh-rsa .
# docker run -d --name my_ubuntu_ssh -p 2222:22 ubuntu-ssh-rsa
# ssh -i ~/.ssh/id_rsa ubuntu@localhost -p 2222

FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y openssh-server sudo && \
    apt-get clean

RUN mkdir /var/run/sshd && \
    mkdir -p /home/ubuntu/.ssh && \
    chown -R ubuntu:ubuntu /home/ubuntu/.ssh && \
    chmod 700 /home/ubuntu/.ssh

COPY id_rsa.pub /home/ubuntu/.ssh/authorized_keys

RUN chown ubuntu:ubuntu /home/ubuntu/.ssh/authorized_keys && \
    chmod 600 /home/ubuntu/.ssh/authorized_keys && \
    echo "ubuntu:ubuntu" | chpasswd && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

USER ubuntu

RUN ssh-keygen -t rsa -b 4096 -f /home/ubuntu/.ssh/id_rsa -N "" && \
    chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa /home/ubuntu/.ssh/id_rsa.pub

USER root

WORKDIR /home/ubuntu

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
