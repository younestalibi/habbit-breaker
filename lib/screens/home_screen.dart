import 'package:flutter/material.dart';
import 'package:habbit_breaker/constants/color_constants.dart';
import 'package:habbit_breaker/constants/image_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Header(),
        Quote(),
        SpecialOffers(),
      ],
    );
  }
}

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
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
            press: () {},
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                image: "https://i.postimg.cc/yY2bNrmd/Image-Banner-2.png",
                category: "Smartphone",
                numOfBrands: 18,
                press: () {},
              ),
              SpecialOfferCard(
                image: "https://i.postimg.cc/BQjz4G1k/Image-Banner-3.png",
                category: "Fashion",
                numOfBrands: 24,
                press: () {},
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
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
                        TextSpan(text: "$numOfBrands Brands")
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
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
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
              color: ColorConstants.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(181, 236, 236, 236),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ImageConstants.logo,
                  width: 46,
                  height: 46,
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'hello world hello world hello worldhello worldhello worldhello worldhello worldhello world',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
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
    return Container(
        width: double.infinity,
        height: 150,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ColorConstants.white,
          border: Border.all(
            color: ColorConstants.shadow,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: ColorConstants.shadow,
                blurRadius: 2,
                offset: Offset(0, 1)),
          ],
        ),
        child: InkWell(
          onTap: () {
            print('go to tracking page');
          },
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Image.asset(
                    ImageConstants.logo,
                    fit: BoxFit.contain,
                  )),
                ],
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Days",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.primary),
                        ),
                        Text(
                          '7/90',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: ColorConstants.primary),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
