import 'package:eventhub/colors/colors.dart';
import 'package:flutter/material.dart';

class CustomInputForm extends StatelessWidget {
  final TextEditingController? controller;
  final IconData icon;
  final String label;
  final String hint;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final VoidCallback? onTap;
  final bool? readOnly;
  final String? Function(String?)? validator;
  const CustomInputForm({
    super.key,
    required this.icon,
    required this.label,
    required this.hint,
    this.obscureText,
    this.keyboardType,
    this.maxLines,
    this.onTap,
    this.readOnly,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: TextFormField(
        controller: controller,
        readOnly: readOnly ?? false,
        onTap: onTap,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: Colors.black),
        maxLines: maxLines ?? 1,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType ?? TextInputType.text,
        cursorColor: Colors.black,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: kPrimary,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.black,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }
}
