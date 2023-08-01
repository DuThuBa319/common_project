import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:common_project/domain/entities/user_entity.dart';
import 'package:common_project/presentation/bloc/userlist/get_user_bloc/get_user_bloc.dart';
import 'package:common_project/presentation/common_widget/enum_common.dart';
import 'package:common_project/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:common_project/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../di/di.dart';
import '../../bloc/userlist/get_user_detail_bloc/get_user_detail_bloc.dart';
import '../../common_widget/custom_image_picker.dart';
import '../../common_widget/loading_widget.dart';
import '../../theme/app_text_theme.dart';
import 'user_edit_screen.dart';
part 'user_detail_screen.action.dart';

//Class Home
class UserDetailScreen extends StatefulWidget {
  final int id;
  final GetUserBloc userBloc;


  const UserDetailScreen({
    Key? key,
    required this.id,
    required this.userBloc,
  }) : super(key: key);

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  GetUserDetailBloc get detailBloc => BlocProvider.of(context);
  String? folderPath;
   String imageUrl = 'https://example.com/image.jpg';
   String fileName = 'image.jpg';
  final imagePicker = ImagePicker();

  // String selectedImageName = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    folderPath = "lib/assets/images/";
  }

  @override
  Widget build(BuildContext context) {
    return CustomScreenForm(
        appBarColor: AppColor.appBarColor,
        backgroundColor: Colors.white,
        isShowAppBar: true,
        isShowLeadingButton: true,
        title: 'User Detail Screen',
        child: Column(children: [
          BlocConsumer<GetUserDetailBloc, GetUserDetailState>(
            listener: _blocListener,
            builder: (context, state) {
              if (state is GetUserDetailInitialState &&
                  state.status == BlocStatusState.initial) {
                detailBloc.add(GetUserDetailEvent(userId: widget.id));
              }
              if (state is GetDetailUserState &&
                  state.status == BlocStatusState.loading) {
                return const Expanded(
                  child: Center(
                    child: Loading(
                      brightness: Brightness.light,
                    ),
                  ),
                );
              }
              if (state is GetDetailUserState &&
                  state.status == BlocStatusState.success) {
                UserEntity user = state.viewModel.userDetailEntity!;
                return Expanded(
                    child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImagePickerWithGridView(
                          isOnTapActive: true,
                          folderPath: folderPath,
                        ),
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(text: 'ID:', style: AppTextTheme.title6),
                              TextSpan(
                                  text: ' ${user.id} ',
                                  style: AppTextTheme.body1)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Job:', style: AppTextTheme.title6),
                              TextSpan(
                                  text: ' ${user.job} ',
                                  style: AppTextTheme.body1)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              TextSpan(
                                  text: 'Age:', style: AppTextTheme.title6),
                              TextSpan(
                                  text: ' ${user.age} ',
                                  style: AppTextTheme.body1)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Name:', style: AppTextTheme.title6),
                              TextSpan(
                                  text: ' ${user.name} ',
                                  style: AppTextTheme.body1)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Email:', style: AppTextTheme.title6),
                              TextSpan(
                                  text: ' ${user.email} ',
                                  style: AppTextTheme.body1)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Phone:', style: AppTextTheme.title6),
                              TextSpan(
                                  text: ' ${user.phoneNumber} ',
                                  style: AppTextTheme.body1)
                            ],
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 250),
                            child: Row(children: [
                              SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            width: 2,
                                            color: AppColor.appBarColor),
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                      onPressed: () async {
                                        detailBloc.add(
                                            DeleteUserEvent(userId: user.id!));
                                      },
                                      child: const Icon(Icons.delete))),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            width: 2,
                                            color: AppColor.appBarColor),
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return BlocProvider<
                                                GetUserDetailBloc>(
                                              create: (context) =>
                                                  getIt<GetUserDetailBloc>(),
                                              child: EditScreen(
                                                userEntity: user,
                                                detailBloc: detailBloc,
                                              ),
                                            );
                                          },
                                        ));
                                      },
                                      child: const Icon(Icons.edit))),
                              const SizedBox(
                                width: 10,
                              ),
                            ]))
                      ],
                    ),
                  ),
                ));
              }

              if (state is GetDetailUserState &&
                  state.status == BlocStatusState.failure) {
                return const Center(
                  child: Text("error"),
                );
              }
              return Container();
            },
          ),
        ]));
  }
}
