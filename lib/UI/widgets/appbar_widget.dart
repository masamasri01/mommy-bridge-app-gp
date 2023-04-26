import 'package:flutter/material.dart';
import 'package:gp/Providers/Teacher_provider.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/core/Texts/app_text_styles.dart';
import 'dart:math';
import 'package:gp/core/app_theme.dart';
import 'package:gp/settings_controller.dart/settingscontroller.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends PreferredSize {
//  final UserModel user;
  final BuildContext context;
  AppBarWidget({required this.context})
      : super(
          preferredSize: Size.fromHeight(250),
          child: Container(
            height: 270,
            child: Stack(
              children: [
                Container(
                  height: 161,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppGradients.linear,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Hello, ",
                          style: AppTextStyles.title,
                          children: [
                            TextSpan(
                              text: ('Masa Masri'),
                              style: AppTextStyles.titleBold,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //   Navigator.pushNamed(
                          //     context,
                          //   //  AppRoutes.settingsRoute,
                          //  //   arguments: SettingsPageArgs(user: user),
                          //   );
                        },
                        child: Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://avatars.githubusercontent.com/u/37520136?v=4",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment(0.0, 1.0),
                  child: ScoreCardWidget(
                    scorePercentage: 0.99,
                  ),
                ),
              ],
            ),
          ),
        );
}

class AppGradients {
  static final linear = LinearGradient(colors: [
    Color(0xFF57B6E5),
    // Color.fromRGBO(130, 87, 229, 0.695),
    MyColors.color3,
    MyColors.color1
  ], stops: [
    0.0,
    0.0,
    0.695,
  ], transform: GradientRotation(2.13959913 * pi));
}

class ScoreCardWidget extends StatelessWidget {
  final double scorePercentage;

  const ScoreCardWidget({
    Key? key,
    required this.scorePercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController =
        Provider.of<SettingsController>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        // top: 14,
      ),
      child: Container(
        height: 136,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppTheme.backgroundColors(Brightness.light),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color.fromARGB(255, 76, 71, 71),
            ),
          ],
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Provider.of<TeacherProvider>(context).isMom!
                ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        // child: ChartWidget(
                        //   percent: scorePercentage,
                        // ),
                        child: Image.asset('lib/core/images/mom.png'),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Welcome Back 💕👩!",
                                style: AppTextStyles.heading.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "Your Kids Are Having Their Best Moments There, Stay Safe.",
                                style: AppTextStyles.body.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        flex: 1,
                        // child: ChartWidget(
                        //   percent: scorePercentage,
                        // ),
                        child: Image.asset('lib/core/images/R.png'),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Welcome Back 💜!",
                                style: AppTextStyles.heading.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "You Can Share Your Loving Moments With Your Kids here",
                                style: AppTextStyles.body.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
      ),
    );
  }
}

class ChartWidget extends StatefulWidget {
  final double percent;

  const ChartWidget({
    Key? key,
    required this.percent,
  }) : super(key: key);

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget>
    with SingleTickerProviderStateMixin {
  // tipo late: indicamos que so vamos inicializa-lo depois
  late AnimationController _controller;
  late Animation<double> _animation;

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    // a principio essa Tween eh aquela animacao que vai "crescendo" de um valor inicial a um valor final
    _animation = Tween<double>(
      begin: 0.0,
      end: widget.percent,
    ).animate(_controller);

    _controller.forward(); // para a animacao "ir para a frente"
  }

  @override
  void initState() {
    _initAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) => Stack(
          children: [
            // Center(
            //   child: Container(
            //     height: 80,
            //     width: 80,
            //     child: CircularProgressIndicator(
            //       strokeWidth: 10,
            //       value: _animation.value,
            //       backgroundColor: Colors.grey,
            //       valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            //     ),
            //   ),
            // ),
            // Center(
            //   child: Text(
            //     "${(_animation.value * 100).toStringAsFixed(0)}%",
            //     style: AppTextStyles.heading.copyWith(
            //       color: SettingsController().currentAppTheme.primaryColor,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
