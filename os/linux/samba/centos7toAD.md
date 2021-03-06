

URL
- https://serveradmin.ru/nastroyka-samba-s-integratsiey-v-ad/

```bash
cat /etc/redhat-release
```
```input
CentOS Linux release 7.8.2003 (Core)
```
```bash
vim /etc/sysconfig/selinux
SELINUX=disabled
```
OR
```bash
setenforce 0
```

FirewallD
```bash
systemctl stop firewalld
systemctl disable firewalld
```

#Time
```bash
yum install chronyvi
```
```bash
vim /etc/chrony.conf 
server dc1.xxx.local iburst

systemctl start chronyd && systemctl enable chronyd
```

install
```bash
yum install realmd sssd sssd-libwbclient oddjob oddjob-mkhomedir adcli samba-common samba-common-tools
```
Проверка
```bash
realm discover XXX.LOCAL
```
```output
xxx.local
  type: kerberos
  realm-name: XXX.LOCAL
  domain-name: xxx.local
  configured: no
  server-software: active-directory
  client-software: sssd
  required-package: oddjob
  required-package: oddjob-mkhomedir
  required-package: sssd
  required-package: adcli
  required-package: samba-common-tools
```

Завести в домен сервер
```bash
realm join -U adminXX XXX.LOCAL
```

Проверьте на самом сервере, что он нормально обращается к домену и получает информацию об учетных записях
```bash
id adminXX@xxx.local
```
```output
uid=1353801000(adminXX@xxx.local) gid=1353800513(domain users@cktema.lan) группы=1353800513(domain users@cktema.lan)
```

```bash
 realm list
```
```output
xxx.local
  type: kerberos
  realm-name: XXX.LOCAL
  domain-name: xxx.local
  configured: kerberos-member
  server-software: active-directory
  client-software: sssd
  required-package: oddjob
  required-package: oddjob-mkhomedir
  required-package: sssd
  required-package: adcli
  required-package: samba-common-tools
  login-formats: %U@xxx.local
  login-policy: allow-realm-logins
[root@srv4new1 ~]#
[root@srv4new1 ~]# adcli info xxx.local
[domain]
domain-name = xxx.local
domain-short = XXX
domain-forest = xxx.local
domain-controller = dc1.xxx.local
domain-controller-site = Default-First-Site-Name
domain-controller-flags = pdc gc ldap ds kdc timeserv closest writable good-timeserv full-secret ads-web
domain-controller-usable = yes
domain-controllers = dc1.xxx.local
[computer]
computer-site = Default-First-Site-Name
```

```bash
adcli info cktema.lan
```
```output
[domain]
domain-name = xxx.local
domain-short = XXX
domain-forest = xxx.local
domain-controller = dc1.xxx.local
domain-controller-site = Default-First-Site-Name
domain-controller-flags = pdc gc ldap ds kdc timeserv closest writable good-timeserv full-secret ads-web
domain-controller-usable = yes
domain-controllers = dc1.xxx.local
[computer]
computer-site = Default-First-Site-Name
```


#SAMBA
```bash
yum install samba
```
```bash
vim /etc/samba/smb.conf

# See smb.conf.example for a more detailed config file or
# read the smb.conf manpage.
# Run 'testparm' to verify the config is correct after
# you modified it.

[global]
#--authconfig--start-line--

# Generated by authconfig on 2020/08/14 10:17:48
# DO NOT EDIT THIS SECTION (delimited by --start-line--/--end-line--)
# Any modification may be deleted or altered by authconfig in future

        #charset
        dos charset = cp866
        unix charset = utf-8
#       display charset = utf-8

        workgroup = CKTEMA
#       password server = cktema.lan
        realm = CKTEMA.LAN
        security = ads

        interfaces = lo tap29 172.16.29.2/24 10.0.1.0/24 10.0.1.4/24


#       idmap config * : rangesize = 1000000
        idmap config * : range = 1000000-19999999
#       idmap config * : backend = autorid

        template homedir = /home/%U
        template shell = /bin/bash
        kerberos method = secrets only
        winbind use default domain = true
        winbind offline logon = false

#       encrypt passwords = yes
        passdb backend = tdbsam

        load printers = no
        show add printer wizard = no
        printcap name = /dev/null
        disable spoolss = yes

        domain master = no
        local master = no
        preferred master = no
        os level = 1

        cups options = raw
        #logs
        log file = /var/log/samba/log.%m
        log level =3
        max log size = 500
#       printing = cups


[TEST]
        comment = Shared folder for test
        path = /mnt/shara
#       public = no
#       guest ok = no
#       valid users = @"Domain Users@cktema.lan", @"iqsupport@cktema.lan"
        writeable = yes
        browsable = yes
        valid users = "@CKTEMA\Domain Users"
        admin users = "@CKTEMA\Администраторы домена",@"iqsupport@cktema.lan"
        create mask = 0600
        directory mask = 0700

[CKTEMA]
        comment = Documents for CKTEMA
        path = /mnt/cktema
#       public = no
#       guest ok = no
#       valid users = @"Domain Users@cktema.lan", @"iqsupport@cktema.lan"
        writeable = yes
        browsable = yes
        valid users = "@CKTEMA\Domain Users"
        admin users = "@CKTEMA\Администраторы домена",@"iqsupport@cktema.lan"
        create mask = 0644
        directory mask = 0700

#[homes]
#       comment = Home Directories
#       valid users = %S, %D%w%S
#       browseable = No
#       read only = No
#       inherit acls = Yes

#[printers]
#       comment = All Printers
#       path = /var/tmp
#       printable = Yes
#       create mask = 0600
#       browseable = No

#[print$]
#       comment = Printer Drivers
#       path = /var/lib/samba/drivers
#       write list = @printadmin root
#       force group = @printadmin
#       create mask = 0664
#       directory mask = 0775

```


```bash
systemctl start smb.service
systemctl enable smb.service
```

Вводим CentOS 7 в домен с помощью winbind

```bash
yum install samba-winbind samba-winbind-clients samba pam_krb5 krb5-workstation chrony
```

```bash
# authconfig --enablekrb5 --krb5kdc=xs-winsrv.xs.local --krb5adminserver=xs-winsrv.xs.local --krb5realm=XS-WINSRV.XS.LOCAL --enablewinbind --enablewinbindauth --smbsecurity=ads --smbrealm=XS.LOCAL --smbservers=xs-winsrv.xs.local --smbworkgroup=XS --winbindtemplatehomedir=/home/%U --winbindtemplateshell=/bin/bash --enablemkhomedir --enablewinbindusedefaultdomain --update
```
```bash
authconfig --enablekrb5 --krb5kdc=cktema.lan --krb5adminserver=cktema.lan.local --krb5realm=CKTEMA.LAN --enablewinbind --enablewinbindauth --smbsecurity=ads --smbrealm=CKTEMA.LAN --smbservers=cktema.lan --smbworkgroup=CKTEMA --winbindtemplatehomedir=/home/%U --winbindtemplateshell=/bin/bash --enablemkhomedir --enablewinbindusedefaultdomain --update[root@srv4new1 ~]#
```
```bash
net ads join -U iqsupport
```
```output
Enter iqsupport's password:
Using short domain name -- CKTEMA
Joined 'SRV4NEW1' to dns domain 'cktema.lan'
No DNS domain configured for srv4new1. Unable to perform DNS Update.
DNS update failed: NT_STATUS_INVALID_PARAMETER
```


```bash
systemctl start winbind
systemctl start smb.service
systemctl enable winbind
systemctl enable smb.service
```

```bash
wbinfo -t
checking the trust secret for domain XS via RPC calls succeeded
```

```bash
wbinfo -u
wbinfo -g
```

```bash
wbinfo -a XX\\adminXX-
challenge/response password authentication succeeded
```

```bash
id control
uid=16777216(control) gid=16777220(пользователи домена) groups=16777220(пользователи домена),16777221(gr_z),16777222(gr_sams2),16777223(gr_y),16777217(BUILTIN\users)
```

Теперь все готово для корректной работы файлового сервера на основе Samba с доменными учетными записями. 
В завершении настроек, сделаем администратора домена владельцем нашей шары.

```bash
# chown admin51:'пользователи домена' /mnt/shara
```

Проверяем, что получилось.
```bash
# ll /mnt
total 0
drwxr-xr-x 2 admin51 пользователи домена 6 Sep 27 17:15 shara
```

Уберем доступ на чтение у всех остальных, оставим полные права для пользователя admin51 и на чтение у пользователей домена.
```bash
# chmod 0750 /mnt/shara
```

Идем на любую виндовую машину и пробуем зайти на шару по адресу \\ip-адрес-сервера. Попадаем на нашу шару.
Если не получилось зайти, проверьте настройки iptables. На время отладки можно их отключить. Так же убедитесь, что у вас запущена служба smb.service.

Смотрим расширенные параметры безопасности:

Права в Samba через windows acl

Управлять правами доступа можно через windows acl с любой машины windows, где учетная запись пользователя домена будет обладать необходимыми правами. 
Если это не получится (с такими ситуациями сталкиваются достаточно часто), на помощь придут консольные утилиты getfacl для проверки прав и setfacl для изменения прав. 
Через консоль выставление прав будет выполнено раз в 5-10 быстрее, чем через windows acl.
На больших файловых архивах разница может быть в десятки минут или даже часы.

Настройка прав доступа на файлы в Samba

Изменять права доступа к каталогам на файловом сервере можно с помощью команды setfacl. 

Посмотреть на права доступа, которые установлены:
```bash
# getfacl /mnt/samba

# file: mnt/shara
# owner: admin51
# group: пользователи\040домена
user::rwx
group::r-x
other::---
```

Добавим права доступа на чтение и запись еще одной доменной группе - gr_it.
```bash
# setfacl -m g:gr_it:rwx /mnt/shara
```

Внимание, что иногда при копировании команд setfacl они не отрабатывают, выдавая не очень понятную ошибку:
```note
setfacl: Option -m: Invalid argument near character 1

Наберите команду с клавиатуры, либо просто удалите и наберите снова ключ -m, он почему-то при копировании часто дает эту ошибку.
```

Проверяю
```bash
# getfacl /mnt/shara

# file: mnt/shara
# owner: admin51
# group: пользователи\040домена
user::rwx
group::r-x
group:gr_it:rwx
mask::rwx
other::---
```
Теперь пользователи группы gr_it имеют полные права на шару. 

Создание одним таким пользователем папку test1 на нашей шаре и посмотрим, какие права она получит.
```bash
# getfacl /mnt/shara/test1

# file: mnt/shara/test1
# owner: user1
# group: пользователи\040домена
user::rwx
group::---
other::---
```

Права на папку имеет только ее создатель и больше никто. 
Для того, чтобы наследовались права с вышестоящего каталога, необходимо на этот вышестоящий каталог добавить дефолтные права доступа. 
Примерно вот так.
```bash
# setfacl -m d:g:gr_it:rwx,d:g:'пользователи домена':rx /mnt/shara
```

Проверяем
```bash
# getfacl /mnt/shara

# file: mnt/shara
# owner: admin51
# group: пользователи\040домена
user::rwx
group::r-x
group:gr_it:rwx
mask::rwx
other::---
default:user::rwx
default:group::r-x
default:group:пользователи\040домена:r-x
default:group:gr_it:rwx
default:mask::rwx
default:other::---
```

Создадим теперь тем же пользователем еще одну папку test2 и проверим ее права.
```bash
# getfacl /mnt/shara/test2

# file: mnt/shara/test2
# owner: user
# group: пользователи\040домена
user::rwx
group::---
group:пользователи\040домена:r-x
group:gr_it:rwx
mask::rwx
other::---
default:user::rwx
default:group::r-x
default:group:пользователи\040домена:r-x
default:group:gr_it:rwx
default:mask::rwx
default:other::---
```

Применилось наследование с вышестоящих папок. 
Не забывайте про дефолтные права и учитывайте их при настройке прав доступа на файловом сервере.

Для удобной и корректной работы с правами доступа я обычно для крупных, корневых директорий выставляю права аккуратно через setfacl в консоли. 
Какие-то мелкие изменения по пользователям и группам в более низших иерархиях директорий делаю через windows acl с какой-нибудь виндовой машины.

Еще важно знать одну особенность выставления прав доступа в linux. 
В моей практике часто требуется дать какому-нибудь пользователю доступ в одну директорию, которая располагается там, где у пользователя нет вообще никаких прав. 
В windows эта проблема решается просто - даются права на конкретную папку, а пользователю кладется ярлык на эту папку. 
В итоге он имеет доступ к нужной директории и больше никуда.

В linux так сделать не получится. Для того, чтобы дать таким образом доступ на отдельную директорию пользователю, необходимо, чтобы по всем вышестоящим директориям у него были права на исполнение,то есть X. Их придется выставлять вручную по всем вышестоящим папкам. Результат будет такой же, как и в винде - пользователь получит доступ на чтение только в указанную папку, но для этого придется выполнить больше действий. Если не знаешь этот нюанс, можно потратить много времени, прежде чем поймешь, в чем проблема.

Заключение

Скажу откровенно - мне не нравится, как работают файловые сервера samba с интеграцией в виндовом домене. 
Но настраивать их приходится часто, так как востребованный функционал. 
Востребован в первую очередь потому, что не требует вообще никаких денег за лицензии, и работает на минимальной конфигурации железа. 
Вот список типичных проблем при работе самбы в домене:

    Иногда через windows acl права перестают выставляться, возникают неинформативные ошибки, по которым невозможно понять, что не так.
    Я достаточно регулярно наблюдаю ситуацию, когда слетают соответствия доменных учеток линуксовым UID. В итоге права доступа превращаются в ничего не значащий набор цифр и перестают работать.
    При переносе данных с одного сервера на другой трудно сохранить права доступа. Можно поступить вот так для копирования прав доступа, либо как-то заморочиться, чтобы на всех серверах у вас были одинаковые UID доменных учетных записей. Я не разбирал этот вопрос подробно.

  



```text
    Добрый день.

    Для решения проблемы сохранения UID при переносе и пр. задачах нужно разобраться с параметром backend
    Начиная с какой-то версии samba нужно разделять бекэнды по доменам и использовать бекэнд по умолчанию tdb. tdb это бекэнд который хранит UID локально на сервере с самбой (посмотреть (на ubuntu) net idmap dump /var/lib/samba/winbindd_idmap.tdb). Если его использовать со всеми доменами то получится каша, особенно если у вас несколько доменов, перенос на другой сервер усложняется. Есть несколько других бекэндов, я для себя выбрал rid - UID в данном случае высчитывается "на лету" используя часть windows SID и числа из указанного вами range. Этот механизм позволяет настроить самбу на другом сервере, указать тот же range для домена и в конечном итоге получить теже UID для каждой доменной учетной записи. Пример настроек для двух доменов:
    idmap config *: backend = tdb
    idmap config *: range = 3000-7999
    idmap config DOMAIN1: default = yes
    idmap config DOMAIN1: backend = rid
    idmap config DOMAIN1: range = 100000-199999
    idmap config DOMAIN2: backend = rid
    idmap config DOMAIN2: range = 200000-299999
    # Нужно для backend rid (уже не помню для чего, но бралось из документации по rid)
    winbind nss info = template
    template shell = /bin/bash
    template homedir = /home/%D/%U
```
   
   
```text
    Вопрос, может кто решал проблему.
    Есть сервер на самбе, все работает. У всех файлов и папок владелец root, остальные права на acl.
    Проблема: допустим есть 2 папки, у одной права группа1 и второй права группа2. Есть пользователь который входит в обе группы.
    Если данный пользователь КОПИРУЕТ файл из папки1 в папку2 то права на новый файл наследуются из папки2 - это правильная работа (для моей задачи). Но если он ПЕРЕНОСИТ файл, то в папке2 получается файл с правами папки1, и его соответственно не могут прочитать пользователи группа2. Можно каким-то параметром в самбе запретить копирование прав при переносе?
    
        попробуйте параметр inherit owner=yes

            inherit owner=yes установлен.
            Если пользователь - администратор сервера самба (директива admin users), то при перемещении права в новой папке наследуются правильно.
            Но если пользователь - обычный пользователь с нужной группой - при перемещении права копируются :(
            Ответить
            Аватар
            Александр
            11.08.2020 at 14:06

            Есть прогресс в вопросе, но не совсем такой, как хотелось бы:
            dos filemode = no - права при перемещении не наследуются и пользователи не могут изменять права на папки и файлы
            dos filemode = yes - права при перемещении наследуются и пользователи могут изменять права на папки и файлы (если есть права на изменение)


Может быть есть вариант наследовать права при перемещении и запретить изменять права?...
```

```text
    Здравствуйте!
    Очень странная проблема с Самбой, getacl показывает, что и владельцу и группе разрешено RWX на папку, в конфиге Самбы прописано create mask = 0770 directory mask = 0770, создаю в шаре папку, все нормально и у владельца и у группы все права, создаю файл, права только у владельца RWX, остальные --- подскажите куда рыть?

        Надо разбираться. Я что-то подобное встречал и решал, но подробности, к сожалению, не помню.
        Ответить
    Аватар
    Андрей
    21.05.2020 at 10:10

    Здравствуйте! Столкнулся с такой проблемой, все сделано по данной статье на CentOS 7, если прокинуть vpn, допустим из дома в офис, то права перестают корректно отрабатывать, тоесть у учеток которых на корневую папку должны быть только права на чтение почему то получают полный доступ и могут создавать удалять папки, даже те которые были созданы не ими. Как только появляешься в офисе, все права начинают отрабатывать корректно. В логах при этом видно, что тот кто подключается удаленно, самба его никак вообще не пытается зарегистрировать, выдает ошибку, но на сервер все равно пускает и дает полные права на все. Может кто-нибудь сталкивался и знает как помочь?
    Ответить
        Zerox
        Zerox
        21.05.2020 at 13:59

        Странная история. Права доступа хранятся в acl, списках контроля доступа к файлу. Они не зависят от способа подключения, по vpn или из офиса.
        Ответить
    Аватар
    Кирилл
    04.10.2019 at 12:38

    Не подключается к домену вообще пишет следующее:
    net ads join -U ivanov.k
    Enter ivanov.k's password:
    gse_get_client_auth_token: gss_init_sec_context failed with [Unspecified GSS failure. Minor code may provide more information: Message stream modified](2529638953)
    kinit succeeded but ads_sasl_spnego_gensec_bind(KRB5) failed for ldap/vs01.cloud.local with user[ivanov.k] realm[CLOUD.LOCAL]: The attempted logon is invalid. This is either due to a bad username or authentication information.
    Failed to join domain: failed to connect to AD: Invalid credentials
    Ответить
    Аватар
    Кирилл
    19.09.2019 at 13:11

    А что делать если лог самбы пишет ошибку по попытке входа через имя?
    [2019/09/19 12:35:39.650216, 1] ../source3/librpc/crypto/gse.c:658(gse_get_server_auth_token)
    gss_accept_sec_context failed with [Unspecified GSS failure. Minor code may provide more information: Request ticket server cifs/srv-fs@CLOUD.LOCAL not found in keytab (ticket kvno 2)]
    [2019/09/19 12:35:39.652622, 3] ../source3/smbd/server_exit.c:237(exit_server_common)
    Server exit (NT_STATUS_CONNECTION_RESET)

    Собственно вот эта ошибка
    Ответить
        Zerox
        Zerox
        19.09.2019 at 16:08

        По ошибке
        not found in keytab
        могу только предположить, что какие-то проблемы с керберосом.
        Ответить
    Аватар
    Sania.Nsk
    25.06.2019 at 11:34

    Отсутствие регистрации в DNS, возможно, связано с проблемой:
    https://bugzilla.altlinux.org/show_bug.cgi?id=35453

    На SAMBA 4.8.3-4.el7 + SSSD 1.16.2-13.el7_6.8 проблема воспроизводится.
    Ответить
    Аватар
    Дмитрий
    08.02.2019 at 08:39

    После wbinfo -t выходит
    checking the trust secret for domain -not available- via RPC calls failed
    failed to call wbcCheckTrustCredentials: WBC_ERR_NOT_IMPLEMENTED
    Не подскажете что может быть?
    Ответить
        Zerox
        Zerox
        08.02.2019 at 11:16

        Надо гуглить. С работой в домене очень много нюансов в настройке.
        Ответить
    Аватар
    Роман
    22.10.2018 at 13:59

    Добрый день, может натолкнете в каком направлении рыть. Есть файловый сервер на базе Centos 7 и контроллер домена на базе Win Ser 2008 R2, хотелось бы реализовать следующую концепцию. Допустим пользователь домена подключается к файловому серверу Centos 7 и у него создается домашняя папка по определенному сетевому пути с его именем из OU контроллера домена (в идеале еще и с лимитом на саму шару, а не на пользователя или группу).
    Так вот PAM и samba работают в связке и создают такую папку на файловом сервере, но с таким именем папки при котором пользователь авторизуется при входе в систему. т.е. берется его Логин. а я бы хотел что бы его папка была названа его атрибутами взятыми с виндовс сервера 2008 и на кириллице. Но как это сделать ума не приложу.
    Ответить
        Zerox
        Zerox
        22.10.2018 at 14:11

        Надо написать logon скрипт на powershell, а в нем уже настроить создание новой папки так, как хочется. Создавать и подключать папку именно logon скриптом. Я так делал в свое время.
        Ответить
    Аватар
    Nazip
    16.05.2018 at 03:32

    DNS update failed: NT_STATUS_INVALID_PARAMETER

    данная ошибка чаще всего проявляется если не заполнен параметр hosts по типу
    ip_адрес_сервера имя_компа.домен имя_компа
    Ответить
    Аватар
    Hrift
    19.02.2018 at 08:44

    столкнулся с интересным поведением сервера на которое позже нашел объяснение: если на шару заходить с виндовой машины по IP адресу сервера то не работает нифига. А вот если набрать имя сервера то начинает работать. Как позже выяснил Kerberos авторизация работает только при использовании доменных имен. Может поэтому у Вас не вышло с sssd?
    Ответить
        Zerox
        Zerox
        19.02.2018 at 09:29

        Эту тему я знаю, проверял. У меня по какой-то другой причине не работало. Может соберусь и еще как-нибудь проверю. Мне кажется просто звезды так совпали :) Иногда те же самые действия через некоторое время приводят к желаемому результату.
        Ответить
    Аватар
    Alex
    12.01.2018 at 16:08

    Спасибо очень позновательная статья.
    Ответить
    Аватар
    Al Key
    20.12.2017 at 22:55

    С этими настройками с официальной справки сразу заработало:
    https://access.redhat.com/articles/3023821
    [global]
    workgroup = EXAMPLE
    client signing = yes
    client use spnego = yes
    kerberos method = secrets and keytab
    log file = /var/log/samba/%m.log
    password server = AD.EXAMPLE.COM
    realm = EXAMPLE.COM
    security = ads

    winbind вообще не использовался, только sssd
    Ответить
    Аватар
    MupyMup
    13.12.2017 at 11:13

    Решение с realm и sssd нашлось тут: https://access.redhat.com/articles/3023821
    Конфиг smb.conf выглядит так:
    [global]
    realm = MY.TEST
    server string = Samba Server %v
    workgroup = MY
    log file = /var/log/samba/log.%m
    max log size = 50
    kerberos method = secrets and keytab # можно заменить на dedicated keytab
    security = ADS
    idmap config * : backend = tdb

    [secured]

    path = /samba/secured
    read only = No
    valid users = @linux_users@my.test # кавычки оказались не нужны, их выкинул testparm
    Ответить
    Аватар
    werter
    08.10.2017 at 16:00

    Доброе.

    Mikrotik - отл. выбор. Но не умеет, напр., nat fastpath, т.е. вся нагрузка ложиться на cpu уст-ва.
    Сравнивать Pfsense и МТ - это как сравнивать газель с карьерным самосвалом.

    Установить xen на mdadm ? Сперва разворачиваете тот же Дебиан на mdadm, а после - накатывайте xen. В чем вопрос-то ?
    Правда, он может развалиться. После очередного обновления xen.

    ПересмОтрите свое отношение к kvm )) ? Вот честно - ему от этого ни холодно, ни жарко.

    Proxmox разворачивается на zfs, среди преимуществ к-ой - сжатие, дедупликация, удобство в создание массивов любого уровня, возможность использования ssd в кач-ве кеша и COPY_ON_WRITE (ваши данные никогда не запишутся поврежденными, CRC вычисляется ДВУМЯ алгоритмами). Также мгновенный снепшоттинг и возможность откатиться к любой версии. И это не всё. Гуглите.
    Все это управляется с пом. БРАУЗЕРА, а не не пойми чего.

    http://wolandblog.com/601-zfs-novyj-vzglyad-na-fajlovye-sistemy/
    http://xgu.ru/wiki/ZFS

    P.s. Напомню. Pfsense - https://forum.pfsense.org/index.php?board=9.0
    Только не говорите снова, что вы его лет 8 назад пользовать пытались и он вам не понравился. Это не правда.
    Ответить
        Zerox
        Zerox
        08.10.2017 at 17:46

        Так чем инкрементно бэкапить KVM? Есть готовое решение? Под hyper-v, vmware и xenserver есть решения. Для kvm мне неизвестны.
        Ответить
    Аватар
    werter
    01.10.2017 at 14:17

    Добрый.
    Как у Вас дела с pfsense ? Начали внедрять ?

    P.s. Цитата:
    "Буду рад любым полезным замечаниям, исправлениям, советам по настройке файлового сервера samba. Я потратил значительное время, чтобы поделиться своими знаниями и опытом с остальными. Надеюсь, кто-то поделится чем-то полезным со мной. В том числе ради этого я и пишу статьи. Они расширяют мой кругозор и закрепляют полученные знания."

    Лукавите. Тот же Proxmox я Вам посоветовал, а то сидели бы в Xen-е до сих пор. Статьи по никсам подбрасывал. А Вы из скайпа за это удаляете ( Не хорошо.
    Ответить
        Zerox
        Zerox
        01.10.2017 at 16:59

        Если я слушаю советы, это не значит, что я их обязательно использую. В качестве маршрутизатора я предпочитаю mikrotik, а гипервизоры использую по ситуации. XenServer лично мне нравится больше, чем KVM. С ним меньше проблем во время эксплуатации. А точнее вообще нет. Минус только один - он с версии 7.1 перестал ставиться на mdadm. Если посоветуете бесплатный инструмент для инкрементных бэкапов виртуальных машин под kvm, возможно я пересмотрю свое отношение к нему. Пока же я таких не вижу, а для xenserver регулярно использую.
        Ответить
    Аватар
    Andrey
    28.09.2017 at 11:30

    Я ввел 3 файл сервера в домен на Дебиане, но там немного по другому, я полностью использую скрипт, нашедший в одной сборке Дебиана и немного его допилив под себя https://drive.google.com/open?id=0BzrWXN0Dsp4qUWxTY1UtdGFESVE, так вот там аутентификация через ПАМ, и я добавил на сервер скрипт который раз в 12 часов обновляет права доступа к шарам по наименованию присваивая UID и GID который почему то меняется время от времени, попутно после всего ставил на сервак webmin, через него шары добавлять и редактировать права просто.
    Ответить
        Zerox
        Zerox
        28.09.2017 at 12:17

        Скрипт мощный :)) Вот кто-то заморочился. Что за скрипт, который обновляет права? Хочу на него посмотреть. А что будет, если права изменятся в этом промежутке? Нужно будет руками скрипт запускать?

        Я так понимаю, вопрос, почему иногда меняются UID и GID тоже открытый. Если бы они не менялись по какой-то причине, то проблем бы практически не было.
        Ответить
            Аватар
            Andrey
            28.09.2017 at 16:54

            Суть такова на серваке есть шара /srv/buhi доступ нужен только группе "debet", шара /srv/konstr - "domain users", когда вдруг не понятно чего слетает UID GID, а так как Линукс присваивает права именно по ним, когда группам переопределяется GID, доступ на шаре становится в виде (root:10006), а не (root:debet) - доступ естественно отваливается. Банально баш скрипт:
            chown -R root:debet /srv/buhi
            chown -R root:"domain users" /srv/konstr
            и в крон его на запуск каждые 12 часов.

            З.Ы. А в скрипте там где вставка данных в файл xml при входе определенного пользователя, если он относится к данной группе монтируется папка с установкой прав на шару, а при выходе происходит размонтирование.
            Ответить
                Zerox
                Zerox
                28.09.2017 at 17:42

                Я понял. Это очень простой вариант, когда доступ у одной группы. У меня обычно глючат более масштабные сервера, где очень много различных прав. Мне иногда кажется, что чем больше шара, чем сложнее иерархия директорий и грууп, тем больше шанс, что что-то сглючит в правах.
                Ответить
                    Аватар
                    Андрей
                    28.09.2017 at 20:22

                    На до написать скрипт который читает конфиг самбы и отрабатывает блоки с шарами считывая путь и привилегию, выводя команду "човн" или "чмод" и так циклически.Вроде я встречал настраивали еще дополнительно с утилитой ACL, надо почитать про нее подробней. Жаль что самба еще не полностью может стать контроллером домена, надеюсь с новими версиями и возможностей станет больше
                    Ответить
                    Аватар
                    Андрей
                    28.09.2017 at 20:57

                    Может здесь ответ на проблемы https://wiki.samba.org/index.php/Idmap_config_ad
                    Ответить
    Аватар
    User
    28.09.2017 at 10:18

    с sssd долго прыгал, но настроил в итоге - делал samba контроллер AD, и файловый сервер в домене на этом контроллере, с корректными правами и пр. Там в итоге пришлось вручную корректировать sssd.conf, smb.conf, krb5.conf, и вводить в домен через adcli join, потому что realmd обладал какими-то багами. Настройки да, неочевидные, типа kerberos method и dedicated keytab file в smb.conf. Но работало, могу выложить конфиги.
    Ответить
        Zerox
        Zerox
        28.09.2017 at 12:13

        Я вообще не настраивал никогда и даже не планирую домен на самбе. Думаю, эти конфиги мне никак не помогут. Очень много нюансов в этих настройках, они очень неуниверсальны.
```













