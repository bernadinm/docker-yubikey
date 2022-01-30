from debian

RUN apt update -y
RUN apt install git curl gpg scdaemon -y

# Debug tools
RUN apt install vim procps -y

# Used to fetch public gpg key used later in signing by private key on smartcard
RUN curl -sSL gpg.miguel.engineer | gpg --import -

RUN gpgconf --list-dirs agent-ssh-socket
ENV SSH_AUTH_SOCK=/root/.gnupg/S.gpg-agent.ssh

COPY init.sh .
RUN chmod 700 init.sh

COPY .ssh/config /root/.ssh/config
COPY .gitconfig /root/.gitconfig

RUN gpgconf --launch gpg-agent

# Hardcode tty to allow user pin from cli
ENV GPG_TTY="/dev/pts/0"

ENTRYPOINT ./init.sh

# RUN GPG_TTY=$(tty)
# RUN export GPG_TTY
