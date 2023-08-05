import 'package:common_project/presentation/bloc/login/login_bloc.dart';
import 'package:common_project/presentation/common_widget/assets.dart';
import 'package:common_project/presentation/route/route_list.dart';
import 'package:common_project/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'di/di.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'presentation/route/route.dart';

void main() async {
  // SỬA CHỖ NÀY

  // 2 DÒNG Ở TRÊN SỬA
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  // await Firebase.initializeApp();
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
  LoginBloc get bloc => BlocProvider.of(context);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Common Project',
        onGenerateRoute: AppRoute.onGenerateRoute,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AnimatedSplashScreen(
          nextRoute: RouteList.login,
          duration: 1000,
          splash: Assets.logoFlutter,
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: AppColor.blue03A1E4,
          nextScreen: Container(),
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
//     Future.delayed(const Duration(seconds: 2)).then((value) {
//       Navigator.pushNamed(context, RouteList.login);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Image.asset(
//           Assets.logoFlutter,
//           scale: 3,
//         ),
//       ),
//     );
//   }

