mkdir -p /var/logs/
touch /var/logs/remove.log
echo "Use tail -f /var/logs/remove.log to monitor proggress."
apt -y purge \
    acl \
    apparmor \
    build-essential \
    cifs-utils \
    cron \
    curl \
    debconf-utils \
  #  dmsetup \
    #ipset \
   # iptables \
    #linux-generic \
  #  logrotate \
    nfs-common \
 #   openssh-server \
    pwgen \
#    resolvconf \
    sshfs \
    swaks \
    tzdata \
#    unattended-upgrades \
    unbound \
    unzip \
    xfsprogs >> /var/logs/remove.log
systemctl start exim4  >> /var/logs/remove.log
systemctl enable exim4  >> /var/logs/remove.log

# enable bind for good measure (on online.net, kimsufi servers these are pre-installed)
systemctl start bind9  >> /var/logs/remove.log
systemctl enable bind9  >> /var/logs/remove.log

# on ovh images dnsmasq seems to run by default
systemctl start dnsmasq  >> /var/logs/remove.log
systemctl enable dnsmasq  >> /var/logs/remove.log

# on ssdnodes postfix seems to run by default
systemctl start postfix  >> /var/logs/remove.log
systemctl enable postfix >> /var/logs/remove.log

# on ubuntu 18.04 and 20.04, this is the default. this requires resolvconf for DNS to work further after the enable
systemctl start systemd-resolved >> /var/logs/remove.log
systemctl enable systemd-resolved >> /var/logs/remove.log
rm /etc/unbound/unbound.conf.d/cloudron-network.conf >> /var/logs/remove.log
rm -r /etc/systemd/system/docker.service.d >> /var/logs/remove.log
curl -sL "https://download.docker.com/linux/ubuntu/dists/${ubuntu_codename}/pool/stable/amd64/containerd.io_1.5.11-1_amd64.deb" -o /tmp/containerd.deb >> /var/logs/remove.log
curl -sL "https://download.docker.com/linux/ubuntu/dists/${ubuntu_codename}/pool/stable/amd64/docker-ce-cli_${docker_version}~3-0~ubuntu-${ubuntu_codename}_amd64.deb" -o /tmp/docker-ce-cli.deb >> /var/logs/remove.log
curl -sL "https://download.docker.com/linux/ubuntu/dists/${ubuntu_codename}/pool/stable/amd64/docker-ce_${docker_version}~3-0~ubuntu-${ubuntu_codename}_amd64.deb" -o /tmp/docker.deb >> /var/logs/remove.log
apt install -y /tmp/containerd.deb  /tmp/docker-ce-cli.deb /tmp/docker.deb >> /var/logs/remove.log
apt purge -y /tmp/containerd.deb  /tmp/docker-ce-cli.deb /tmp/docker.deb >> /var/logs/remove.log
apt remove -y nginx-full >> /var/logs/remove.log
systemctl stop box >> /var/logs/remove.log
systemctl disable box >> /var/logs/remove.log
echo "Now Rebooting" >> /var/logs/remove.log
reboot >> /var/logs/remove.log
