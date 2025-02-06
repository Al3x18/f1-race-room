import 'package:xml/xml.dart';

class NewsArticleModel {
  final String title;
  final String link;
  final String description;
  final String category;
  final String pubDate;
  final String imageUrl;

  NewsArticleModel({
    required this.title,
    required this.link,
    required this.description,
    required this.category,
    required this.pubDate,
    required this.imageUrl,
  });

  factory NewsArticleModel.fromXml(XmlElement item) {
    return NewsArticleModel(
      title: item.findElements('title').isNotEmpty ? item.findElements('title').first.innerText : 'No Title',
      link: item.findElements('link').isNotEmpty ? item.findElements('link').first.innerText : 'No Link',
      description: item.findElements('description').isNotEmpty ? item.findElements('description').first.innerText : 'No Description',
      category: item.findElements('category').isNotEmpty ? item.findElements('category').first.innerText : 'No Category',
      pubDate: item.findElements('pubDate').isNotEmpty ? item.findElements('pubDate').first.innerText : 'No Publication Date',
      imageUrl: item.findElements('enclosure').isNotEmpty ? item.findElements('enclosure').first.getAttribute('url') ?? '' : '',
    );
  }
}