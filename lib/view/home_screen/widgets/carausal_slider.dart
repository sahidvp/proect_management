
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project_management_app/controller/news_provder.dart';

class CarausalSlider extends StatelessWidget {
  const CarausalSlider({super.key, required this.newsProvider});
  final NewsProvider newsProvider;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 250,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlay: true,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 500),
        viewportFraction: 0.9, // Adjust the visible fraction
        enlargeCenterPage: true, // Center the active item
      ),
      items: newsProvider.articles.map((article) {
        return Builder(
          builder: (BuildContext context) {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  article['urlToImage'] != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: article['urlToImage'] ?? '',
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Center(
                                child: Text('Image not available')),
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          height: 120,
                          color: Colors.grey,
                          child:
                              const Center(child: Text('No Image Available')),
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
    );
  }
}
