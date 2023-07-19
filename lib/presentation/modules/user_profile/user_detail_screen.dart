import 'dart:io';

import 'package:common_project/domain/entities/user_entity.dart';
import 'package:common_project/presentation/bloc/userlist/get_user_bloc/get_user_bloc.dart';
import 'package:common_project/presentation/common_widget/enum_common.dart';
import 'package:common_project/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:common_project/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:image_picker/image_picker.dart';
import '../../../di/di.dart';
import '../../bloc/userlist/get_user_detail_bloc/get_user_detail_bloc.dart';

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

  XFile? _image;
  String? _imagePath;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
        _imagePath = pickedImage.path;
      });
    }
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
            listener: (context, state) {
              if (state is UpdateUserState &&
                  state.status == BlocStatusState.success) {
                detailBloc.add(GetUserDetailEvent(userId: widget.id));
              }
              if (state is DeleteUserState &&
                  state.status == BlocStatusState.success) {
                widget.userBloc.add(GetListUserEvent());
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state is GetUserDetailInitialState) {
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
                    child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Stack(children: [
                        Container(
                            margin: const EdgeInsets.only(left: 20),
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: AppColor.appBarColor),
                                borderRadius:
                                    BorderRadiusDirectional.circular(20)),
                            child: _imagePath != null
                                ? ClipRRect(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(20),
                                    child: FullScreenWidget(
                                        disposeLevel: DisposeLevel.Low,
                                        child: Hero(
                                          tag: "",
                                          child: Image.file(File(_imagePath!),
                                              fit: BoxFit.cover),
                                        )),
                                  )
                                : const Icon(Icons.people_alt_outlined,
                                    color: AppColor.appBarColor, size: 50)),
                        Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 4, color: Colors.white),
                                color: AppColor.appBarColor,
                                shape: BoxShape.circle),
                            margin: const EdgeInsets.only(left: 120, top: 120),
                            child: SizedBox(
                                height: 60,
                                width: 60,
                                child: IconButton(
                                  style: IconButton.styleFrom(
                                    side: const BorderSide(
                                        width: 2, color: AppColor.appBarColor),
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.add_a_photo,
                                    color: AppColor.white,
                                    size: 30,
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      showModalBottomSheet<ImageSource>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.21,
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30),
                                              )),
                                              child: Wrap(
                                                children: [
                                                  ListTile(
                                                    leading: const Icon(
                                                        Icons.photo_library),
                                                    title:
                                                        const Text('Gallery'),
                                                    onTap: () {
                                                      _pickImage(
                                                          ImageSource.gallery);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                        Icons.camera_alt),
                                                    title: const Text('Camera'),
                                                    onTap: () {
                                                      _pickImage(
                                                          ImageSource.camera);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                        Icons.delete),
                                                    title: const Text('Remove'),
                                                    onTap: () {
                                                      setState(() {
                                                        _imagePath = null;
                                                        _image = null;
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    });
                                  },
                                )))
                      ])),
                      RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(text: 'ID:', style: AppTextTheme.title6),
                            TextSpan(
                                text: ' ${user.id} ', style: AppTextTheme.body1)
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(text: 'Job:', style: AppTextTheme.title6),
                            TextSpan(
                                text: ' ${user.job} ',
                                style: AppTextTheme.body1)
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(text: 'Age:', style: AppTextTheme.title6),
                            TextSpan(
                                text: ' ${user.age} ',
                                style: AppTextTheme.body1)
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(text: 'Name:', style: AppTextTheme.title6),
                            TextSpan(
                                text: ' ${user.name} ',
                                style: AppTextTheme.body1)
                          ],
                        ),
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
                                        borderRadius: BorderRadius.circular(25),
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
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(
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

  // Future<void> showPicker(BuildContext context) async {
  //   ImageSource? source;
  //   source = await selectSource();
  //   detailBloc.add(PickImageEvent(source: source));
  // }

  // Future<ImageSource?> selectSource() async {
  //   await showModalBottomSheet<ImageSource>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         height: MediaQuery.of(context).size.height * 0.15,
  //         decoration: const BoxDecoration(
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(25),
  //             topRight: Radius.circular(25),
  //           ),
  //         ),
  //         child: Wrap(
  //           children: <Widget>[
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             ListTile(
  //               leading: const Icon(
  //                 Icons.photo_library,
  //               ),
  //               title: const Text(
  //                 'Gallery',
  //                 style: TextStyle(),
  //               ),
  //               onTap: () {
  //                 Navigator.of(context).pop(ImageSource.gallery);
  //               },
  //             ),
  //             ListTile(
  //               leading: const Icon(
  //                 Icons.photo_camera,
  //               ),
  //               title: const Text(
  //                 'Camera',
  //                 style: TextStyle(),
  //               ),
  //               onTap: () {
  //                 Navigator.of(context).pop(ImageSource.camera);
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  //   return null;
  // }
}
