import 'package:flutter/material.dart';

Future<bool> showInstaCareConfirmationDialog({
  required BuildContext context,
  required String title,
  required String body,
  String confirmText = 'Yes',
  String cancelText = 'No',
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelText),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(confirmText),
        ),
      ],
    ),
  );

  return result ?? false;
}

