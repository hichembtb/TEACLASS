import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/widgets/custom_buttons.dart';
import '../../../auth/presentation/pages/login/login_view.dart';
import 'custom_indicator.dart';
import 'custom_page_view.dart';

class OnBoardinViewBody extends StatefulWidget {
  const OnBoardinViewBody({Key? key}) : super(key: key);

  @override
  State<OnBoardinViewBody> createState() => _OnBoardinViewBodyState();
}

class _OnBoardinViewBodyState extends State<OnBoardinViewBody> {
  PageController? pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPageView(
          pageController: pageController,
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: SizeConfig.defaultSize! * 15,
          child: CustomIndicator(
            dotIndex: hasClientCheck() ? pageController!.page : 0,
          ),
        ),
        Visibility(
          visible: hasClientCheck()
              ? (pageController?.page == 2 ? false : true)
              : true,
          child: Positioned(
            top: SizeConfig.defaultSize! * 10,
            right: 32,
            child: TextButton(
              onPressed: () {
                pageController!.jumpToPage(2);
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: SizeConfig.defaultSize! * 10,
          right: SizeConfig.defaultSize! * 10,
          bottom: SizeConfig.defaultSize! * 5,
          child: CustomGeneralButton(
            onTap: nextPage,
            text: hasClientCheck()
                ? (pageController?.page == 2 ? 'Get Started' : 'Next')
                : 'Next',
          ),
        ),
      ],
    );
  }

  bool hasClientCheck() => pageController!.hasClients;
  void nextPage() {
    if (pageController!.page! < 2) {
      pageController?.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    } else {
      Get.off(
        () => const LoginView(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 500),
      );
    }
  }
}
