import 'package:do_it_fixed_fixed/app-themes/MarkTextStyle.dart';
import 'package:do_it_fixed_fixed/app-themes/theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.label, required this.onPressed, required String text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor:  MaterialStateProperty.all(AppTheme.primaryColor),
          shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), 
          ),
    ),
        ),
        child: Text(
          label,
          style: MarkTextStyles.bodyRegular16.copyWith(
            color: AppTheme.accentColor
          )
        ),
      ),
    );
  }
}

class ICustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const ICustomButton({super.key, required this.label, required this.onPressed, required String text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
