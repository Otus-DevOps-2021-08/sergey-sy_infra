#!/bin/bash
sudo chmod 664 /etc/mongod.conf
sudo sed -i.bak 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/g' /etc/mongod.conf
sudo systemctl daemon-reload
sudo systemctl restart mongod

