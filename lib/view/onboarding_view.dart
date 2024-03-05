import 'package:flutter/material.dart';
import 'package:smartpay/constants/app_theme/app_color.dart';
import 'package:smartpay/model/onboarding_model.dart';
import 'package:smartpay/view/authentication_screen/login_screen.dart';
import 'package:smartpay/view/widget/base_button.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  int currrentIndex = 0;
  PageController _controller = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
     currentIndex = ValueNotifier(0);
    autoChange();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    currentIndex.dispose();
  }
    late ValueNotifier<int> currentIndex;
  autoChange() {
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        _controller.jumpToPage((currentIndex.value + 1) % 2);
      });

      autoChange();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: SafeArea(

        child: Column(
          children: [
           const  SizedBox(height:20),
            Padding(
              padding: const EdgeInsets.only(left: 41.0, right: 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
              
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          fontFamily: 'SFMedium',
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: AppColors.secondaryColor
                        ))
                      ),
                ],
              ),
            ),
           const  SizedBox(height:60),
            Expanded(
              child: PageView.builder(
                  itemCount: onBoard.length,
                  controller: _controller,
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (int index) {
                    setState(() {
 currrentIndex = index;
                            currentIndex.value = index;                    });
                  },
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        Stack(
                          children: [
                         Image.asset(onBoard[index].img),
                            Positioned(

                              bottom: -10,
                              child: Container(
                                height: 150,
                                width:320,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
            //                          boxShadow: [
            //   BoxShadow(
            //     color: Color(0x336B727F),
            //     blurRadius: 25,
            //     offset: Offset(-10, 25),
            //     spreadRadius: 0,
            //   )
            // ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(onBoard[index].Topic,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                          fontFamily: 'SFPro',
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primaryColor
                        )),
                              Text(onBoard[index].subTopic,
                                  textAlign: TextAlign.center,
                                   style: TextStyle(
                          fontFamily: 'SFLightText',
                          fontSize: 14,
                         
                          color: AppColors.textColor
                        ))
                                ],),
                              ),
                            ),
                          
                          ],
                        ),
                      ],
                    );
                  }),
            ),
             const SizedBox(
              height: 20,
            ),
                AnimatedContainer(
                    duration: Duration(seconds: 2),
                    height: 8.0,
                    child: ListView.builder(
                      itemCount: onBoard.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3.0),
                          width: currrentIndex == index ? 25 : 7,
                          height: 6,
                          decoration: BoxDecoration(
                            color: currrentIndex == index
                                ? AppColors.primaryColor
                                : Color(0xFFE2D7E8),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        );
                      },
                    ),
                  ),
            const SizedBox(
              height: 40,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 24.0),
                child: Column(
                  children: [
                    BaseButton(
                      onPress: () {
                         Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    
                      },
                      bgColor: AppColors.primaryColor,
                      text: "Get Started",
                      fontFamily: '',
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}