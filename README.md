# sergey-sy_infra
sergey-sy Infra repository

В VPC поднято 2 VM: 1 с белым IP, 2ая без.
На белом IP находится pritunl server c тестовым юзером https://178.154.252.161.sslip.io

bastion_IP = 178.154.252.161
someinternalhost_IP = 10.128.0.34

Чтобы попасть на вторую машину через первую можно использовать SSH Jump Server и ssh агент авторизации:
```ssh-add ~/.ssh/your_private_key```
```$ ssh -J appuser@bastion_IP -i .ssh/your_private_key appuser@someinternalhost_IP```

Добавьте в ```~/.ssh/config``` следующие настройки, чтобы попадать на внутренюю машину по команде:
```$ ssh someinternalhost```

```sh
Host someinternalhost
    HostName someinternalhost_IP
    User appuser
    IdentityFIle ~/.ssh/your_private_key
    ProxyJump appuser@bastion_IP
```
