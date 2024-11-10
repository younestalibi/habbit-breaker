import 'package:flutter/material.dart';
import 'package:habbit_breaker/generated/l10n.dart';

class ArticleScreen extends StatelessWidget {
  final Map<String, dynamic> article;

  const ArticleScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).article_about(article['category'])),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article['title'],
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  article['image'],
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                article['category'],
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                article['content'],
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
