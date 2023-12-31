import 'package:flutter/material.dart';

Future<dynamic> showNoticeDialog({
  required BuildContext context,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
}
