import 'package:flutter/material.dart';
import 'package:race_room/model/news/news_article_model.dart';
import 'package:race_room/utils/colors/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsItemWidget extends StatefulWidget {
  final NewsArticleModel newsArticle;

  const NewsItemWidget({
    super.key,
    required this.newsArticle,
  });

  @override
  State<NewsItemWidget> createState() => _NewsItemWidgetState();
}

class _NewsItemWidgetState extends State<NewsItemWidget> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapCancel: () => setState(() => isPressed = false),
      onTapUp: (_) async {
        setState(() => isPressed = false);

        Future.delayed(const Duration(milliseconds: 250), () async {
          final Uri url = Uri.parse(widget.newsArticle.link);
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.inAppBrowserView);
          }
        });
      },
      child: AnimatedScale(
        scale: isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
          height: 118.5,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(color: AppColors.circularProgressIndicator, strokeWidth: 2),
                                  );
                                }
                              },
                              widget.newsArticle.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            spacing: 2,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.newsArticle.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.newsArticle.description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.newsArticle.category,
                        style: const TextStyle(color: Colors.white70, fontSize: 10),
                      ),
                      Text(
                        formatNewsDate(widget.newsArticle.pubDate),
                        style: const TextStyle(color: Colors.white70, fontSize: 10),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatNewsDate(String dateString) {
    final List date = dateString.split(" ");
    final String dayName = date[0].split(",")[0];
    final String day = date[1];
    final String month = date[2];
    final String year = date[3];

    final List time = date[4].split(":");
    final String hour = time[0];
    final String minute = time[1];

    return "$dayName, $day $month $year - $hour:$minute";
  }
}
