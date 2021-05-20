import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Future<void> setCrashUser(String name) async {
  await FirebaseCrashlytics.instance.setUserIdentifier(name);
}

Future<void> customCrashLog(String log) async {
  await FirebaseCrashlytics.instance.log(log);
}

void crashApp() {
  FirebaseCrashlytics.instance.crash();
}

void disableCrashlytics() {
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
}

void enableCrashlytics() {
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
}
