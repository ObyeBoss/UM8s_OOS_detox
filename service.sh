#!/system/bin/sh

resetprop -p --file "$MODPATH"/persist.prop

(
  while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 1
  done

  SRC="$MODPATH/oplus_media_controller_config_sp.xml"
  DEST_DIR="/data/user_de/0/com.android.systemui/shared_prefs"
  DEST="$DEST_DIR/oplus_media_controller_config_sp.xml"
  [ ! -d "$DEST_DIR" ] && sleep 1
  cp "$SRC" "$DEST"
  EXISTING_FILE=$(find "$DEST_DIR" -type f | head -n 1)
  if [ -n "$EXISTING_FILE" ]; then
    OWNER=$(stat -c '%U:%G' "$EXISTING_FILE")
    CONTEXT=$(ls -Z "$EXISTING_FILE" | awk '{print $4}')
  else
    OWNER="u0_a230:u0_a230"
    CONTEXT="u:object_r:app_data_file:s0"
  fi
  chown "$OWNER" "$DEST"
  chmod 660 "$DEST"
  chcon "$CONTEXT" "$DEST"

  sleep 20
)&

rm -rf /data/tombstones/*
rm -rf /mnt/oplus/op2/media/log/*

sleep 65

cmd deviceidle whitelist -com.google.android.gms > /dev/null 2>&1
cmd deviceidle sys-whitelist -com.google.android.gms > /dev/null 2>&1
cmd deviceidle whitelist -com.google.android.gsf > /dev/null 2>&1
cmd deviceidle sys-whitelist -com.google.android.gsf > /dev/null 2>&1
#cmd deviceidle whitelist -com.android.emergency > /dev/null 2>&1
#cmd deviceidle sys-whitelist -com.android.emergency > /dev/null 2>&1
cmd deviceidle whitelist -com.heytap.browser > /dev/null 2>&1
cmd deviceidle sys-whitelist -com.heytap.browser > /dev/null 2>&1

cmd wifi force-low-latency-mode enabled
cmd wifi force-country-code enabled 00
echo "1" > /proc/sys/net/ipv4/tcp_window_scaling
echo "1" > /proc/sys/net/ipv4/tcp_low_latency

(
su -c "pm disable com.google.android.gms/.ads.AdRequestBrokerService"
su -c "pm disable com.google.android.gms/.ads.measurement.GmpConversionTrackingBrokerService"
su -c "pm disable com.google.android.gms/.ads.social.GcmSchedulerWakeupService"
su -c "pm disable com.google.android.gms/.ads.identifier.service.AdvertisingIdNotificationService"
su -c "pm disable com.google.android.gms/.ads.identifier.service.AdvertisingIdService"
su -c "pm disable com.google.android.gms/.ads.jams.NegotiationService"
su -c "pm disable com.google.android.gms/.ads.cache.CacheBrokerService"
su -c "pm disable com.google.android.gms/.adid.service.AdIdProviderService"
su -c "pm disable com.google.android.gms/.adsidentity.service.AdServicesExtDataStorageService"
su -c "pm disable com.google.android.gms/.adsidentity.settings.AdsIdentitySettingsActivity"
su -c "pm disable com.google.android.gms/.analytics.AnalyticsTaskService"
su -c "pm disable com.google.android.gms/.analytics.internal.PlayLogReportingService"
su -c "pm disable com.google.android.gms/.analytics.AnalyticsReceiver"
su -c "pm disable com.google.android.gms/.analytics.service.AnalyticsService"
su -c "pm disable com.google.android.gms/.common.stats.net.contentprovider.NetworkUsageContentProvider"
su -c "pm disable com.google.android.gms/.common.stats.GmsCoreStatsService"
su -c "pm disable com.google.android.gms/.common.stats.StatsUploadService"
su -c "pm disable com.google.android.gms/.stats.PlatformStatsCollectorService"
su -c "pm disable com.google.android.gms/.stats.eastworld.EastworldService"
su -c "pm disable com.google.android.gms/.westworld.WestworldService"
su -c "pm disable com.google.android.gms/.clearcut.debug.ClearcutDebugDumpService"
su -c "pm disable com.google.android.gms/.clearcut.uploader.QosUpdaterService"
su -c "pm disable com.google.android.gms/.measurement.service.MeasurementBrokerService"
su -c "pm disable com.google.android.gms/.measurement.PackageMeasurementService"
su -c "pm disable com.google.android.gms/.measurement.PackageMeasurementReceiver"
su -c "pm disable com.google.android.gms/.measurement.PackageMeasurementTaskService"
su -c "pm disable com.google.android.gms/.feedback.OfflineReportSendTaskService"
su -c "pm disable com.google.android.gms/.feedback.FeedbackAsyncService"
su -c "pm disable com.google.android.gms/.nearby.exposurenotification.WakeUpService"
su -c "pm disable com.google.android.gms/.personalsafety.service.SndDetectionService"
#
su -c "pm disable com.google.mainline.adservices"
su -c "pm disable com.google.android.adservices.api"
#su -c "pm disable com.android.emergency"
su -c "pm disable com.android.feedback"
su -c "pm disable com.google.android.apps.safetyhub"
su -c "pm disable com.oplus.olc"
su -c "pm disable com.oplus.logkit"
su -c "pm disable com.oplus.engineernetwork"
su -c "pm disable com.oplus.onetrace"

# disable & re-enable velvet to fully get rid of swipe left for launcher newsfeed
sleep 10
su -c "pm disable com.google.android.googlequicksearchbox"
sleep 5
su -c "pm enable com.google.android.googlequicksearchbox"
)&