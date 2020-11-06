FROM linuxserver/openssh-server:latest

COPY sshd_config.tmp /etc/ssh/sshd_config

