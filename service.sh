#!/system/bin/sh
resetprop -p --delete persist.vendor.ims.disableDebugLogs; resetprop -p --delete persist.vendor.ims.disableIMSLogs; resetprop -p --delete persist.vendor.ims.disableQXDMLogs; resetprop -p --file "$MODPATH"/persist.prop
(
  while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 1
  done
  SRC="$MODPATH/oplus_media_controller_config_sp.xml"; DEST_DIR="/data/user_de/0/com.android.systemui/shared_prefs"; DEST="$DEST_DIR/oplus_media_controller_config_sp.xml"
  [ ! -d "$DEST_DIR" ] && sleep 1
  cp "$SRC" "$DEST"; EXISTING_FILE=$(find "$DEST_DIR" -type f | head -n 1)
  if [ -n "$EXISTING_FILE" ]; then
    OWNER=$(stat -c '%U:%G' "$EXISTING_FILE"); CONTEXT=$(ls -Z "$EXISTING_FILE" | awk '{print $4}')
  else
    OWNER="u0_a230:u0_a230"; CONTEXT="u:object_r:app_data_file:s0"
  fi
  chown "$OWNER" "$DEST"; chmod 660 "$DEST"; chcon "$CONTEXT" "$DEST"
)&
sleep 40; rm -rf /data/tombstones/*; rm -rf /mnt/oplus/op2/media/log/*; cmd wifi force-country-code enabled 00; cmd wifi set-verbose-logging disabled; echo "1" > /proc/sys/net/ipv4/tcp_window_scaling; echo "900" > /proc/sys/net/ipv4/tcp_max_reordering; echo "bbr" > /proc/sys/net/ipv4/tcp_congestion_control; echo "0" > /proc/sys/net/ipv4/tcp_slow_start_after_idle; echo "0" > /proc/sys/net/ipv4/tcp_no_metrics_save
(
  pm list packages | sed 's/package://' | grep -v -E '^(vendor\.qti|com\.qti)\.' | while read -r pkg; do
    su -c "pm disable $pkg/.service.ReceiverService" >/dev/null 2>&1
  done
  for pkg in com.oplus.olc com.oplus.logkit com.oplus.engineernetwork com.oplus.onetrace com.oplus.postmanservice com.oplus.qualityprotect com.oplus.healthservice com.oplus.crashbox com.oplus.locationproxy com.oplus.lfeh com.heytap.htms com.heytap.mcs com.heytap.pictorial com.oplus.statistics.rom com.oplus.metis com.oplus.vdc; do
    su -c "pm disable $pkg"
  done
  sleep 10; su -c "pm disable com.google.android.googlequicksearchbox"; sleep 5; su -c "pm enable com.google.android.googlequicksearchbox"
  for srv in ads.AdRequestBrokerService ads.measurement.GmpConversionTrackingBrokerService ads.social.GcmSchedulerWakeupService ads.identifier.service.AdvertisingIdNotificationService ads.identifier.service.AdvertisingIdService .ads.jams.NegotiationService ads.cache.CacheBrokerService adid.service.AdIdProviderService adsidentity.service.AdServicesExtDataStorageService analytics.AnalyticsTaskService analytics.internal.PlayLogReportingService analytics.AnalyticsReceiver analytics.service.AnalyticsService common.stats.net.contentprovider.NetworkUsageContentProvider common.stats.GmsCoreStatsService common.stats.StatsuploadService stats.PlatformStatsCollectorService stats.eastworld.EastworldService westworld.WestworldService clearcut.debug.ClearcutDebugDumpService clearcut.uploader.QosupdaterService measurement.service.MeasurementBrokerService measurement.PackageMeasurementService measurement.PackageMeasurementReceiver measurement.PackageMeasurementTaskService feedback.OfflineReportSendTaskService feedback.FeedbackAsyncService nearby.exposurenotification.WakeUpService personalsafety.service.SndDetectionService; do
    su -c "pm disable com.google.android.gms/.$srv" >/dev/null 2>&1
  done
  for proc in tcpdump tcpdump_odm cnss_cli cnss_diag cnss-daemon; do
    if pgrep -f "$proc" > /dev/null; then
      su -c killall -q "$proc"; sleep 1; [ "$(pgrep -f "$proc")" ] && su -c killall -q -9 "$proc"
    fi
  done
  sleep 5
  for pkg in com.google.android.gms com.google.android.gsf; do
    cmd deviceidle whitelist -$pkg >/dev/null 2>&1; cmd deviceidle sys-whitelist -$pkg >/dev/null 2>&1
  done
)&