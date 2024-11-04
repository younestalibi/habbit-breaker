import 'package:flutter/material.dart';
import 'package:habbit_breaker/constants/color_constants.dart';
import 'package:habbit_breaker/generated/l10n.dart';
import 'package:habbit_breaker/widgets/custom_elevated_button.dart';

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
    String? textConfirm,
    String? textCancel,
  }) {
    textCancel = (textCancel != null && textCancel.isNotEmpty)
        ? textCancel
        : S.of(context).cancel;
    textConfirm = (textConfirm != null && textConfirm.isNotEmpty)
        ? textConfirm
        : S.of(context).confirm;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: Text(title, textAlign: TextAlign.center),
          content: Expanded(child: content),
          actions:
              dialogType == DialogType.info || dialogType == DialogType.warning
                  ? [
                      CustomElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onCancel?.call();
                        },
                        text: textConfirm!,
                        backgroundColor: ColorConstants.primary,
                        color: ColorConstants.white,
                      ),
                    ]
                  : [
                      TextButton(
                        onPressed: () {
                          onCancel?.call();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          textCancel!,
                          style: const TextStyle(color: ColorConstants.danger),
                        ),
                      ),
                      CustomElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onConfirm?.call();
                        },
                        text: textConfirm!,
                        backgroundColor: ColorConstants.primary,
                        color: ColorConstants.white,
                      ),
                    ],
        );
      },
    );
  }
}
