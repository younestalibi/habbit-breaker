import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habbit_breaker/data/articles.dart';
import 'package:habbit_breaker/constants/color_constants.dart';
import 'package:habbit_breaker/constants/image_constants.dart';
import 'package:habbit_breaker/data/quotes.dart';
import 'package:habbit_breaker/generated/l10n.dart';
import 'package:habbit_breaker/providers/setting_provider.dart';
import 'package:habbit_breaker/screens/article_screen.dart';
import 'package:habbit_breaker/screens/articles_list_screen.dart';
import 'package:habbit_breaker/utils/dimensions.dart';
import 'package:habbit_breaker/widgets/article_card.dart';
import 'package:habbit_breaker/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.00),
        constraints: BoxConstraints(
          minHeight: Dimensions.screenHeight! * 0.90,
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Header(),
            Quote(),
            Articles(),
          ],
        ),
      ),
    );
  }
}

class Articles extends StatelessWidget {
  const Articles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String selectedLanguage =
        Provider.of<SettingsProvider>(context).languageCode;
    final List<Map<String, dynamic>> listArticles =
        articles[selectedLanguage] ?? articles['en']!;
    return Column(
      children: [
        SectionTitle(
          title: S.of(context).special_for_you,
          color: Theme.of(context).primaryColorLight,
          press: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ArticlesListScreen()));
          },
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: listArticles.take(4).map((article) {
            return Padding(
              padding: const EdgeInsets.only(right: 20),
              child: ArticleCard(
                image: article['image'],
                category: article['category'],
                title: article['title'],
                height: 100,
                width: 242,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArticleScreen(article: article),
                    ),
                  );
                },
              ),
            );
          }).toList()),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    required this.press,
    required this.color,
  });

  final String title;
  final Color color;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: color),
        ),
        TextButton(
          onPressed: press,
          style: TextButton.styleFrom(foregroundColor: Colors.grey),
          child: Text(S.of(context).see_more),
        ),
      ],
    );
  }
}

class Quote extends StatefulWidget {
  const Quote({super.key});

  @override
  State<Quote> createState() => _QuoteState();
}

class _QuoteState extends State<Quote> {
  @override
  Widget build(BuildContext context) {
    final String selectedLanguage =
        Provider.of<SettingsProvider>(context).languageCode;
    final List<String> englishQuotes =
        quotes[selectedLanguage] ?? quotes['en']!;
    final random = Random();
    final randomIndex = random.nextInt(englishQuotes.length);
    final randomQuote = englishQuotes[randomIndex];

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 35, 16, 20),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border.all(
                  width: 1, color: Theme.of(context).primaryColorLight),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ImageConstants.logo,
                  width: 46,
                  height: 46,
                  fit: BoxFit.contain,
                ),
                Dimensions.xsWidth,
                Expanded(
                  flex: 2,
                  child: Text(randomQuote,
                      style: Theme.of(context).textTheme.bodySmall),
                )
              ],
            )),
        Positioned(
            left: 12,
            top: -12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: const BoxDecoration(
                  color: ColorConstants.primary,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              child: Text(
                S.of(context).today_quote,
                style: const TextStyle(
                    color: ColorConstants.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
            ))
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding:const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        '7/90',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 40,
                            color: ColorConstants.primary),
                      ),
                      Dimensions.xsWidth,
                      Text(
                        S.of(context).days,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.primary),
                      )
                    ],
                  ),
                  Dimensions.xxsHeight,
                  CustomElevatedButton(
                    color: Theme.of(context).primaryColor,
                    backgroundColor: Theme.of(context).primaryColorLight,
                    padding: 10,
                    onPressed: () {
                      debugPrint('Button pressed');
                    },
                    text: S.of(context).view_progress,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  ImageConstants.logo,
                  fit: BoxFit.contain,
                  height: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

