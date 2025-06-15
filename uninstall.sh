#!/system/bin/sh
rm -rf /data/property/*
if [ -f $INFO ]; then
  while read LINE; do
    if [ "$(echo -n $LINE | tail -c 1)" == "~" ]; then
      continue
    elif [ -f "$LINE~" ]; then
      mv -f $LINE~ $LINE
    else
      rm -f $LINE
      while true; do
        LINE=$(dirname $LINE)
        [ "$(ls -A $LINE 2>/dev/null)" ] && break 1 || rm -rf $LINE
      done
    fi
  done < $INFO
  rm -f $INFO
fi
for pkg in com.google.android.gms/.ads.AdRequestBrokerService com.google.android.gms/.ads.measurement.GmpConversionTrackingBrokerService com.google.android.gms/.ads.social.GcmSchedulerWakeupService com.google.android.gms/.ads.identifier.service.AdvertisingIdNotificationService com.google.android.gms/.ads.identifier.service.AdvertisingIdService com.google.android.gms/.ads.jams.NegotiationService com.google.android.gms/.ads.cache.CacheBrokerService com.google.android.gms/.adid.service.AdIdProviderService com.google.android.gms/.adsidentity.service.AdServicesExtDataStorageService com.google.android.gms/.adsidentity.settings.AdsIdentitySettingsActivity com.google.android.gms/.analytics.AnalyticsTaskService com.google.android.gms/.analytics.internal.PlayLogReportingService com.google.android.gms/.analytics.AnalyticsReceiver com.google.android.gms/.analytics.service.AnalyticsService com.google.android.gms/.common.stats.net.contentprovider.NetworkUsageContentProvider com.google.android.gms/.common.stats.GmsCoreStatsService com.google.android.gms/.common.stats.StatsUploadService com.google.android.gms/.stats.PlatformStatsCollectorService com.google.android.gms/.stats.eastworld.EastworldService com.google.android.gms/.westworld.WestworldService com.google.android.gms/.clearcut.debug.ClearcutDebugDumpService com.google.android.gms/.clearcut.uploader.QosUpdaterService com.google.android.gms/.measurement.service.MeasurementBrokerService com.google.android.gms/.measurement.PackageMeasurementService com.google.android.gms/.measurement.PackageMeasurementReceiver com.google.android.gms/.measurement.PackageMeasurementTaskService com.google.android.gms/.feedback.OfflineReportSendTaskService com.google.android.gms/.feedback.FeedbackAsyncService com.google.android.gms/.nearby.exposurenotification.WakeUpService com.google.android.gms/.personalsafety.service.SndDetectionService com.oplus.olc com.oplus.logkit com.oplus.engineernetwork com.oplus.onetrace com.oplus.postmanservice com.oplus.qualityprotect com.oplus.healthservice com.oplus.crashbox com.oplus.locationproxy com.oplus.statistics.rom com.oplus.metis com.oplus.lfeh com.oplus.vdc com.heytap.htms com.heytap.mcs com.heytap.pictorial; do
  su -c "pm enable $pkg" >/dev/null 2>&1
done
rm "$0"


