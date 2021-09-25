#!/bin/bash
echo "======Deploy Reddit======"
sudo apt-get update
sudo apt-get install -y git
cd ~ && git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install

echo "======Add puma.service======"
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl enable puma.service

