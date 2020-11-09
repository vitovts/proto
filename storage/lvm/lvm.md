#LVM

[Содержание](../readme.md)

```
LVM - это менеджер логических томов, позволяющий использовать разные области одного диска и/или оласти с разных дисков как один логический том
Реализовано с помощью Device mapper - таже с помощью ее работает RAID и dm-crypt
```

```
PV, Physical Volume   /dev/sda /dev/sdb1 /dev/sdc 
VG, Volume Group      vg_xx
LV, Logical Volume    lv_root (root) lv_var (var) lv_swap (swap)
FS, File System       ext4 reiserfs xfs
```

```
PE- Physical extent, физический экстент
LE - Logical extent, логический экстент
```


Плюсы
```
1.Логические тома LVM больше не привязаны к физизескому местоположению
2. Размер логических томов можно увеличивать прямо ня лету
3. Размонитованные тома можно уменьшить во время работы системы
4. Логические тома можно расположить на нескольких физических дисках
5. Делаются снапшоты файловой системы
```

Минусы
```
1. Уровень обстракции (виртуализации)
2. При выходе диска можно получить битые данные
3. Фрагментация данных
```

- PHYSICAL VOLUME

```

```

```
pvcreate /dev/sd[cb]
```

```
pvs
pvdisplay
```

- VOLUME GROUP

```
vgcreate --help
  vgcreate - Create a volume group

  vgcreate VG_new PV ...
        [ -A|--autobackup y|n ]
        [ -c|--clustered y|n ]
        [ -l|--maxlogicalvolumes Number ]
        [ -p|--maxphysicalvolumes Number ]
        [ -M|--metadatatype lvm2 ]
        [ -s|--physicalextentsize Size[m|UNIT] ]
        [ -f|--force ]
        [ -Z|--zero y|n ]
        [    --addtag Tag ]
        [    --alloc contiguous|cling|cling_by_tags|normal|anywhere|inherit ]
        [    --metadataprofile String ]
        [    --labelsector Number ]
        [    --metadatasize Size[m|UNIT] ]
        [    --pvmetadatacopies 0|1|2 ]
        [    --vgmetadatacopies all|unmanaged|Number ]
        [    --reportformat basic|json ]
        [    --dataalignment Size[k|UNIT] ]
        [    --dataalignmentoffset Size[k|UNIT] ]
        [    --shared ]
        [    --systemid String ]
        [    --locktype sanlock|dlm|none ]
        [ COMMON_OPTIONS ]

  Common options for lvm:
        [ -d|--debug ]
        [ -h|--help ]
        [ -q|--quiet ]
        [ -v|--verbose ]
        [ -y|--yes ]
        [ -t|--test ]
        [    --commandprofile String ]
        [    --config String ]
        [    --driverloaded y|n ]
        [    --nolocking ]
        [    --lockopt String ]
        [    --longhelp ]
        [    --profile String ]
        [    --version ]

  Use --longhelp to show all options and advanced commands. 
```

```
vgcreate sas /dev/sd[cb]
```

```
vgs
vgdisplay
```

- LOGICAL VOLUME

```
oot@pve5:~# lvcreate --help
  lvcreate - Create a logical volume

  Create an LV that returns VDO when used.
  lvcreate --type vdo -L|--size Size[m|UNIT] VG
        [ -l|--extents Number[PERCENT] ]
        [ -A|--autobackup y|n ]
        [ -a|--activate y|n|ay ]
        [ -C|--contiguous y|n ]
        [ -K|--ignoreactivationskip ]
        [ -j|--major Number ]
        [ -n|--name String ]
        [ -p|--permission rw|r ]
        [ -M|--persistent y|n ]
        [ -r|--readahead auto|none|Number ]
        [ -k|--setactivationskip y|n ]
        [ -W|--wipesignatures y|n ]
        [ -Z|--zero y|n ]
        [ -V|--virtualsize Size[m|UNIT] ]
        [ -i|--stripes Number ]
        [ -I|--stripesize Size[k|UNIT] ]
        [    --vdo ]
        [    --addtag Tag ]
        [    --alloc contiguous|cling|cling_by_tags|normal|anywhere|inherit ]
        [    --ignoremonitoring ]
        [    --metadataprofile String ]
        [    --minor Number ]
        [    --monitor y|n ]
        [    --nosync ]
        [    --noudevsync ]
        [    --reportformat basic|json ]
        [    --compression y|n ]
        [    --deduplication y|n ]
        [ COMMON_OPTIONS ]
        [ PV ... ]

  Create a linear LV.
  lvcreate -L|--size Size[m|UNIT] VG
        [ -l|--extents Number[PERCENT] ]
        [ -A|--autobackup y|n ]
        [ -a|--activate y|n|ay ]
        [ -C|--contiguous y|n ]
        [ -K|--ignoreactivationskip ]
        [ -j|--major Number ]
        [ -n|--name String ]
        [ -p|--permission rw|r ]
        [ -M|--persistent y|n ]
        [ -r|--readahead auto|none|Number ]
        [ -k|--setactivationskip y|n ]
        [ -W|--wipesignatures y|n ]
        [ -Z|--zero y|n ]
        [    --type linear ]
        [    --addtag Tag ]
        [    --alloc contiguous|cling|cling_by_tags|normal|anywhere|inherit ]
        [    --ignoremonitoring ]
        [    --metadataprofile String ]
        [    --minor Number ]
        [    --monitor y|n ]
        [    --nosync ]
        [    --noudevsync ]
        [    --reportformat basic|json ]
        [ COMMON_OPTIONS ]
        [ PV ... ]

  Create a striped LV (infers --type striped).
  lvcreate -i|--stripes Number -L|--size Size[m|UNIT] VG
        [ -l|--extents Number[PERCENT] ]
        [ -I|--stripesize Size[k|UNIT] ]
        [ -A|--autobackup y|n ]
        [ -a|--activate y|n|ay ]
        [ -C|--contiguous y|n ]
        [ -K|--ignoreactivationskip ]
        [ -j|--major Number ]
        [ -n|--name String ]
        [ -p|--permission rw|r ]
        [ -M|--persistent y|n ]
        [ -r|--readahead auto|none|Number ]
        [ -k|--setactivationskip y|n ]
        [ -W|--wipesignatures y|n ]
        [ -Z|--zero y|n ]
        [    --addtag Tag ]
        [    --alloc contiguous|cling|cling_by_tags|normal|anywhere|inherit ]
        [    --ignoremonitoring ]
        [    --metadataprofile String ]
        [    --minor Number ]
        [    --monitor y|n ]
        [    --nosync ]
        [    --noudevsync ]
        [    --reportformat basic|json ]
        [ COMMON_OPTIONS ]
        [ PV ... ]

  Create a raid1 or mirror LV (infers --type raid1|mirror).
  lvcreate -m|--mirrors Number -L|--size Size[m|UNIT] VG
        [ -l|--extents Number[PERCENT] ]
        [ -R|--regionsize Size[m|UNIT] ]
        [ -A|--autobackup y|n ]
        [ -a|--activate y|n|ay ]
        [ -C|--contiguous y|n ]
        [ -K|--ignoreactivationskip ]
        [ -j|--major Number ]
        [ -n|--name String ]
        [ -p|--permission rw|r ]
        [ -M|--persistent y|n ]
        [ -r|--readahead auto|none|Number ]
        [ -k|--setactivationskip y|n ]
        [ -W|--wipesignatures y|n ]
        [ -Z|--zero y|n ]
        [    --mirrorlog core|disk ]
        [    --minrecoveryrate Size[k|UNIT] ]
        [    --maxrecoveryrate Size[k|UNIT] ]
        [    --addtag Tag ]
        [    --alloc contiguous|cling|cling_by_tags|normal|anywhere|inherit ]
        [    --ignoremonitoring ]
        [    --metadataprofile String ]
        [    --minor Number ]
        [    --monitor y|n ]
        [    --nosync ]
        [    --noudevsync ]
        [    --reportformat basic|json ]
        [ COMMON_OPTIONS ]
        [ PV ... ]

  Create a raid LV (a specific raid level must be used, e.g. raid1).
  lvcreate --type raid -L|--size Size[m|UNIT] VG
        [ -l|--extents Number[PERCENT] ]
        [ -m|--mirrors Number ]
        [ -i|--stripes Number ]
        [ -I|--stripesize Size[k|UNIT] ]
        [ -R|--regionsize Size[m|UNIT] ]
        [ -A|--autobackup y|n ]
        [ -a|--activate y|n|ay ]
        [ -C|--contiguous y|n ]
        [ -K|--ignoreactivationskip ]
        [ -j|--major Number ]
        [ -n|--name String ]
        [ -p|--permission rw|r ]
        [ -M|--persistent y|n ]
        [ -r|--readahead auto|none|Number ]
        [ -k|--setactivationskip y|n ]
        [ -W|--wipesignatures y|n ]
        [ -Z|--zero y|n ]
        [    --minrecoveryrate Size[k|UNIT] ]
        [    --maxrecoveryrate Size[k|UNIT] ]
        [    --addtag Tag ]
        [    --alloc contiguous|cling|cling_by_tags|normal|anywhere|inherit ]
        [    --ignoremonitoring ]
        [    --metadataprofile String ]
        [    --minor Number ]
        [    --monitor y|n ]
        [    --nosync ]
        [    --noudevsync ]
        [    --reportformat basic|json ]
        [ COMMON_OPTIONS ]
        [ PV ... ]

  Create a raid10 LV.
  lvcreate -m|--mirrors Number -i|--stripes Number -L|--size Size[m|UNIT] VG
        [ -l|--extents Number[PERCENT] ]
        [ -I|--stripesize Size[k|UNIT] ]
        [ -R|--regionsize Size[m|UNIT] ]
        [ -A|--autobackup y|n ]
        [ -a|--activate y|n|ay ]
        [ -C|--contiguous y|n ]
        [ -K|--ignoreactivationskip ]
        [ -j|--major Number ]
        [ -n|--name String ]
        [ -p|--permission rw|r ]
        [ -M|--persistent y|n ]
        [ -r|--readahead auto|none|Number ]
        [ -k|--setactivationskip y|n ]
        [ -W|--wipesignatures y|n ]
        [ -Z|--zero y|n ]
        [    --minrecoveryrate Size[k|UNIT] ]
        [    --maxrecoveryrate Size[k|UNIT] ]
        [    --addtag Tag ]
        [    --alloc contiguous|cling|cling_by_tags|normal|anywhere|inherit ]
        [    --ignoremonitoring ]
        [    --metadataprofile String ]
        [    --minor Number ]
        [    --monitor y|n ]
        [    --nosync ]
        [    --noudevsync ]
        [    --reportformat basic|json ]
        [ COMMON_OPTIONS ]
        [ PV ... ]

  Create a COW snapshot LV of an origin LV.
  lvcreate -s|--snapshot -L|--size Size[m|UNIT] LV
        [ -l|--extents Number[PERCENT] ]
        [ -i|--stripes Number ]
        [ -I|--stripesize Size[k|UNIT] ]
        [ -c|--chunksize Size[k|UNIT] ]
        [ -A|--autobackup y|n ]
        [ -a|--activate y|n|ay ]
        [ -C|--contiguous y|n ]
        [ -K|--ignoreactivationskip ]
        [ -j|--major Number ]
        [ -n|--name String ]
        [ -p|--permission rw|r ]
        [ -M|--persistent y|n ]
        [ -r|--readahead auto|none|Number ]
        [ -k|--setactivationskip y|n ]
        [ -W|--wipesignatures y|n ]
        [ -Z|--zero y|n ]
        [    --type snapshot ]
        [    --addtag Tag ]
        [    --alloc contiguous|cling|cling_by_tags|normal|anywhere|inherit ]
        [    --ignoremonitoring ]
        [    --metadataprofile String ]
        [    --minor Number ]
        [    --monitor y|n ]
        [    --nosync ]
        [    --noudevsync ]
        [    --reportformat basic|json ]
        [ COMMON_OPTIONS ]
        [ PV ... ]

  Create a thin pool.
  lvcreate --type thin-pool -L|--size Size[m|UNIT] VG
        [ -l|--extents Number[PERCENT] ]
        [ -c|--chunksize Size[k|UNIT] ]
        [ -A|--autobackup y|n ]
        [ -a|--activate y|n|ay ]
        [ -C|--contiguous y|n ]
        [ -K|--ignoreactivationskip ]
        [ -j|--major Number ]
        [ -n|--name String ]
        [ -p|--permission rw|r ]
        [ -M|--persistent y|n ]
        [ -r|--readahead auto|none|Number ]
        [ -k|--setactivationskip y|n ]
        [ -W|--wipesignatures y|n ]
        [ -Z|--zero y|n ]
        [ -i|--stripes Number ]
        [ -I|--stripesize Size[k|UNIT] ]
        [    --thinpool LV_new ]
        [    --poolmetadatasize Size[m|UNIT] ]
        [    --poolmetadataspare y|n ]
        [    --discards passdown|nopassdown|ignore ]
        [    --errorwhenfull y|n ]
        [    --addtag Tag ]
        [    --alloc contiguous|cling|cling_by_tags|normal|anywhere|inherit ]
        [    --ignoremonitoring ]
        [    --metadataprofile String ]
        [    --minor Number ]
        [    --monitor y|n ]
        [    --nosync ]
        [    --noudevsync ]
        [    --reportformat basic|json ]
        [ COMMON_OPTIONS ]
        [ PV ... ]

  Create a cache pool.
  lvcreate --type cache-pool -L|--size Size[m|UNIT] VG
        [ -l|--extents Number[PERCENT] ]
        [ -H|--cache ]
        [ -c|--chunksize Size[k|UNIT] ]
        [ -A|--autobackup y|n ]
        [ -a|--activate y|n|ay ]
        [ -C|--contiguous y|n ]
        [ -K|--ignoreactivationskip ]
        [ -j|--major Number ]
        [ -n|--name String ]
        [ -p|--permission rw|r ]
        [ -M|--persistent y|n ]
        [ -r|--readahead auto|none|Number ]
        [ -k|--setactivationskip y|n ]
        [ -W|--wipesignatures y|n ]
        [ -Z|--zero y|n ]
        [    --poolmetadatasize Size[m|UNIT] ]
        [    --poolmetadataspare y|n ]
        [    --cachemode writethrough|writeback|passthrough ]
        [    --cachepolicy String ]
        [    --cachesettings String ]
        [    --cachemetadataformat auto|1|2 ]
        [    --addtag Tag ]
        [    --alloc contiguous|cling|cling_by_tags|normal|anywhere|inherit ]
        [    --ignoremonitoring ]
        [    --metadataprofile String ]
        [    --minor Number ]
        [    --monitor y|n ]
        [    --nosync ]
        [    --noudevsync ]
        [    --reportformat basic|json ]
        [ COMMON_OPTIONS ]
        [ PV ... ]

  Create a thin LV in a thin pool (infers --type thin).
  lvcreate -V|--virtualsize Size[m|UNIT] --thinpool LV_thinpool VG
        [ -T|--thin ]
        [ -A|--autobackup y|n ]
        [ -a|--activate y|n|ay ]
        [ -C|--contiguous y|n ]
        [ -K|--ignoreactivationskip ]
        [ -j|--major Number ]
        [ -n|--name String ]
        [ -p|--permission rw|r ]
        [ -M|--persistent y|n ]
        [ -r|--readahead auto|none|Number ]
        [ -k|--setactivationskip y|n ]
        [ -W|--wipesignatures y|n ]
        [ -Z|--zero y|n ]
        [    --type thin ]
        [    --discards passdown|nopassdown|ignore ]
        [    --errorwhenfull y|n ]
        [    --addtag Tag ]
        [    --alloc contiguous|cling|cling_by_tags|normal|anywhere|inherit ]
        [    --ignoremonitoring ]
        [    --metadataprofile String ]
        [    --minor Number ]
        [    --monitor y|n ]
        [    --nosync ]
        [    --noudevsync ]
        [    --reportformat basic|json ]
        [ COMMON_OPTIONS ]

  Create a thin LV that is a snapshot of an existing thin LV 
  (infers --type thin).
  lvcreate -s|--snapshot LV_thin
        [ -A|--autobackup y|n ]
        [ -a|--activate y|n|ay ]
        [ -C|--contiguous y|n ]
        [ -K|--ignoreactivationskip ]
        [ -j|--major Number ]
        [ -n|--name String ]
        [ -p|--permission rw|r ]
        [ -M|--persistent y|n ]
        [ -r|--readahead auto|none|Number ]
        [ -k|--setactivationskip y|n ]
        [ -W|--wipesignatures y|n ]
        [ -Z|--zero y|n ]
        [    --type thin ]
        [    --discards passdown|nopassdown|ignore ]
        [    --errorwhenfull y|n ]
        [    --addtag Tag ]
        [    --alloc contiguous|cling|cling_by_tags|normal|anywhere|inherit ]
        [    --ignoremonitoring ]
        [    --metadataprofile String ]
        [    --minor Number ]
        [    --monitor y|n ]
        [    --nosync ]
        [    --noudevsync ]
        [    --reportformat basic|json ]
        [ COMMON_OPTIONS ]

  Create a thin LV that is a snapshot of an external origin LV.
  lvcreate --type thin --thinpool LV_thinpool LV
        [ -T|--thin ]
        [ -c|--chunksize Size[k|UNIT] ]
        [ -A|--autobackup y|n ]
        [ -a|--activate y|n|ay ]
        [ -C|--contiguous y|n ]
        [ -K|--ignoreactivationskip ]
        [ -j|--major Number ]
        [ -n|--name String ]
        [ -p|--permission rw|r ]
        [ -M|--persistent y|n ]
        [ -r|--readahead auto|none|Number ]
        [ -k|--setactivationskip y|n ]
        [ -W|--wipesignatures y|n ]
        [ -Z|--zero y|n ]
        [    --poolmetadatasize Size[m|UNIT] ]
        [    --poolmetadataspare y|n ]
        [    --discards passdown|nopassdown|ignore ]
        [    --errorwhenfull y|n ]
        [    --addtag Tag ]
        [    --alloc contiguous|cling|cling_by_tags|normal|anywhere|inherit ]
        [    --ignoremonitoring ]
        [    --metadataprofile String ]
        [    --minor Number ]
        [    --monitor y|n ]
        [    --nosync ]
        [    --noudevsync ]
        [    --reportformat basic|json ]
        [ COMMON_OPTIONS ]

  Create a thin LV, first creating a thin pool for it, 
  where the new thin pool is named by the --thinpool arg.
  lvcreate --type thin -V|--virtualsize Size[m|UNIT] -L|--size Size[m|UNIT] --thinpool LV_new
        [ -l|--extents Number[PERCENT] ]
        [ -T|--thin ]
        [ -c|--chunksize Size[k|UNIT] ]
        [ -A|--autobackup y|n ]
        [ -a|--activate y|n|ay ]
        [ -C|--contiguous y|n ]
        [ -K|--ignoreactivationskip ]
        [ -j|--major Number ]
        [ -n|--name String ]
        [ -p|--permission rw|r ]
        [ -M|--persistent y|n ]
        [ -r|--readahead auto|none|Number ]
        [ -k|--setactivationskip y|n ]
        [ -W|--wipesignatures y|n ]
        [ -Z|--zero y|n ]
        [ -i|--stripes Number ]
        [ -I|--stripesize Size[k|UNIT] ]
        [    --poolmetadatasize Size[m|UNIT] ]
        [    --poolmetadataspare y|n ]
        [    --discards passdown|nopassdown|ignore ]
        [    --errorwhenfull y|n ]
        [    --addtag Tag ]
        [    --alloc contiguous|cling|cling_by_tags|normal|anywhere|inherit ]
        [    --ignoremonitoring ]
        [    --metadataprofile String ]
        [    --minor Number ]
        [    --monitor y|n ]
        [    --nosync ]
        [    --noudevsync ]
        [    --reportformat basic|json ]
        [ COMMON_OPTIONS ]
        [ PV ... ]

  Create a cache LV, first creating a new origin LV, 
  then combining it with the existing cache pool named 
  by the --cachepool arg.
  lvcreate --type cache -L|--size Size[m|UNIT] --cachepool LV_cachepool VG
        [ -l|--extents Number[PERCENT] ]
        [ -H|--cache ]
        [ -c|--chunksize Size[k|UNIT] ]
        [ -A|--autobackup y|n ]
        [ -a|--activate y|n|ay ]
        [ -C|--contiguous y|n ]
        [ -K|--ignoreactivationskip ]
        [ -j|--major Number ]
        [ -n|--name String ]
        [ -p|--permission rw|r ]
        [ -M|--persistent y|n ]
        [ -r|--readahead auto|none|Number ]
        [ -k|--setactivationskip y|n ]
        [ -W|--wipesignatures y|n ]
        [ -Z|--zero y|n ]
        [ -i|--stripes Number ]
        [ -I|--stripesize Size[k|UNIT] ]
        [    --poolmetadatasize Size[m|UNIT] ]
        [    --poolmetadataspare y|n ]
        [    --cachemode writethrough|writeback|passthrough ]
        [    --cachepolicy String ]
        [    --cachesettings String ]
        [    --cachemetadataformat auto|1|2 ]
        [    --addtag Tag ]
        [    --alloc contiguous|cling|cling_by_tags|normal|anywhere|inherit ]
        [    --ignoremonitoring ]
        [    --metadataprofile String ]
        [    --minor Number ]
        [    --monitor y|n ]
        [    --nosync ]
        [    --noudevsync ]
        [    --reportformat basic|json ]
        [ COMMON_OPTIONS ]
        [ PV ... ]

  Common options for command:

  Common options for lvm:
        [ -d|--debug ]
        [ -h|--help ]
        [ -q|--quiet ]
        [ -v|--verbose ]
        [ -y|--yes ]
        [ -t|--test ]
        [    --commandprofile String ]
        [    --config String ]
        [    --driverloaded y|n ]
        [    --nolocking ]
        [    --lockopt String ]
        [    --longhelp ]
        [    --profile String ]
        [    --version ]

  Use --longhelp to show all options and advanced commands. 
```

```
lvcreate -L100000 sas --name lv01
```

```
lvs
lvdisplay
```





```
mkfs.ext4 /dev/sas/lv01
mkdir /mnt/lv01
mount /dev/sas/lv01 /mnt/lv01
```
