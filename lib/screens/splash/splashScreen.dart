import 'dart:async';
import 'dart:developer';
import 'package:alibhaiapp/screens/Authentication/login.dart';
import 'package:alibhaiapp/screens/user/userHomeScreen.dart';
import 'package:alibhaiapp/utils/images.dart';
import 'package:alibhaiapp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../../services/shearedpref_service.dart';
import '../admin/adminBottomBar.dart';
import '../admin/adminHome.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkIntro();
  }

  bool? getuserLOgedIN;
  String? userTypeVal;
  checkIntro() {
    getuserLOgedIN = ShearedprefService.getUserLoggedIn();
    userTypeVal = ShearedprefService.getUserTpe();

    Timer(const Duration(milliseconds: 6), () {
      if (getuserLOgedIN == false || getuserLOgedIN == null) {
        log('Value false');
       
      AppRoutes.pushAndRemoveUntil(
            context,
            PageTransitionType.fade,
            const Login(),
          );
      } else {
        log('Value true ');
         if (userTypeVal == 'admin') {
          AppRoutes.pushAndRemoveUntil(
            context,
            PageTransitionType.fade,
            const AdminBottomNavigationBarScreen(),
          );
        } else {
             AppRoutes.pushAndRemoveUntil(
            context,
            PageTransitionType.fade,
            const UserHomeScreen(),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: Image(
                image: AssetImage(AppImages.logo),
              ),
            ),
            Text('ahmad'),
          ],
        ),
      ),
    );
  }
}
