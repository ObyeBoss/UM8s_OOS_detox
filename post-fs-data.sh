#!/system/bin/sh

mf() {
  local sd="$1"; local td="$2"
  [ ! -d "$sd" ] && return
  find "$sd" -type f | while read -r f; do
    rp="${f#$sd}"; tf="$td$rp"; mount -o bind "$f" "$tf"
  done
}
for part in /data /my_product /my_region /my_stock; do
  pn="${part#/}"; sd="$MODDIR/$pn"; td="/$pn"; mf "$sd" "$td"
done
DEST="/my_product/vendor/etc"; SRC="multimedia_display_feature_config.xml"; mount -o bind "$MODPATH"/$SRC $DEST/$SRC
echo "0" > /sys/kernel/tracing/events/camera/cam_log_debug/enable; echo "0" > /sys/kernel/tracing/events/camera/cam_log_event/enable; echo "0" > /sys/kernel/tracing/events/camera/cam_tracing_mark_write/enable