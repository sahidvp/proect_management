 import 'package:flutter/material.dart';
import 'package:project_management_app/controller/form_controller.dart';
import 'package:project_management_app/utils/theme/colors.dart';

SizedBox sumitButton(BuildContext context, FormProvider formProvider) {
    return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolors.primary,
                      shape: RoundedRectangleBorder()),
                  onPressed: () => formProvider.submitForm(context),
                  child: Text(
                    "Submit",
                    style:
                        TextStyle(fontSize: 12, color: Appcolors.background),
                  )),
            );
  }