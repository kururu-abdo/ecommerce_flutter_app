import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteManager {
  

  static Route<dynamic> buildRoute(Widget widget,bool isIos){
    return isIos?
    CupertinoPageRoute(builder: (_)=>widget):
    MaterialPageRoute(builder: (_)=>widget);
    
  }
}