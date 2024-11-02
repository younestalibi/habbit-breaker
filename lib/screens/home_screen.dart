import 'package:flutter/material.dart';
import 'package:habbit_breaker/articles.dart';
import 'package:habbit_breaker/constants/color_constants.dart';
import 'package:habbit_breaker/constants/image_constants.dart';
import 'package:habbit_breaker/providers/setting_provider.dart';
import 'package:habbit_breaker/providers/ui_provider.dart';
import 'package:habbit_breaker/screens/articles_list_screen.dart';
import 'package:habbit_breaker/utils/dimensions.dart';
import 'package:habbit_breaker/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Special for you",
            color: Theme.of(context).primaryColorLight,
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ArticlesListScreen()));
            },
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: articles.take(4).map((article) {
            return ArticleCard(
              image: article['image'],
              category: article['category'],
              title: article['title'],
              press: () {},
            );
          }).toList()),
        ),
      ],
    );
  }
}

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    Key? key,
    required this.category,
    required this.image,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 242,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black54,
                        Colors.black38,
                        Colors.black26,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: title)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.press,
    required this.color,
  }) : super(key: key);

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
          child: const Text("See more"),
        ),
      ],
    );
  }
}

class Quote extends StatelessWidget {
  const Quote({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
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
                  child: Text(
                      'hello world hello world hello worldhello worldhello worldhello worldhello worldhello world',
                      style: Theme.of(context).textTheme.bodySmall),
                )
              ],
            )),
        Positioned(
            left: 30,
            top: 8,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                'Today\'s quote',
                style: TextStyle(
                    color: ColorConstants.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
              decoration: BoxDecoration(
                  color: ColorConstants.primary,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
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
      margin: EdgeInsets.all(16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
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
                      Text(
                        '7/90',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 40,
                            color: ColorConstants.primary),
                      ),
                      Dimensions.xsWidth,
                      Text(
                        "Days",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.primary),
                      )
                    ],
                  ),
                  SizedBox(height: 8.0),
                  CustomElevatedButton(
                    color: Theme.of(context).primaryColor,
                    backgroundColor: Theme.of(context).primaryColorLight,
                    padding: 10,
                    onPressed: () {
                      print('Button pressed');
                    },
                    text: 'View The Progress',
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
