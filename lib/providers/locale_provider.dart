import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends StateNotifier {
  Locale _locale = const Locale('en');

  LocaleProvider():super(null){
      loadLocale();

  }

  Locale get locale => _locale;
// LocaleProvider(){
//   loadLocale();
// }
  void setLocale(Locale locale)async {
     final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
    _locale = locale;
  }
  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('languageCode') ?? 'en';
    _locale = Locale(languageCode);
  }
}
final localProvider = StateNotifierProvider<LocaleProvider,void>((ref) {
  return LocaleProvider();
});