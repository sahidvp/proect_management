// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:project_management_app/controller/news_provder.dart';
// import 'package:project_management_app/controller/project_controller.dart';
// import 'package:project_management_app/utils/data_base/data_base.dart';
// import 'package:provider/provider.dart';

// import 'package:project_management_app/utils/theme/colors.dart';
// import 'package:cached_network_image/cached_network_image.dart'; // New import for cached images

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final sw = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Home Screen",
//           style: TextStyle(fontSize: 25, fontFamily: "Poppins"),
//         ),
//       ),
//       body: Column(
//         children: [
//           Consumer<NewsProvider>(
//             // Consumer for the NewsProvider
//             builder: (context, newsProvider, child) {
//               if (newsProvider.isLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (newsProvider.articles.isEmpty) {
//                 return const Center(child: Text("No news available."));
//               } else {
//                 return Column(
//                   children: [
//                     CarouselSlider(
//                       options: CarouselOptions(
//                         height: 180,
//                         autoPlayInterval: const Duration(seconds: 5),
//                         autoPlayAnimationDuration:
//                             const Duration(milliseconds: 800),
//                       ),
//                       items: newsProvider.articles.map((article) {
//                         return Builder(
//                           builder: (BuildContext context) {
//                             return Card(
//                               margin:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   article['urlToImage'] != null
//                                       ? ClipRRect(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           child: CachedNetworkImage(
//                                             imageUrl:
//                                                 article['urlToImage'] ?? '',
//                                             width: double.infinity,
//                                             height: 120,
//                                             fit: BoxFit.cover,
//                                             placeholder: (context, url) =>
//                                                 const Center(
//                                                     child:
//                                                         CircularProgressIndicator()),
//                                             errorWidget: (context, url,
//                                                     error) =>
//                                                 const Center(
//                                                     child: Text(
//                                                         'Image not available')),
//                                           ),
//                                         )
//                                       : Container(
//                                           width: double.infinity,
//                                           height: 120,
//                                           color: Colors.grey,
//                                           child: const Center(
//                                               child:
//                                                   Text('No Image Available')),
//                                         ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(
//                                       article['title'] ?? 'No Title',
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         );
//                       }).toList(),
//                     ),
//                     const SizedBox(
//                         height:
//                             10), // Added space between carousel and the list
//                   ],
//                 );
//               }
//             },
//           ),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                   vertical: sw * .05, horizontal: sw * .02),
//               child: Consumer<ProjectProvider>(
//                 // Consumer for FormProvider
//                 builder: (context, projectprovider, child) {
//                   return projectprovider.projects.isEmpty
//                       ? const Center(child: Text("No projects added yet!"))
//                       : ListView.builder(
//                           itemCount: projectprovider.projects.length,
//                           itemBuilder: (context, index) {
//                             final project = projectprovider.projects[index];

//                             return Dismissible(
//                               key: ValueKey(project.projectName),
//                               background: Container(
//                                 color: Colors.blue,
//                                 alignment: Alignment.centerLeft,
//                                 padding:
//                                     EdgeInsets.symmetric(horizontal: sw * .05),
//                                 child:
//                                     const Icon(Icons.edit, color: Colors.white),
//                               ),
//                               secondaryBackground: Container(
//                                 color: Colors.red,
//                                 alignment: Alignment.centerRight,
//                                 padding:
//                                     EdgeInsets.symmetric(horizontal: sw * .05),
//                                 child: const Icon(Icons.delete,
//                                     color: Colors.white),
//                               ),
//                               confirmDismiss: (direction) async {
//                                 if (direction == DismissDirection.startToEnd) {
//                                   DatabaseHelper.instance
//                                       .updateProject(project);
//                                   Navigator.pushNamed(context, "/form");
//                                   return false;
//                                 } else {
//                                   DatabaseHelper.instance
//                                       .updateProject(project);
//                                   return true;
//                                 }
//                               },
//                               child: Padding(
//                                 padding: EdgeInsets.all(sw * .02),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black.withOpacity(0.1),
//                                         blurRadius: 10,
//                                         spreadRadius: 2,
//                                         offset: const Offset(0, 5),
//                                       )
//                                     ],
//                                     color: Colors.white,
//                                     border: Border.all(
//                                       color: Appcolors.primary,
//                                       width: 1.0,
//                                     ),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsets.all(sw * .05),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text(
//                                               project.projectName,
//                                               style: const TextStyle(
//                                                   color: Colors.black,
//                                                   fontSize: 20),
//                                             ),
//                                             Container(
//                                               padding: EdgeInsets.all(sw * .02),
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                         sw * .05),
//                                                 color: Appcolors.background,
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color: Colors.black
//                                                         .withOpacity(0.1),
//                                                     blurRadius: 10,
//                                                     spreadRadius: 2,
//                                                     offset: const Offset(0, 5),
//                                                   )
//                                                 ],
//                                               ),
//                                               child: Text(project.status),
//                                             )
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             const Icon(Icons.gps_fixed,
//                                                 color: Colors.grey),
//                                             const SizedBox(width: 8),
//                                             Text(project.location),
//                                           ],
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text(
//                                                 "Start date: ${project.startDate}"),
//                                             Text(
//                                                 "End date: ${project.endDate}"),
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Appcolors.primary,
//         onPressed: () => Navigator.pushNamed(context, "/form"),
//         child: const Icon(Icons.add, color: Colors.white),
//       ),
//     );
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_management_app/controller/form_controller.dart';
import 'package:project_management_app/controller/news_provder.dart';

import 'package:provider/provider.dart';
import 'package:project_management_app/utils/theme/colors.dart';
import 'package:cached_network_image/cached_network_image.dart'; // New import for cached images

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home Screen",
          style: TextStyle(fontSize: 25, fontFamily: "Poppins"),
        ),
      ),
      body: Column(
        children: [
          Consumer<NewsProvider>(
            builder: (context, newsProvider, child) {
              if (newsProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (newsProvider.articles.isEmpty) {
                return const Center(child: Text("No news available."));
              } else {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      height: 200, // Fixed height for the carousel
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 250,
                          autoPlayInterval: const Duration(seconds: 5),
                          autoPlay: true,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 500),
                          viewportFraction: 0.9, // Adjust the visible fraction
                          enlargeCenterPage: true, // Center the active item
                        ),
                        items: newsProvider.articles.map((article) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Card(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    article['urlToImage'] != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  article['urlToImage'] ?? '',
                                              width: double.infinity,
                                              height: 120,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  const Center(
                                                      child: Text(
                                                          'Image not available')),
                                            ),
                                          )
                                        : Container(
                                            width: double.infinity,
                                            height: 120,
                                            color: Colors.grey,
                                            child: const Center(
                                                child:
                                                    Text('No Image Available')),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        article['title'] ?? 'No Title',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                        height:
                            10), // Added space between carousel and the list
                  ],
                );
              }
            },
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: sw * .05, horizontal: sw * .02),
              child: Consumer<FormProvider>(
                // Consumer for FormProvider
                builder: (context, formprovider, child) {
                  return formprovider.projectsList.isEmpty
                      ? Center(
                          child: SizedBox(
                          height: sw * .5,
                          child: LottieBuilder.asset(
                              "assets/aniamtion/IbWsO5Z3UV (1).json"),
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
                                padding:
                                    EdgeInsets.symmetric(horizontal: sw * .05),
                                child:
                                    const Icon(Icons.edit, color: Colors.white),
                              ),
                              secondaryBackground: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding:
                                    EdgeInsets.symmetric(horizontal: sw * .05),
                                child: const Icon(Icons.delete,
                                    color: Colors.white),
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
                                        color: Colors.black.withOpacity(0.1),
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
                                              ? Colors.orange
                                                  .withValues(alpha: 0.3)
                                              : Appcolors.background,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(sw * .05),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              project.projectName,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(sw * .02),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        sw * .05),
                                                color: project.status ==
                                                        "Completed"
                                                    ? Colors.green
                                                        .withValues(alpha: 0.3)
                                                    : project.status ==
                                                            "Pending"
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
                                            Text(
                                                "Start : ${project.startDate}"),
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
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Appcolors.primary,
        onPressed: () => Navigator.pushNamed(context, "/form"),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
