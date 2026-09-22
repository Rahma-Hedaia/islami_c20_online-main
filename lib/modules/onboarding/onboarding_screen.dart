import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:islam_c20_online/core/theme/app_colors.dart';
import 'package:islam_c20_online/modules/layout/screens/layout_screen.dart';

import '../../core/constant/on_boarding_model.dart';

// المفتاح اللي بنحفظ بيه إن اليوزر شاف الـ onboarding قبل كده
const String kOnboardingCompleteKey = 'onboarding_complete';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();
  int currentIndex = 0;

  final List<OnBoardingModel> onBoardingList = OnBoardingModel.getAllOnBoarding();

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kOnboardingCompleteKey, true);

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LayoutScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = currentIndex == onBoardingList.length - 1;
    final isFirstPage = currentIndex == 0;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: 0,
                    child: Image.asset(
                      'assets/images/header.png',
                      width: MediaQuery.of(context).size.width,
                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                    ),
                  ),
                  Positioned(
                    top: 140,
                    child: Image.asset('assets/images/Islami.png', height: 46),
                  ),
                ],
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: onBoardingList.length,
                onPageChanged: (index) => setState(() => currentIndex = index),
                itemBuilder: (context, index) {
                  final item = onBoardingList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          item.imagepath,
                          height: 190,
                          errorBuilder: (_, __, ___) => Icon(
                            Icons.image_outlined,
                            size: 120,
                            color: AppColors.gold.withValues(alpha: 0.4),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Text(
                          item.Title,
                          style: const TextStyle(
                            color: AppColors.gold,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item.Describtion,
                          style: TextStyle(
                            color: AppColors.gold.withValues(alpha: 0.75),
                            fontSize: 13,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 50,
                    child: isFirstPage
                        ? const SizedBox.shrink()
                        : TextButton(
                      onPressed: () {
                        pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        'Back',
                        style: const TextStyle(
                          color: AppColors.gold,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      onBoardingList.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        height: 6,
                        width: currentIndex == index ? 20 : 6,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? AppColors.gold
                              : AppColors.white.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 50,
                    child: TextButton(
                      onPressed: () {
                        if (isLastPage) {
                          _finishOnboarding();
                        } else {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        isLastPage ? 'Finish' : 'Next',
                        style: const TextStyle(
                          color: AppColors.gold,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}