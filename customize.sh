PARTOVER=true
PARTITIONS="/my_product /my_region /my_stock /odm /product /system_ext"
set_permissions() {
  [ -d "$MODPATH/system/bin" ] && set_perm_recursive $MODPATH/system/bin 0 0 0755 0755
  set_perm_recursive $MODPATH/tools 0 0 0755 0755
  set_perm_recursive $MODPATH/data 1000 1000 0400 u:object_r:system_data_root_file:s0
  set_perm_recursive $MODPATH/data/oplus 1000 1000 0775 u:object_r:system_data_file:s0
  set_perm_recursive $MODPATH/data/oplus/os 1000 1000 0777 u:object_r:os_data_file:s0
  set_perm_recursive $MODPATH/data/oplus/os/battery 1000 1000 0700 u:object_r:os_data_file:s0
  set_perm $MODPATH/data/oplus/os/battery/doze_wl_local.xml 1000 1000 0600 u:object_r:os_data_file:s0
}
SKIPUNZIP=1
unzip -qjo "$ZIPFILE" 'common/functions.sh' -d $TMPDIR >&2
. $TMPDIR/functions.sh
