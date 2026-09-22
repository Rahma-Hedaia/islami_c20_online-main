import 'package:flutter/material.dart';
import 'package:islam_c20_online/core/theme/app_colors.dart';

class SebhaScreen extends StatefulWidget {
  const SebhaScreen({super.key});

  @override
  State<SebhaScreen> createState() => _SebhaScreenState();
}

class _SebhaScreenState extends State<SebhaScreen> {
  static const int targetCount = 33;

  final List<String> dhikrList = [
    'سبحان الله',
    'الحمد لله',
    'الله أكبر',
  ];

  int counter = 0;
  int dhikrIndex = 0;

  double rotationTurns = 0;

  void _onTapSebha() {
    setState(() {
      counter++;
      rotationTurns += 1 / targetCount;

      if (counter >= targetCount) {
        counter = 0;
        dhikrIndex = (dhikrIndex + 1) % dhikrList.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/BackgroundSebha.png',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: AppColors.black),
              ),
            ),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final height = constraints.maxHeight;

                  final scale = (height / 720).clamp(0.75, 1.0);

                  final logoWidth = 300 * scale;
                  final sebhaSize = 260 * scale;
                  final headWidth = 260 * scale;

                  return Column(
                    children: [
                      Image.asset(
                        "assets/logo/home_logo.png",
                        width: logoWidth,
                      ),

                      SizedBox(height: 12 * scale),

                      Text(
                        'سبّح اسمك الأعلى',
                        style: TextStyle(
                          color: AppColors.white.withValues(alpha: 0.85),
                          fontSize: 16 * scale,
                        ),
                      ),

                      const Spacer(),

                      Image.asset(
                        'assets/images/sebha_head.png',
                        width: headWidth,
                        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                      ),

                      GestureDetector(
                        onTap: _onTapSebha,
                        child: SizedBox(
                          width: sebhaSize,
                          height: sebhaSize,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              AnimatedRotation(
                                turns: rotationTurns,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOut,
                                child: Image.asset(
                                  'assets/images/sebha_body.png',
                                  width: sebhaSize,
                                  errorBuilder: (_, __, ___) => Icon(
                                    Icons.circle_outlined,
                                    size: sebhaSize,
                                    color: AppColors.gold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 28 * scale),

                      Text(
                        dhikrList[dhikrIndex],
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 20 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(height: 8 * scale),

                      Text(
                        '$counter',
                        style: TextStyle(
                          color: AppColors.gold,
                          fontSize: 22 * scale,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Spacer(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}