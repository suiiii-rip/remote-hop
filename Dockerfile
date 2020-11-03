FROM linuxserver/openssh-server:amd64-latest

COPY sshd_config.tmp /etc/ssh/sshd_config

