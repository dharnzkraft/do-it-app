import 'package:do_it_fixed_fixed/app-themes/MarkTextStyle.dart';
import 'package:do_it_fixed_fixed/app-themes/textStyle.dart';
import 'package:do_it_fixed_fixed/app-themes/theme.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final bool isMultiLine;
  final String? Function(String?)? validator;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.isMultiLine = false,
    this.validator,
    this.prefixIcon,
    this.suffixIcon, required String hint, required bool isMultiline,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: isMultiLine ? null : 1,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        hintStyle: MarkTextStyles.bodyRegular16.copyWith(
          color: Colors.black,
        ),
        focusedBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: AppTheme.primaryColor, width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}


class BorderedCustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final bool isMultiLine;
  final String? Function(String?)? validator;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const BorderedCustomInputField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.isMultiLine = false,
    this.validator,
    this.prefixIcon,
    this.suffixIcon, required String hint, required bool isMultiline, required bool obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: isMultiLine ? null : 1,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppTheme.grey, width: 1.5),
              borderRadius: BorderRadius.circular(8),
        ),
        hintStyle: SfProAppTextStyles.body14Bold.copyWith(
          color: Colors.black,
        ),
        focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppTheme.primaryColor, width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

class CustomTextArea extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final int minLines;
  final int maxLines;
  final String? Function(String?)? validator;

  const CustomTextArea({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.minLines = 3,
    this.maxLines = 5,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          validator: validator,
          minLines: minLines,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppTheme.primaryColor, width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),
      ],
    );
  }
}

