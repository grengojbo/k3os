### BASE ###
FROM alpine:3.13 as base
# FROM alpine:edge as base
ARG ARCH
RUN apk --no-cache add \
    bash \
    bash-completion \
    blkid \
    busybox-initscripts \
    ca-certificates \
    connman \
    conntrack-tools \
    coreutils \
    curl \
    dbus \
    dmidecode \
    dosfstools \
    e2fsprogs \
    e2fsprogs-extra \
    efibootmgr \
    eudev \
    findutils \
    grub-efi \
    haveged \
    htop \
    hvtools \
    iproute2 \
    iptables \
    irqbalance \
    jq \
    kbd-bkeymaps \
    lm-sensors \
    logrotate \
    multipath-tools \
    ncurses \
    ncurses-terminfo \
    openrc \
    openssh-client \
    openssh-server \
    parted \
    procps \
    rng-tools \
    rsync \
    shadow-uidmap \
    strace \
    sudo \
    tar \
    tzdata \
    util-linux \
    vim \
    wireguard-tools \
    xz \
 && mv -vf /etc/conf.d/rngd             /etc/conf.d/rngd.orig \
 && mv -vf /etc/conf.d/udev-settle      /etc/conf.d/udev-settle.orig \
# replicate the default "no idea, friend" behavior of virt-what
 && touch /usr/sbin/virt-what \
 && chmod +x /usr/sbin/virt-what
