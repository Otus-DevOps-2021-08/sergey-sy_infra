#!/bin/bash

echo "======Put public key to authorized_keys======"
PUBKEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDbUcZEwI15yaNgPPGdzewWuVhxHu+PaI2gjvtrbv0ptr30vsVlI7x5UZ0iCKQMm4MWJl2iOpnuo7nBcTPfABnPAecqsnjmD9I5FvgQEMtD3KSH6VJpPGYjhRVGm+RaESC8JHVqXSWEMrsoVHfypn8CMOJ1dXAvXj5TTgLyoaURWxTxMdtqcJV13ybMZ5P7CfFb5LWLfk97/5HXkyog5Jg++fixqUvW1MPONsNnLYQNIjXXXaAt0SVHiKmb48LsgLHQu+rly4uUuHCBWah0teaca3eEPkZHs5t0RrWmzZOQldjbp7zIro250Rj4zXSxq5RqSZPxUtsEjT5ytTWU3tfeDT+xFFb+ZpxaUNsTQ9UmvJLwXqXNVaP9DH8PrNIyMUfZjwO4OntXHiiQdssAxbHOiwPBdKoxJAPMq0VWPVFJ62Eijs5UTpjNMt7LteZctIoW+TbHPZ+q8yhJGvKNg5GPo+T/ZZvY6yr4PmdMf4T/ZMqp+ScrRmzDyhCj8wPyDvc= a18565272@CAB-WSM-0006725"
sudo echo $PUBKEY > ~/.ssh/authorized_keys

echo "======Create user======"
USERNAME="yc-user"
adduser --disabled-password --gecos "" $USERNAME
echo "$USERNAME ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USERNAME
sudo -i -u $USERNAME bash << EOF
echo "Run installation as user:"
whoami
mkdir /home/$USERNAME/.ssh
touch /home/$USERNAME/.ssh/authorized_keys
echo $PUBKEY > /home/$USERNAME/.ssh/authorized_keys
chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh
chmod 0700 /home/$USERNAME/.ssh
chmod 0600 /home/$USERNAME/.ssh/authorized_keys

echo "======Install Ruby======"
sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential
ruby -v
bundler -v

echo "======Install and run MongoDB======"
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod
sudo systemctl status mongod

echo "======Deploy Reddit======"
sudo apt-get update
sudo apt-get install -y git
cd ~ && git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d

echo "======Project processes======"
ps aux | grep puma
echo "Finish installation as user $(whoami)"
EOF
