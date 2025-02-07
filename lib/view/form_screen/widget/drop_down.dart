import 'package:flutter/material.dart';
import 'package:project_management_app/controller/form_controller.dart';

DropdownButtonFormField<String> statusDropDown(FormProvider provider) {
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
  }