import 'package:common_project/presentation/common_widget/assets.dart';
import 'package:common_project/presentation/route/route_list.dart';
import 'package:common_project/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'di/di.dart';
import 'presentation/route/route.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  // SỬA CHỖ NÀY

  // 2 DÒNG Ở TRÊN SỬA
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Common Project',
        onGenerateRoute: AppRoute.onGenerateRoute,
        home: AnimatedSplashScreen(
          duration: 500,
          splash: Center(
            child: Image.asset(
              Assets.logoCHA,
              scale: 2,
            ),
          ),
          nextRoute: RouteList.login,
          nextScreen:
              Container(), // Hoặc bất kỳ widget nào bạn muốn hiển thị trước khi chuyển màn hình
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: AppColor.blue001D37,
          splashIconSize: double
              .infinity, // Đảm bảo splash screen chiếm toàn bộ không gian màn hình
        ));
  }
}

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState

//     Future.delayed(const Duration(seconds: 1)).then((value) {
      // Navigator.pushNamed(context, RouteList.login);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:
//     );
//   }

