import 'package:flutter/material.dart';

Future customDialog(
  context, {
  String? title,
  String? content,
  List<Widget>? actions,
  bool isbarrierDismissible = false,
}) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Theme.of(context).primaryColorLight,
      actions: actions,
      titlePadding: EdgeInsets.zero,
      title: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(4),
          ),
        ),
        child: Text(
          title??'',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
      content: Text(
        content??'',
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      ),
    ),
    barrierDismissible: isbarrierDismissible,
  );
}
