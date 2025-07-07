#!/system/bin/sh


DEST="/my_product/vendor/etc"; SRC="multimedia_display_feature_config.xml"; mount -o bind "$MODPATH"/$SRC $DEST/$SRC
echo "0" > /sys/kernel/tracing/events/camera/cam_log_debug/enable; echo "0" > /sys/kernel/tracing/events/camera/cam_log_event/enable; echo "0" > /sys/kernel/tracing/events/camera/cam_tracing_mark_write/enable