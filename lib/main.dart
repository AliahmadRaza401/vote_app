import 'package:alibhaiapp/services/shearedpref_service.dart';
import 'package:alibhaiapp/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'provider/allPovider.dart';

Future<void> main() async {  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ShearedprefService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.                
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (BuildContext context, Widget? child) {
        return MultiProvider(
            providers: allProvider,
            child: MaterialApp(
              color: Colors.red,
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              debugShowCheckedModeBanner: false,
              home:
                  // MyNavigationBarScreen(),
                  // Login(),
                  // SignupPage(),
             const     SplashScreen(),
              // const SplashScreen(),
            ));
      },
    );

    
  }
}
