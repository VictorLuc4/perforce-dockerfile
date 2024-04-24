FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y wget gnupg && \
    wget https://package.perforce.com/perforce.pubkey && \
    gpg -n --import --import-options import-show perforce.pubkey | grep -q "E58131C0AEA7B082C6DC4C937123CB760FF18869" && echo "true" && \
    wget -qO - https://package.perforce.com/perforce.pubkey | apt-key add - && \
    echo "deb http://package.perforce.com/apt/ubuntu focal release" > /etc/apt/sources.list.d/perforce.list && \
    apt-get update && \
    apt-get install -y helix-p4d

EXPOSE 1666

ENV USERNAME admin_username
ENV PASSWORD admin_password

CMD /opt/perforce/sbin/configure-helix-p4d.sh test -n -u $USERNAME -P $PASSWORD -p ssl:1666 -r /opt/perforce/servers/master --unicode
