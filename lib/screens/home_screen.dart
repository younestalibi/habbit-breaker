import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habbit_breaker/articles.dart';
import 'package:habbit_breaker/constants/color_constants.dart';
import 'package:habbit_breaker/constants/image_constants.dart';
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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: S.of(context).special_for_you,
          color: Theme.of(context).primaryColorLight,
          press: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ArticlesListScreen()));
          },
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: articles.take(4).map((article) {
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
    final String _selectedLanguage =
        Provider.of<SettingsProvider>(context).languageCode;
    final List<String> englishQuotes =
        quotes[_selectedLanguage] ?? quotes['en']!;
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
                  SizedBox(height: 8.0),
                  CustomElevatedButton(
                    color: Theme.of(context).primaryColor,
                    backgroundColor: Theme.of(context).primaryColorLight,
                    padding: 10,
                    onPressed: () {
                      print('Button pressed');
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

final Map<String, List<String>> quotes = {
  'en': [
    "The only way to do great work is to love what you do. — Steve Jobs",
    "Success is not final, failure is not fatal: It is the courage to continue that counts. — Winston Churchill",
    "The journey of a thousand miles begins with one step. — Lao Tzu",
    "Believe you can and you're halfway there. — Theodore Roosevelt",
    "Don't watch the clock; do what it does. Keep going. — Sam Levenson",
    "Life is what happens when you're busy making other plans. — John Lennon",
    "You miss 100% of the shots you don't take. — Wayne Gretzky",
    "Act as if what you do makes a difference. It does. — William James",
    "It is never too late to be what you might have been. — George Eliot",
    "Do not wait to strike till the iron is hot, but make it hot by striking. — William Butler Yeats",
    "Success usually comes to those who are too busy to be looking for it. — Henry David Thoreau",
    "Don't be afraid to give up the good to go for the great. — John D. Rockefeller",
    "I find that the harder I work, the more luck I seem to have. — Thomas Jefferson",
    "Opportunities don't happen. You create them. — Chris Grosser",
    "The future depends on what you do today. — Mahatma Gandhi",
    "If you want to achieve greatness stop asking for permission. — Anonymous",
    "Everything you can imagine is real. — Pablo Picasso",
    "What lies behind us and what lies before us are tiny matters compared to what lies within us. — Ralph Waldo Emerson",
    "You are never too old to set another goal or to dream a new dream. — C.S. Lewis",
    "Do what you can, with what you have, where you are. — Theodore Roosevelt",
  ],
  'ar': [
    "الطريقة الوحيدة للقيام بعمل رائع هي أن تحب ما تفعله. — ستيف جوبز",
    "النجاح ليس نهائيًا، والفشل ليس قاتلًا: إنها الشجاعة لمواصلة الطريق. — ونستون تشرشل",
    "رحلة الألف ميل تبدأ بخطوة واحدة. — لاو تزو",
    "إذا كنت تؤمن بنفسك، فأنت في منتصف الطريق. — ثيودور روزفلت",
    "لا تراقب الساعة، بل افعل ما تفعله. استمر. — سام ليفنسون",
    "الحياة هي ما يحدث عندما تكون مشغولاً بوضع خطط أخرى. — جون لينون",
    "تفتقد 100% من الفرص التي لا تأخذها. — واين جريتسكي",
    "تصرف كما لو أن ما تفعله يحدث فرقًا. إنه كذلك. — ويليام جيمس",
    "ليس من المتأخر أبدًا أن تكون ما قد كنت عليه. — جورج إليوت",
    "لا تنتظر حتى تضرب الحديد ساخنًا، بل اجعل الحديد ساخنًا بالضرب. — ويليام بتلر ييتس",
    "عادةً ما يأتي النجاح لأولئك الذين يكونون مشغولين جدًا للبحث عنه. — هنري ديفيد ثورو",
    "لا تخف من التخلي عن الجيد للذهاب إلى العظيم. — جون د. روكفلر",
    "أجد أنني كلما عملت بجد، زادت حظوظي. — توماس جيفرسون",
    "الفرص لا تحدث. أنت تخلقها. — كريس جروسر",
    "المستقبل يعتمد على ما تفعله اليوم. — مهاتما غاندي",
    "إذا كنت تريد أن تحقق العظمة، فتوقف عن طلب الإذن. — مجهول",
    "كل ما يمكنك تخيله هو حقيقي. — بابلو بيكاسو",
    "ما يكمن وراءنا وما يكمن أمامنا أمور صغيرة مقارنة بما يكمن داخلنا. — رالف والدو إيمرسون",
    "لا تكون أبدًا كبيرًا جدًا لتحديد هدف آخر أو لحلم حلم جديد. — ك.س. لويس",
    "افعل ما تستطيع، بما لديك، حيث أنت. — ثيودور روزفلت",
  ],
};
