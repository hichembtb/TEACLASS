import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/constants.dart';
import '../../../../core/utils/size_config.dart';
import '../../../onboarding/presentation/on_boarding_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? fadingAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    fadingAnimation =
        Tween<double>(begin: .2, end: 1).animate(animationController!);
    animationController!.repeat(reverse: true);
    goToNextView();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          SizedBox(
            height: SizeConfig.screenHeight! * 0.1,
          ),
          Image.asset(
            kLogo,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FadeTransition(
              opacity: fadingAnimation!,
              child: Text(
                'TEACLASS',
                style: TextStyle(
                  fontSize: SizeConfig.screenWidth! * 0.15,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF02093C),
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  void goToNextView() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.to(() => const OnBoardingView(), transition: Transition.fade);
    });
  }
}
