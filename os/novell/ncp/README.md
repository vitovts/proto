NCP (NetWare Core Protocol)

http://ru.wikipedia.org/wiki/NetWare_Core_Protocol

```text
NetWare Core Protocol (NCP) — это сетевой протокол, который используется в некоторых продуктах от Novell, 
является надстройкой над протоколом IPX или TCP/IP и используется для организации обмена между рабочей 
станцией и файловым сервером. В основном NCP связан и используется в операционной системе NetWare, 
но его части были реализованы на другие платформы, такие как Linux, Windows NT и Unix.
```

Описание
```text
Протокол используется для доступа к файлам, службе печати, службе каталога, синхронизации часов, обмену сообщениями, 
удаленного выполнения команд и другим функциям сетевых услуг для организации обмена между рабочей станцией и файловым сервером. 
Novell eDirectory использует NCP для синхронизации изменений данных между серверами в дереве службы каталогов.
```

Принцип работы
```text
Протокол NCP реализован в NetWare 3.х на системном уровне. 
В NetWare 4.х предлагается API-интерфейс NCP Extension для обращения к протоколу NCP из прикладных программ на рабочих станциях
и из разрабатываемых NLM-модулей. Для обмена данными между программами по протоколу NCP используются пакеты IPX с номером сокета 
0х0451 и типом пакета 17.

Связь между рабочей станцией и файловым сервером, которые используют API-интерфейс к протоколу NCP, обычно организуется по следующей схеме:
1. NLM-модуль регистрирует какую-либо свою функцию как расширение NCP;
2. Программа на рабочей станции или файловом сервере связывается с NetWare и получает требуемый идентификатор расширения NCP;
3. Программа на рабочей станции или файловом сервере использует зарегистрированную функцию NLM-модуля как удалённую процедуру, 
передавая ей исходные данные и получая результаты обработки.
```

Configure

List connection
```text
ncpcon connection list
```

create volume
```text
mx1:/opt/novell # ncpcon create volume gw /opt/novell/groupwise
... Executing " create volume gw /opt/novell/groupwise"
Volume GW has been created.
... completed OK [elapsed time = 53 msecs 54 usecs]
```

delete volume
<code>
mx1:/srv/www/novell/clients # ncpcon dismount volume gw1 
... Executing " dismount volume gw1"
The following volume[s] were dismounted:
  GW1
1 volume[s] were dismounted.
... completed OK [elapsed time = 11 msecs 665 usecs]
</code>

Mount

ncpmount
```text
mount.ncp -S 417nlw1 -A 417lnw1 -V GW -U admin.grt -m -C -P MaximusM1 /opt/novell/groupwise/16417


-S server the name of the fileserver to mount.

–U user_name the NetWare user ID to use when logging in to the fileserver.

–P password the password to use for the NetWare login.

–n This option must be used for NetWare logins that don't have a password associated with them.

–C This argument disables automatic conversion of passwords to uppercase.

–c client_name this option allows you to specify who owns the connection to the fileserver. 
This is useful for NetWare printing, which we will discuss in more detail later.

–u uidthe Linux user ID that should be shown as the owner of files in the mounted directory. 
If this is not specified, it defaults to the user ID of the user who invokes the ncpmount command.

–g gid the Linux group ID that should be shown as the owner of files in the mounted directory. 
If this is not specified, it will default to the group ID of the user who invokes the ncpmount command.

–f file_mode this option allows you to specify the file mode (permissions) that files in the mounted directory should have. 
The value should be specified in octal, e.g., 0664. The permissions that you will actually have are the file mode permissions
specified with this option masked with the permissions that your NetWare login ID has for the files on the fileserver. 
You must have rights on the server and rights specified by this option in order to access a file. 
The default value is derived from the current umask.

–d dir_mode this option allows you to specify the directory permissions in the mounted directory. 
It behaves in the same way as the –f option, except that the default permissions are derived from the current umask. 
Execute permissions are granted where read access is granted.

-V volume	
This option allows you to specify the name of a single NetWare volume to mount under the mount point, rather than mounting all 
volumes of the target server. This option is necessary if you wish to re-export a mounted NetWare volume using NFS.

–t time_out	
This option allows you to specify the time that the NCPFS client will wait for a response from a server. The default value is 60mS 
and the timeout is specified in hundredths of a second. If you experience any stability problems with NCP mounts, 
you should try increasing this value.

–r retry_count	
The NCP client code attempts to resend datagrams to the server a number of times before deciding the connection is dead. 
This option allows you to change the retry count from the default of 5.
```

