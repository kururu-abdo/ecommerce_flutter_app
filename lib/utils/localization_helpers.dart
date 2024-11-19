import 'package:ecommerce_app/utils/app_localizations.dart';
import 'package:flutter/material.dart';

String? getTranslated(BuildContext context,String key){
 return  AppLocalizations.of(context).translate(key);
}
String? getCurrentLang(BuildContext context){
 return  AppLocalizations.of(context).locale.languageCode;
}