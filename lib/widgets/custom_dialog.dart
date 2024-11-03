import 'package:flutter/material.dart';
import 'package:habbit_breaker/constants/color_constants.dart';

enum DialogType {
  confirmation,
  warning,
  info,
}

class CustomDialog {
  static Future<void> show(
    BuildContext context, {
    required String title,
    required Widget content,
    required DialogType dialogType,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    required String textConfirm,
    required String textCancel,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: dialogType == DialogType.info ||
                  dialogType == DialogType.warning
              ? [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onCancel?.call();
                        },
                        child: Text(textCancel),
                      ),
                    ],
                  ),
                ]
              : [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          onCancel?.call();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          textCancel,
                          style: const TextStyle(color: ColorConstants.danger),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onConfirm?.call();
                        },
                        child: Text(textConfirm),
                      ),
                    ],
                  ),
                ],
        );
      },
    );
  }
}
