#!/bin/bash
echo "======Deploy Reddit======"
sudo apt-get update
sudo apt-get install -y git
cd ~ && git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
echo "======Project processes======"
ps aux | grep puma
