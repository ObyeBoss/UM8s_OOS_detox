PARTOVER=true
PARTITIONS="/my_product /my_region /my_stock /odm /product /system_ext"
set_permissions() {
  [ -d "$MODPATH/system/bin" ] && set_perm_recursive $MODPATH/system/bin 0 0 0755 0755
  set_perm_recursive $MODPATH/tools 0 0 0755 0755
}
SKIPUNZIP=1
unzip -qjo "$ZIPFILE" 'common/functions.sh' -d $TMPDIR >&2
. $TMPDIR/functions.sh
