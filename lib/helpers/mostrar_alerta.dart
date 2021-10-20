import 'package:flutter/material.dart';

mostrarAlerta(BuildContext context, String title, String subtitle) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(subtitle),
      actions: [
        MaterialButton(
          child: Text('OK'),
          elevation: 4,
          textColor: Colors.blue,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}
