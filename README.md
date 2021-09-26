# sergey-sy_infra
sergey-sy Infra repository

#### ДЗ 3
В VPC поднято 2 VM: 1 с белым IP, 2ая без.
На белом IP находится pritunl server c тестовым юзером https://178.154.252.161.sslip.io

bastion_IP = 178.154.252.161
someinternalhost_IP = 10.128.0.34

Чтобы попасть на вторую машину через первую можно использовать SSH Jump Server и ssh агент авторизации:
```
ssh-add ~/.ssh/your_private_key
$ ssh -J appuser@bastion_IP -i .ssh/your_private_key appuser@someinternalhost_IP
```

Добавьте в ```~/.ssh/config``` следующие настройки, чтобы попадать на внутренюю машину по команде:
```$ ssh someinternalhost```

```sh
Host someinternalhost
    HostName someinternalhost_IP
    User appuser
    IdentityFIle ~/.ssh/your_private_key
    ProxyJump appuser@bastion_IP
```

#### ДЗ 4
testapp_IP = 84.252.128.80
testapp_port = 9292

В результате применения данной команды CLI поднимается инстанс с уже запущенным приложением.
Скрипт сборки приложения находится в файле ```yc-cloud-init-script.sh``` и передаётся с ключом --metadata-from-file
```
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-id=e9bje33hq7gr7366705p,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=yc-cloud-init-script.sh
```


#### ДЗ 5

В данном ДЗ создан шаблон для packer ubuntu116.json  при помощи которого можно собрать reddit-base  образ в YC.
В указанном шаблоне используется параметризация, которая хранится в файле variables.json. Файл с параметрами находится локально у пользователя и не отправляется в git.
В VM собранной на основе этого шаблона нужно самостоятельно установить приложение reddit ```packer/scripts/deploy.sh```

Чтобы избежать ручной работы по самостоятельной установке reddit руками, создан ещё один шаблон packer immutable.json, который схожим образом собирает образ reddit-full, но при этом дополнительными провиженерами в образ при сборке деплоится приложение reddit и настраивается автоматический старт приложения reddit как сервиса (packer/files/puma.service)  при старте VM.
В директории packer/scripts находится баш-скрипт create-reddit-vm.sh который выполняет команду YC CLI по созданию VM на основе образа reddit-full.

В шаблонах используется файл-ключ YC CLI который хранится у пользователя локально и не отправляется в git.

