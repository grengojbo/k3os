ARG REPO
ARG TAG
FROM ${REPO}/k3os-base:${TAG} AS base
RUN apk --no-cache add \
    grub-bios \
    open-vm-tools
# RUN if [ "$CLOUD_PROVIDER" == "vmware" ]; then \
#         apk --no-cache add \
#         grub-bios \
#         open-vm-tools \
#     ;elif [ "$CLOUD_PROVIDER" == "aws" ]; then \
#         apk --no-cache add aws-cli \
#     ;fi
# RUN if [ !-z "$CUSTOM_PACKAGES" ]; then \
#         apk --no-cache add $CUSTOM_PACKAGES \
#     ;fi