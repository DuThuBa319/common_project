// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:common_project/domain/entities/user_entity.dart';
import 'package:common_project/presentation/bloc/userlist/get_user_bloc/get_user_bloc.dart';
import 'package:common_project/presentation/modules/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_text_theme.dart';
import '../../../theme/theme_color.dart';

class UserListCell extends StatefulWidget {
  final UserEntity? userEntity;
  final GetUserBloc userBloc;
  const UserListCell({Key? key, this.userEntity, required this.userBloc})
      : super(key: key);

  @override
  State<UserListCell> createState() => _UserListCellState();
}

class _UserListCellState extends State<UserListCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return BlocProvider<GetUserDetailBloc>(
          //       create: (context) => getIt<GetUserDetailBloc>(),
          //       child: UserDetailScreen(
          //         id: widget.userEntity?.id ?? 0,
          //         userBloc: widget.userBloc,
          //       ));
          // }));
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
        },
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  15), // Đặt giá trị bán kính bo góc tại đây
            ),
            elevation: 20,
            shadowColor: Color.fromARGB(
                Random().nextInt(255),
                Random().nextInt(255),
                Random().nextInt(255),
                Random().nextInt(255)),
            color: AppColor.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const SizedBox(
                    height: 40,
                    width: 40,
                    child: Icon(
                      Icons.people_alt_outlined,
                      color: AppColor.black,
                    )),
                title: Text(
                  widget.userEntity?.name ?? '',
                  style: AppTextTheme.body2,
                ),
                subtitle: Text(widget.userEntity?.phoneNumber ?? '',
                    style: AppTextTheme.body4),
              ),
            )));
  }
}
