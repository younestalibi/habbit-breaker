import 'package:flutter/material.dart';
import 'package:habbit_breaker/constants/color_constants.dart';
import 'package:habbit_breaker/generated/l10n.dart';

enum DialogType {
  confirmation,
  warning,
  info,
}

class CustomDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final DialogType dialogType;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final String? textConfirm;
  final String? textCancel;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.dialogType,
    this.onConfirm,
    this.onCancel,
    this.textConfirm,
    this.textCancel,
  }) : super(key: key);

  static Future<void> show(
    BuildContext context, {
    required String title,
    required Widget content,
    required DialogType dialogType,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    String? textConfirm,
    String? textCancel,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
            title: title,
            content: content,
            dialogType: dialogType,
            onConfirm: onConfirm,
            onCancel: onCancel,
            textConfirm: textConfirm,
            textCancel: textCancel);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: dialogType == DialogType.info || dialogType == DialogType.warning
          ? [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onCancel?.call();
                },
                child: Text(S.of(context).ok),
              ),
            ]
          : [
              TextButton(
                onPressed: () {
                  onCancel?.call();
                  Navigator.of(context).pop();
                },
                child: Text(
                  textCancel ?? S.of(context).cancel,
                  style: const TextStyle(color: ColorConstants.danger),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirm?.call();
                },
                child: Text(textConfirm ?? S.of(context).confirm),
              ),
            ],
    );
  }
}
