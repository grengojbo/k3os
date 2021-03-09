ARG REPO
ARG TAG
FROM ${REPO}/k3os-base:${TAG} AS base

ARG ENABLE_QEMU
ARG ENABLE_VAULT
ARG ENABLE_SELINUX
ARG CUSTOM_PACKAGES
ARG DISABLE_MDADM
ARG DISABLE_LVM
ARG DISABLE_ISCSI

RUN apk --no-cache add \
    grub-bios \
    cloud-utils \
    cloud-utils-growpart
    # aws-cli \
    # aws-cli-bash-completion \
# RUN if [ "$CLOUD_PROVIDER" == "vmware" ]; then \
#         apk --no-cache add \
#         open-vm-tools \
#     ;elif [ "$CLOUD_PROVIDER" == "aws" ]; then \
#         apk --no-cache add aws-cli \
#         aws-cli-bash-completion \
#     ;fi
#     ;else \

RUN if [ "${ENABLE_SELINUX}" == "yes" ]; then \
        echo "[INSTALL] SELinux..." && sleep 2 && \
        apk --no-cache add \
        libselinux \
        libselinux-utils \
        # only edge is not 3.13
        && apk --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing add policycoreutils \
        #policycoreutils \
    ;else \
        echo "[DISABLE] SELinux..." && sleep 2 \
    ;fi

RUN if [ "${ENABLE_VAULT}" == "yes" ]; then \
        echo "[INSTALL] Vault..." && sleep 2 && \
        apk --no-cache add \
        vault \
        # vault-openrc \
    ;else \
        echo "[DISABLE] Vault..." && sleep 2 \
    ;fi

RUN if [ "$DISABLE_ISCSI" != "yes" ]; then \
  echo "[INSTALL] ISCSI..." && sleep 2 && \
  apk --no-cache add \
  iscsi-scst \
  open-iscsi \
  lsscsi \
;else \
  echo "[DISABLE] ISCSI..." && sleep 2 \
;fi

RUN if [ "$DISABLE_LVM" != "yes" ]; then \
  echo "[INSTALL] lvm2..." && sleep 2 && \
  apk --no-cache add \
  lvm2 \
  lvm2-extra \
;else \
  echo "[DISABLE] lvm2..." && sleep 2 \
;fi

RUN if [ "$DISABLE_MDADM" != "yes" ]; then \
  echo "[INSTALL] mdadm..." && sleep 2 && \
  apk --no-cache add \
  mdadm \
  mdadm-misc \
  mdadm-udev \
;else \
  echo "[DISABLE] mdadm..." && sleep 2 \
;fi

RUN if [ "${CUSTOM_PACKAGES}" != "" ]; then \
  echo "[INSTALL] custom package..." && \
  apk --no-cache add ${CUSTOM_PACKAGES/,/ } \
;else \
  apk --no-cache add \
  nfs-utils \
  wpa_supplicant \
  xfsprogs \
  smartmontools \
;fi

RUN if [ "$ENABLE_QEMU" = "yes" ] ; then \
  echo "[INSTALL] QEMU..." && sleep 2 && \
  apk --no-cache add \
  qemu-guest-agent \
  && mv -vf /etc/conf.d/qemu-guest-agent /etc/conf.d/qemu-guest-agent.orig \
;else \
  echo "[DISABLE] QEMU..." && sleep 2 \
; fi

# RUN if [ ! -z "$ENABLE_" ]; then \
#         apk --no-cache add \
#     ;fi
# RUN ["/bin/bash", "-c", "env && cd /error"]
