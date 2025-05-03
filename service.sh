#!/system/bin/sh

resetprop -p --file "$MODPATH"/persist.prop

(
  while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 1
  done
  sleep 20
)&

rm -rf /data/tombstones/*
rm -rf /mnt/oplus/op2/media/log/*

dumpsys deviceidle whitelist -com.google.android.gms 2>/dev/null

sleep 40
(
su -c "pm disable com.google.android.gms/.common.stats.net.contentprovider.NetworkUsageContentProvider"
su -c "pm disable com.google.android.gms/.common.stats.GmsCoreStatsService"
su -c "pm disable com.google.android.gms/.common.stats.StatsUploadService"
su -c "pm disable com.google.android.gms/.analytics.AnalyticsTaskService"
su -c "pm disable com.google.android.gms/.analytics.internal.PlayLogReportingService"
su -c "pm disable com.google.android.gms/.analytics.AnalyticsReceiver"
su -c "pm disable com.google.android.gms/.analytics.service.AnalyticsService"
su -c "pm disable com.google.android.gms/.measurement.service.MeasurementBrokerService"
su -c "pm disable com.google.android.gms/.measurement.PackageMeasurementService"
su -c "pm disable com.google.android.gms/.measurement.PackageMeasurementReceiver"
su -c "pm disable com.google.android.gms/.measurement.PackageMeasurementTaskService"
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
su -c "pm disable com.google.android.gms/.feedback.OfflineReportSendTaskService"
su -c "pm disable com.google.android.gms/.feedback.FeedbackAsyncService"
su -c "pm disable com.google.android.gms/.nearby.exposurenotification.WakeUpService"
su -c "pm disable com.google.android.gms/.clearcut.debug.ClearcutDebugDumpService"
su -c "pm disable com.google.android.gms/.clearcut.uploader.QosUpdaterService"
su -c "pm disable com.google.android.gms/.stats.PlatformStatsCollectorService"
su -c "pm disable com.google.android.gms/.stats.eastworld.EastworldService"
su -c "pm disable com.google.android.gms/.westworld.WestworldService"
su -c "pm disable com.google.android.gms/.tron.CollectionService"
su -c "pm disable com.google.android.gms/.personalsafety.service.SndDetectionService"
)&