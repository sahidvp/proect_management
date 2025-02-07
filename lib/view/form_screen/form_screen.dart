import 'package:flutter/material.dart';
import 'package:project_management_app/controller/form_controller.dart';
import 'package:project_management_app/utils/theme/colors.dart';
import 'package:provider/provider.dart';
import 'package:project_management_app/view/form_screen/widget/custom_field.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create a project",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formProvider.formKey,
          child: Column(
            children: [
              CustomTextField(
                hinText: "Project Name",
                controller: formProvider.projectNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the project name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hinText: "Location",
                controller: formProvider.locationController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
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
              ),
              const SizedBox(height: 16),
              Consumer<FormProvider>(
                builder: (context, provider, child) {
                  return DropdownButtonFormField<String>(
                    value: provider.selectedStatus,
                    decoration: InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    items: provider.statusOptions.map((String status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                    onChanged: provider.updateStatus,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a status';
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
