import 'package:flutter/material.dart';
import 'package:habbit_breaker/articles.dart';
import 'package:habbit_breaker/generated/l10n.dart';
import 'package:habbit_breaker/screens/article_screen.dart';
import 'package:habbit_breaker/utils/dimensions.dart';
import 'package:habbit_breaker/widgets/article_card.dart';

class ArticlesListScreen extends StatefulWidget {
  const ArticlesListScreen({super.key});

  @override
  State<ArticlesListScreen> createState() => _ArticlesListScreenState();
}

class _ArticlesListScreenState extends State<ArticlesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).articles_for_you),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return Column(
              children: [
                ArticleCard(
                  image: article['image'],
                  category: article['category'],
                  title: article['title'],
                  width: double.infinity,
                  height: 120,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticleScreen(article: article),
                      ),
                    );
                  },
                ),
                Dimensions.mdHeight,
              ],
            );
          },
        ),
      ),
    );
  }
}
