import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:race_room/api/api_service.dart';
import 'package:race_room/model/news/news_article_model.dart';
import 'package:race_room/utils/colors/app_colors.dart';
import 'package:race_room/widgets/news/news_item.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  late Future<List<NewsArticleModel>> newsList;
  String localization = "en";

  String formatNewsDate(String dateString) {
    final List date = dateString.split(" ");
    final String dayName = date[0].split(",")[0];
    final String day = date[1];
    final String month = date[2];
    final String year = date[3];

    final List time = date[4].split(":");
    final String hour = time[0];
    final String minute = time[1];
    //final String seconds = time[2];

    dateString = "$dayName, $day $month $year - $hour:$minute";
    return dateString;
  }

  @override
  void initState() {
    super.initState();
    newsList = ApiService().fetchNews(localization);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: !kIsWeb && Platform.isAndroid ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            const Text(
              "NEWS",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "motorsport.com",
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.newsViewSubtitle),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            initialValue: localization,
            color: isDarkMode ? AppColors.newsPopMenuBackgroundDark : AppColors.newsPopMenuBackgroundLight,
            constraints: const BoxConstraints(
              minWidth:60,
              maxWidth: 60,
            ),
            icon: Text(
              localization.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onSelected: (String value) {
              setState(() {
                localization = value;
                newsList = ApiService().fetchNews(localization);
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: "en",
                child: Text("EN"),
              ),
              const PopupMenuItem<String>(
                value: "it",
                child: Text("IT"),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          setState(() {
            newsList = ApiService().fetchNews(localization);
          });
        },
        child: FutureBuilder<List<NewsArticleModel>>(
          future: newsList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.circularProgressIndicator,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                child: Text('No data available'),
              );
            } else {
              final newsList = snapshot.data!;

              return ListView.builder(
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  return NewsItemWidget(newsArticle: newsList[index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
