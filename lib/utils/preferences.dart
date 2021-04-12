import 'package:shared_preferences/shared_preferences.dart';

void setDefaultPreferences(prefs) {
  prefs.setBool('initialRun', true);
  prefs.setBool('isLogged', false);
  print("Setted");
  print(prefs.getBool('initialRun'));
}