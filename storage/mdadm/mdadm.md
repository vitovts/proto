#mdadm

[Содержание](../readme.md)

```
# apt install mdadm
```


```
# mdadm --examine /dev/sd[bc] 
```
```
mdadm: No md superblock detected on /dev/sdb.
mdadm: No md superblock detected on /dev/sdc. 
```

```
# cfdisk /dev/sdb 
```
```
# cfdisk /dev/sdc
```

```
# mdadm --create /dev/md0 --level=mirror --raid-devices=2 /ded/sd[bc]  
```
```
mdadm: You haven't given enough devices (real or missing) to create this array
```

```
# mdadm --create /dev/md0 --level=mirror --raid-devices=2 /dev/sd[bc]
```
```
mdadm: partition table exists on /dev/sdb
mdadm: partition table exists on /dev/sdb but will be lost or
       meaningless after creating array
mdadm: Note: this array has metadata at the start and
    may not be suitable as a boot device.  If you plan to
    store '/boot' on this device please ensure that
    your boot-loader understands md/v1.x metadata, or use
    --metadata=0.90
mdadm: partition table exists on /dev/sdc
mdadm: partition table exists on /dev/sdc but will be lost or
       meaningless after creating array
mdadm: largest drive (/dev/sdc) exceeds size (312439104K) by more than 1%
Continue creating array? 
Continue creating array? (y/n) y
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md0 started. 
```

```
# cat /proc/mdstat
Personalities : [raid1] 
md0 : active raid1 sdc[1] sdb[0]
      312439104 blocks super 1.2 [2/2] [UU]
      [>....................]  resync =  1.1% (3457088/312439104) finish=102.6min speed=50147K/sec
      bitmap: 3/3 pages [12KB], 65536KB chunk

unused devices: <none> 
```

```
# mdadm /dev/md0 --fail /dev/sdb
```
```
mdadm: set /dev/sdb faulty in /dev/md0
root@pve5:~# cat /proc/mdstat              
Personalities : [raid1] 
md0 : active raid1 sdc[1] sdb[0](F)
      312439104 blocks super 1.2 [2/1] [_U]
      bitmap: 3/3 pages [12KB], 65536KB chunk

unused devices: <none>
```

```
# mdadm /dev/md0 --remove /dev/sdb
```
```
mdadm: hot removed /dev/sdb from /dev/md0
root@pve5:~# cat /proc/mdstat                
Personalities : [raid1] 
md0 : active raid1 sdc[1]
      312439104 blocks super 1.2 [2/1] [_U]
      bitmap: 3/3 pages [12KB], 65536KB chunk

unused devices: <none>
```

```
# mdadm /dev/md0 --add /dev/sdb   
```
```
mdadm: re-added /dev/sdb
root@pve5:~# 
root@pve5:~# cat /proc/mdstat             
Personalities : [raid1] 
md0 : active raid1 sdb[0] sdc[1]
      312439104 blocks super 1.2 [2/1] [_U]
      [>....................]  recovery =  3.2% (10001152/312439104) finish=34.9min speed=144298K/sec
      bitmap: 3/3 pages [12KB], 65536KB chunk

unused devices: <none> 
```

```
# fdisk -l
```
```
Disk /dev/md0: 298 GiB, 319937642496 bytes, 624878208 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes 
```

```
# pvcreate /dev/md0 
```
```
  Physical volume "/dev/md0" successfully created. 
```

```
# vgcreate data /dev/md0 
```
```
Volume group "data" successfully created 
```

```
# lvcreate -l10000 --type thin-pool --poolmetadatasize=1M --name thin1 data 
```
```
  Rounding up size to full physical extent 4.00 MiB
  Thin pool volume with chunk size 640.00 KiB can address at most 158.12 TiB of data.
  WARNING: Pool zeroing and 640.00 KiB large chunk size slows down thin provisioning.
  WARNING: Consider disabling zeroing (-Zn) or using smaller chunk size (<512.00 KiB).
  Logical volume "thin1" created. 
```

```
# lvs
```
```
  LV    VG   Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  thin1 data twi-a-tz--  39.06g             0.00   11.13                           
  data  pve  twi-a-tz-- 140.45g             0.00   1.14                            
  root  pve  -wi-ao----  55.75g                                                    
  swap  pve  -wi-ao----   8.00g                                                    
```

```
# vgs
```

```
  VG   #PV #LV #SN Attr   VSize    VFree  
  data   1   1   0 wz--n-  297.96g 258.89g
  pve    1   3   0 wz--n- <223.07g <16.00g
```

```
# lvdisplay  
```

