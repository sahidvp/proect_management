import 'package:flutter/material.dart';
import 'package:project_management_app/controller/form_controller.dart';
import 'package:project_management_app/view/form_screen/widget/drop_down.dart';
import 'package:project_management_app/view/form_screen/widget/project_date.dart';
import 'package:project_management_app/view/form_screen/widget/submit_button.dart';
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
              projecrDate(formProvider, context),
              const SizedBox(height: 16),
              Consumer<FormProvider>(
                builder: (context, provider, child) {
                  return statusDropDown(provider);
                },
              ),
              const SizedBox(height: 24),
              sumitButton(context, formProvider)
            ],
          ),
        ),
      ),
    );
  }

 

  

  
}
