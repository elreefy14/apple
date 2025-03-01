import 'package:flutter/material.dart';
import 'package:masalriyadh/core/constants/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    required this.controller,
    this.icon,
    this.border,
    this.noValidator = false,
    this.maxLines,
    this.isReadOnly = false,
    this.validator,
    this.obscureText,
    this.keyboardType,
    this.suffixIcon,
  });

  final String label;
  final TextEditingController controller;
  final IconData? icon;
  final Widget? suffixIcon;
  final OutlineInputBorder? border;
  final bool noValidator;
  final int? maxLines;
  final bool? obscureText;
  final bool isReadOnly;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isReadOnly,
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        label: Text(label),
        labelStyle: TextStyle(color: Colors.black54),
        prefixIcon: Icon(
          icon,
          color: AppColors.primaryColor,
        ),
        border: buildOutlineInputBorder(),
        enabledBorder: border ?? buildOutlineInputBorder(),
        focusedBorder: border ?? buildOutlineInputBorder(),
        disabledBorder: border ?? buildOutlineInputBorder(),
      ),
      validator: validator ??
          (value) {
            if (noValidator) {
              return null;
            } else if (value == null || value.isEmpty) {
              return 'ارجو ادخال $label';
            }
            return null;
          },
    );
  }

  OutlineInputBorder buildOutlineInputBorder() => OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
      );
}
