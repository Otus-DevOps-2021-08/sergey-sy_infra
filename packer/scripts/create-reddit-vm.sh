#!/bin/bash
# create VM from backed image with image-id=fd86luoo6asj33i6otnq (has ruby, mongodb, reddit autorun as ubuntu service)
yc compute instance create \
  --name reddit-full-autorun \
  --hostname reddit-full-autorun \
  --memory=4 \
  --create-boot-disk image-id=fd86luoo6asj33i6otnq,size=10GB \
  --network-interface subnet-id=e9bje33hq7gr7366705p,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --ssh-key ~/.ssh/id_rsa.pub
