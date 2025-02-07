import 'package:flutter/material.dart';
import 'package:project_management_app/controller/form_controller.dart';
import 'package:project_management_app/view/form_screen/widget/custom_field.dart';

Row projecrDate(FormProvider formProvider, BuildContext context) {
    return Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hinText: "Start Date",
                    controller: formProvider.startDateController,
                    readOnly: true,
                    onTap: () => formProvider.selectDate(
                        context, formProvider.startDateController),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a start date';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomTextField(
                    hinText: "End Date",
                    controller: formProvider.endDateController,
                    readOnly: true,
                    onTap: () => formProvider.selectDate(
                        context, formProvider.endDateController),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select an end date';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            );
  }