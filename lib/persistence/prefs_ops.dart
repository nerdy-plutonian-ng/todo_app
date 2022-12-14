import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/app_enums.dart';

Future<bool> setAppTheme(AppThemes appTheme) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.setString('theme', appTheme.name);
}

Future<AppThemes> getAppTheme() async {
  final prefs = await SharedPreferences.getInstance();
  final theme = prefs.get('theme');
  return theme == null
      ? AppThemes.light
      : AppThemes.values.firstWhere((element) => element.name == theme);
}
