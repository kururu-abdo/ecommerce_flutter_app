import 'package:flutter/material.dart';

class DialogBuilder{
  String? _title;
  String? _desc;
  late List<Widget> _actions;
DialogBuilder setTitle(String  title ){
  _title= title;
  return this;
}
DialogBuilder setDescription(String desc){
_desc = desc;
return this;
}
DialogBuilder setActions(List<Widget> actions) {
    _actions = actions;
    return this;
  }
 
Widget build(BuildContext  context){
  return
  
   AlertDialog(
    title: Text(_title!),
    content: Column(
      children: [

        Text(_desc!)
      ],
    ),
    actions: _actions,
  );
}
}