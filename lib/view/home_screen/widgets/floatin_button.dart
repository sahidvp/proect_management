 import 'package:flutter/material.dart';
import 'package:project_management_app/utils/theme/colors.dart';

FloatingActionButton floatinButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Appcolors.primary,
      onPressed: () => Navigator.pushNamed(context, "/form"),
      child: const Icon(Icons.add, color: Colors.white),
    );
  }