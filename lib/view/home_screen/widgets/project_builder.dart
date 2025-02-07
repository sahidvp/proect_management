import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_management_app/controller/form_controller.dart';
import 'package:project_management_app/utils/theme/colors.dart';
import 'package:provider/provider.dart';

class ProjectBuilder extends StatelessWidget {
  const ProjectBuilder({
    super.key,
    required this.sw,
  });

  final double sw;

  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(
      // Consumer for FormProvider
      builder: (context, formprovider, child) {
        return formprovider.projectsList.isEmpty
            ? Center(
                child: SizedBox(
                height: sw * .5,
                child:
                    LottieBuilder.asset("assets/aniamtion/IbWsO5Z3UV (1).json"),
              ))
            : ListView.builder(
                itemCount: formprovider.projectsList.length,
                itemBuilder: (context, index) {
                  final project = formprovider.projectsList[index];

                  return Dismissible(
                    key: ValueKey(project.id),
                    background: Container(
                      color: Colors.blue,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: sw * .05),
                      child: const Icon(Icons.edit, color: Colors.white),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: sw * .05),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        formprovider.editProject(project, context);
                        await Future.delayed(const Duration(
                            milliseconds:
                                100)); // Small delay to ensure UI updates
                        Navigator.pushNamed(context, "/form");
                        return false; // Prevent deletion
                      } else {
                        formprovider.deleteProject(project.id!);
                        return true;
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(sw * .02),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: const Offset(0, 5),
                            )
                          ],
                          color: Colors.white,
                          border: Border.all(
                            color: project.status == "Completed"
                                ? Colors.green.withValues(alpha: 0.3)
                                : project.status == "Pending"
                                    ? Colors.orange.withValues(alpha: 0.3)
                                    : Appcolors.background,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(sw * .05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    project.projectName,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(sw * .02),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(sw * .05),
                                      color: project.status == "Completed"
                                          ? Colors.green.withValues(alpha: 0.3)
                                          : project.status == "Pending"
                                              ? Colors.orange
                                              : Appcolors.background,
                                    ),
                                    child: Text(project.status),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.gps_fixed,
                                      color: Colors.grey),
                                  const SizedBox(width: 8),
                                  Text(project.location),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Start : ${project.startDate}"),
                                  Text("End : ${project.endDate}"),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
