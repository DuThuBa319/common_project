import 'package:common_project/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:flutter/material.dart';

import '../../theme/theme_color.dart';

part 'home_screen.action.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const CustomScreenForm(
        title: 'Home',
        isShowAppBar: true,
        isShowBottomNayvigationBar: true,
        isShowLeadingButton: true,
        appBarColor: AppColor.appBarColor,
        backgroundColor: AppColor.backgroundColor,
        leadingButton: Icon(Icons.menu),
        selectedIndex: 0,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [],
          ),
        ));
  }
}
