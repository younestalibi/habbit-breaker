import 'package:flutter/material.dart';
import 'package:habbit_breaker/constants/color_constants.dart';
import 'package:habbit_breaker/constants/image_constants.dart';
import 'package:habbit_breaker/generated/l10n.dart';
import 'package:habbit_breaker/providers/auth_provider.dart';
import 'package:habbit_breaker/providers/setting_provider.dart';
import 'package:habbit_breaker/utils/dimensions.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final String languageCode = settingsProvider.languageCode;
    final demoData = languageCode == 'en' ? demoDataEn : demoDataAr;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Expanded(
                flex: 10,
                child: PageView.builder(
                  itemCount: demoData.length,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemBuilder: (context, index) => OnboardContent(
                    illustration: demoData[index]["illustration"],
                    title: demoData[index]["title"],
                    text: demoData[index]["text"],
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  demoData.length,
                  (index) => DotIndicator(isActive: index == currentPage),
                ),
              ),
              const Spacer(flex: 2),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signin');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.primary,
                  foregroundColor: ColorConstants.white,
                  minimumSize: const Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(S.of(context).get_started.toUpperCase()),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    super.key,
    required this.illustration,
    required this.title,
    required this.text,
  });

  final String? illustration, title, text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ClipOval(
            child: Image.asset(
              illustration!,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Dimensions.xsHeight,
        Text(
          title!,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Dimensions.xxsHeight,
        Text(
          text!,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
    this.activeColor = ColorConstants.active,
    this.inActiveColor = ColorConstants.inActive,
  });

  final bool isActive;
  final Color activeColor, inActiveColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 16 / 2),
      height: 5,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inActiveColor.withOpacity(0.25),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}

List<Map<String, dynamic>> demoDataEn = [
  {
    "illustration": ImageConstants.onboardingMonitor,
    "title": "Track Your Progress",
    "text":
        "Monitor your journey and keep track of your days\nstaying strong and habit-free.",
  },
  {
    "illustration": ImageConstants.onboardingReading,
    "title": "Stay Motivated",
    "text":
        "Access motivational articles and tips to help\nyou stay on track and overcome challenges.",
  },
  {
    "illustration": ImageConstants.onboardingHealthy,
    "title": "Build Healthy Habits",
    "text":
        "Develop positive routines with our step-by-step\nguide to creating sustainable habits.",
  },
];

List<Map<String, dynamic>> demoDataAr = [
  {
    "illustration": ImageConstants.onboardingMonitor,
    "title": "تتبع تقدمك",
    "text": "راقب رحلتك واحتفظ بسجل أيامك للبقاء قويًا وخاليًا من العادات.",
  },
  {
    "illustration": ImageConstants.onboardingReading,
    "title": "حافظ على حماسك",
    "text":
        "احصل على مقالات تحفيزية ونصائح لمساعدتك في البقاء على المسار وتجاوز التحديات.",
  },
  {
    "illustration": ImageConstants.onboardingHealthy,
    "title": "ابنِ عادات صحية",
    "text": "طور عادات إيجابية مع دليلنا خطوة بخطوة لخلق عادات مستدامة.",
  },
];
