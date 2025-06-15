#!/system/bin/sh

mf() {
  local sd="$1"; local td="$2"
  [ ! -d "$sd" ] && return
  find "$sd" -type f | while read -r f; do
    rp="${f#$sd}"; tf="$td$rp"; mount -o bind "$f" "$tf"
  done
}
mfo() {
  local s="$1"; local d="$2"; local wb="/dev/overlay_work"; local up="$wb/upper${d}"; local wo="$wb/work${d}"
  [ ! -d "$s" ] && return; [ -d "$d" ] || return; mkdir -p "$up" "$wo"; cp -a "$s/." "$up/"; mount -t overlay overlay -o lowerdir="$d",upperdir="$up",workdir="$wo" "$d"
}
for part in /data; do
  pn="${part#/}"; sd="$MODDIR/$pn"; td="/$pn"; mf "$sd" "$td"
done
for part2 in /my_product /my_region /my_stock; do
  pn="${part2#/}"; s="$MODPATH/$pn"; d="/$pn"; mfo "$s" "$d"
done
DEST="/my_product/vendor/etc"; SRC="multimedia_display_feature_config.xml"; mount -o bind "$MODPATH"/$SRC $DEST/$SRC
DEST2="/data/used_de/0/com.android.systemui/shared_prefs"; SRC2="oplus_media_controller_config_sp.xml"; mount -o bind "$MODPATH"/$SRC2 $DEST2/$SRC2
echo "0" > /sys/kernel/tracing/events/camera/cam_log_debug/enable; echo "0" > /sys/kernel/tracing/events/camera/cam_log_event/enable; echo "0" > /sys/kernel/tracing/events/camera/cam_tracing_mark_write/enable