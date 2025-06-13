import 'package:do_it_fixed_fixed/main/widgets/input_field.dart';
import 'package:flutter/material.dart';

class CustomDatePickerField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final VoidCallback onTap;

  const CustomDatePickerField({
    super.key,
    required this.label,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: CustomInputField(
          label: label,
          controller: controller,
          hint: 'Select date', 
          isMultiline: false,
          prefixIcon: Icon(Icons.calendar_month),
        ),
      ),
    );
  }
}




