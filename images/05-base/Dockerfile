ARG REPO
ARG TAG
ARG ENABLE_VAULT
ARG CUSTOM_PACKAGES
FROM ${REPO}/k3os-base:${TAG} AS base
RUN apk --no-cache add \
    grub-bios \
    cloud-utils \
    cloud-utils-growpart
RUN if [ "$CLOUD_PROVIDER" == "vmware" ]; then \
        apk --no-cache add \
        open-vm-tools \
    ;elif [ "$CLOUD_PROVIDER" == "aws" ]; then \
        apk --no-cache add aws-cli \
    ;else \
        apk --no-cache add \
        qemu-guest-agent \
        && mv -vf /etc/conf.d/qemu-guest-agent /etc/conf.d/qemu-guest-agent.orig \
    ;fi
RUN if [ ! -z "$ENABLE_VAULT" ]; then \
        apk --no-cache add \
        vault \
        vault-openrc \
    ;fi
RUN if [ ! -z "$ENABLE_SELINUX" ]; then \
        apk --no-cache add \
        libselinux \
        libselinux-utils \
        # only edge is not 3.13
        #policycoreutils \
    ;fi
RUN if [ -z "$DISABLE_ISCSI" ]; then \
        apk --no-cache add \
        iscsi-scst \
        open-iscsi \
        lsscsi \
    ;fi
RUN if [ -z "$DISABLE_LVM" ]; then \
        apk --no-cache add \
        lvm2 \
        lvm2-extra \
    ;fi
RUN if [ -z "$DISABLE_MDADM" ]; then \
        apk --no-cache add \
        mdadm \
        mdadm-misc \
        mdadm-udev \
    ;fi
# RUN if [ ! -z "$ENABLE_" ]; then \
#         apk --no-cache add \
#     ;fi
RUN if [ ! -z "${CUSTOM_PACKAGES}" ]; then \
        apk --no-cache add ${CUSTOM_PACKAGES} \
    ;else \
        apk --no-cache add \
        nfs-utils \
        wpa_supplicant \
        xfsprogs \
        smartmontools \
    ;fi