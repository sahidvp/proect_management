import 'package:flutter/material.dart';
import 'package:project_management_app/utils/theme/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hinText,
    this.controller,
    this.readOnly = false,
    this.onTap,
    this.validator,
  });

  final String hinText;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Appcolors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          hintStyle: TextStyle(
            color: Appcolors.grey.withValues(alpha: 0.4),
          ),
          enabled: true,
          hintText: hinText,
          border: InputBorder.none,
          suffixIcon: onTap != null
              ? IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: onTap,
                )
              : null,
        ),
        validator: validator,
      ),
    );
  }
}
