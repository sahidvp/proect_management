class ProjectModel {
  int? id;
  String projectName;
  String location;
  String startDate;
  String endDate;
  String status;

  ProjectModel({
    this.id,
    required this.projectName,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'projectName': projectName,
      'location': location,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'],
      projectName: map['projectName'],
      location: map['location'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      status: map['status'],
    );
  }
}
