import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:mix/mix.dart';

class SmallButton extends StatelessWidget {
      final String text;
  final VoidCallback onPressed;
  final Color color;
   SmallButton({super.key, required this.text, required this.onPressed, required this.color});


final style = Style(
  $box.height(50),
  $box.width(100),
  $box.margin(10, 20),
  $box.color.blue(),
  $box.borderRadius(10),
  $box.border(
    color: Colors.black,
    width: 1,
    style: BorderStyle.solid,
  ),
);
  @override
  Widget build(BuildContext context) {
    return Box(
  style: style,
  child: Text(text),
);
  }
}