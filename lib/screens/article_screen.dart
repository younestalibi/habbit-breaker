import 'package:flutter/material.dart';
import 'package:habbit_breaker/generated/l10n.dart';
import 'package:habbit_breaker/utils/dimensions.dart';

class ArticleScreen extends StatelessWidget {
  final Map<String, dynamic> article;

  const ArticleScreen({Key? key, required this.article}) : super(key: key);

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
              Dimensions.xsHeight,
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(article['image'], width: double.infinity),
              ),
              SizedBox(height: 16),
              Text(
                article['category'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Dimensions.xxsHeight,
              Text(
                article['content'],
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
