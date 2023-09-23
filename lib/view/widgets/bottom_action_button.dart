import 'package:doctor_consultation_app/constants/app_constants.dart' as AppConstants;
import 'package:flutter/material.dart';

class BottomActionButton extends StatelessWidget {
  const BottomActionButton({
    super.key,
    this.onPressed,
    required this.buttonText,
    this.textButtonText,
    this.textButtonOnPressed,
  });
  final Function()? onPressed;
  final String buttonText;
  final String? textButtonText;
  final Function()? textButtonOnPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                color: Colors.black.withOpacity(0.4),
              )
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: AppConstants.primaryBlue,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor:
                      AppConstants.primaryBlue.withOpacity(0.5)),
              child: Text(
                buttonText,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            textButtonText != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextButton(
                        onPressed: textButtonOnPressed,
                        child: Text(
                          textButtonText!,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        )),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}