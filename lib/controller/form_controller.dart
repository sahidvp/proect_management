// import 'package:flutter/material.dart';

// class FormProvider extends ChangeNotifier {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   final TextEditingController projectNameController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   final TextEditingController startDateController = TextEditingController();
//   final TextEditingController endDateController = TextEditingController();

//   String? selectedStatus;
//   final List<String> statusOptions = ['Ongoing', 'Completed', 'Pending'];

//   // List to store project details
//   final List<Map<String, String>> projects = [];

//   int? editingIndex; // Track the project being edited

//   void selectDate(
//       BuildContext context, TextEditingController controller) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       controller.text = "${picked.toLocal()}".split(' ')[0];
//       notifyListeners();
//     }
//   }

//   void updateStatus(String? status) {
//     selectedStatus = status;
//     notifyListeners();
//   }

//   // Submit new project or update an existing one
//   void submitForm(BuildContext context) {
//     if (formKey.currentState!.validate()) {
//       if (editingIndex != null) {
//         // Update existing project
//         projects[editingIndex!] = {
//           "name": projectNameController.text,
//           "location": locationController.text,
//           "startDate": startDateController.text,
//           "endDate": endDateController.text,
//           "status": selectedStatus ?? "Ongoing",
//         };
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Project updated successfully!')),
//         );
//         editingIndex = null; // Reset index after update
//       } else {
//         // Add new project
//         projects.add({
//           "name": projectNameController.text,
//           "location": locationController.text,
//           "startDate": startDateController.text,
//           "endDate": endDateController.text,
//           "status": selectedStatus ?? "Ongoing",
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Project added successfully!')),
//         );
//       }

//       notifyListeners();
//       _clearFields(); // Clear form fields after submission
//       Navigator.pop(context); // Go back to HomeScreen
//     }
//   }

//   // Load project details for editing
//   void editProject(int index, BuildContext context) {
//     final project = projects[index];

//     projectNameController.text = project["name"]!;
//     locationController.text = project["location"]!;
//     startDateController.text = project["startDate"]!;
//     endDateController.text = project["endDate"]!;
//     selectedStatus = project["status"]!;
//     editingIndex = index;

//     notifyListeners();
//     Navigator.pushNamed(context, "/form");
//   }

//   // Delete project
//   void deleteProject(int index) {
//     projects.removeAt(index);
//     notifyListeners();
//   }

//   // Clear form fields
//   void _clearFields() {
//     projectNameController.clear();
//     locationController.clear();
//     startDateController.clear();
//     endDateController.clear();
//     selectedStatus = null;
//     editingIndex = null;
//   }
// }

import 'package:flutter/material.dart';

import 'package:project_management_app/model/project_model.dart';
import 'package:project_management_app/utils/data_base/data_base.dart';

class FormProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  String? selectedStatus;
  final List<String> statusOptions = ['Ongoing', 'Completed', 'Pending'];

  // List to store project details (will be loaded from database)
  List<ProjectModel> projects = [];

  int? editingIndex; // Track the project being edited

  FormProvider() {
    fetchProjects(); // Load projects from database on initialization
  }

  void selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.text = "${picked.toLocal()}".split(' ')[0];
      notifyListeners();
    }
  }

  void updateStatus(String? status) {
    selectedStatus = status;
    notifyListeners();
  }

  // Submit new project or update an existing one
  Future<void> submitForm(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final project = ProjectModel(
        id: editingIndex, // If editingIndex is null, it's a new project
        projectName: projectNameController.text,
        location: locationController.text,
        startDate: startDateController.text,
        endDate: endDateController.text,
        status: selectedStatus ?? "Ongoing",
      );

      if (editingIndex != null) {
        // Update existing project
        await DatabaseHelper.instance.updateProject(project);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Project updated successfully!')),
        );

        editingIndex = null;
      } else {
        // Add new project

        await addProject(project);
        fetchProjects();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Project added successfully!')),
        );
      }

      await fetchProjects(); // Reload projects from database
      _clearFields();
      Navigator.pop(context); // Go back to HomeScreen
    }
  }

  // Load projects from the database
  // Future<void> loadProjects() async {
  //   _projects = await DatabaseHelper.instance.getProjects();
  //   notifyListeners();
  // }

  // Delete project
  Future<void> deleteProject(int id) async {
    await DatabaseHelper.instance.deleteProject(id);
    await fetchProjects();
  }

  // Load project details for editing
  void editProject(ProjectModel project, BuildContext context) {
  projectNameController.text = project.projectName;
  locationController.text = project.location;
  startDateController.text = project.startDate;
  endDateController.text = project.endDate;
  selectedStatus = project.status;
  editingIndex = project.id;  // Store the ID for updating

  notifyListeners();  // Notify UI about changes
}
  // Clear form fields
  void _clearFields() {
    projectNameController.clear();
    locationController.clear();
    startDateController.clear();
    endDateController.clear();
    selectedStatus = null;
    editingIndex = null;
  }

  List<ProjectModel> _projects = [];
  List<ProjectModel> get projectsList => _projects;

  Future<void> fetchProjects() async {
    _projects = await DatabaseHelper.instance.getProjects();
    notifyListeners();
  }

  Future<void> addProject(ProjectModel project) async {
    await DatabaseHelper.instance.insertProject(project);
    fetchProjects();
  }
}
