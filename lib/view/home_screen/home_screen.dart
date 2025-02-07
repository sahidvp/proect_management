import 'package:flutter/material.dart';
import 'package:project_management_app/controller/news_provder.dart';
import 'package:project_management_app/view/home_screen/widgets/carausal_slider.dart';
import 'package:project_management_app/view/home_screen/widgets/floatin_button.dart';
import 'package:project_management_app/view/home_screen/widgets/project_builder.dart';

import 'package:provider/provider.dart';

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
              } else if (newsProvider.articles.isEmpty && newsProvider.isLoading) {
                return const Center(child: Text("No news available."));
              } else {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      height: 200, // Fixed height for the carousel
                      child: CarausalSlider(
                        newsProvider: newsProvider,
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
              child: ProjectBuilder(sw: sw),
            ),
          ),
        ],
      ),
      floatingActionButton: floatinButton(context),
    );
  }
}
