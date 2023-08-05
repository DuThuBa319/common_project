// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import "package:image_picker/image_picker.dart";
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../data/models/user_model.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../../domain/usecases/user_detail_usecase.dart';
import '../../../common_widget/enum_common.dart';
part 'get_user_detail_event.dart';
part 'get_user_detail_state.dart';

@injectable
class GetUserDetailBloc extends Bloc<UserDetailEvent, GetUserDetailState> {
  final UserDetailUsecase _userUserDetailCase;

  GetUserDetailBloc(this._userUserDetailCase)
      : super(GetUserDetailInitialState()) {
    on<GetUserDetailEvent>(_onGetUserDetail);
    on<DeleteUserEvent>(_onDeleteUser);
    on<UpdateUserEvent>(_onUpdateUser);
    on<ImageChangedEvent>(_onImageChanged);
    // on<PickImageEvent>(_onPickImage);
    // on<DeleteImageEvent>(_onDeleteImage);
    // on<ReplaceImageEvent>(_onReplaceImage);

    // on<LoadImageEvent>(_onLoadImage);
  }

  // Future<void> _onLoadImage(
  //   LoadImageEvent event,
  //   Emitter<GetUserDetailState> emit,
  // ) async {
  //   emit(
  //     LoadImageState(
  //       status: BlocStatusState.loading,
  //       viewModel: state.viewModel,
  //     ),
  //   );
  //   try {
  //     final newViewModel =
  //         state.viewModel.copyWith(imageFile: event.imageFile);
  //     emit(
  //       state.copyWith(
  //         status: BlocStatusState.success,
  //         viewModel: newViewModel,
  //       ),
  //     );
  //   } catch (exception) {
  //     emit(state.copyWith(status: BlocStatusState.failure));
  //   }
  // }

// REPLACE IMAGE
//   Future<void> _onReplaceImage(
//     ReplaceImageEvent event,
//     Emitter<GetUserDetailState> emit,
//   ) async {
//     emit(
//       GetDetailUserState(
//         status: BlocStatusState.loading,
//         viewModel: state.viewModel,
//       ),
//     );

//     try {
//       final imageFile = await selectFile(event.source ?? ImageSource.gallery);
//       final newViewModel = state.viewModel.copyWith(imageFile: imageFile);
//       emit(state.copyWith(
//         status: BlocStatusState.success,
//         viewModel: newViewModel,
//       ));
//     } catch (e) {
//       emit(
//         state.copyWith(
//           status: BlocStatusState.failure,
//           viewModel: state.viewModel,
//         ),
//       );
//     }
//   }

// // DELETE IMAGE
//   Future<void> _onDeleteImage(
//     DeleteImageEvent event,
//     Emitter<GetUserDetailState> emit,
//   ) async {
//     emit(
//       GetDetailUserState(
//         status: BlocStatusState.loading,
//         viewModel: state.viewModel,
//       ),
//     );
//     try {
//       final newViewModel = state.viewModel.copyWith(imageFile: null);
//       emit(state.copyWith(
//         status: BlocStatusState.success,
//         viewModel: newViewModel,
//       ));
//     } catch (e) {
//       emit(
//         state.copyWith(
//           status: BlocStatusState.failure,
//           viewModel: state.viewModel,
//         ),
//       );
//     }
//   }

// PICK IMAGE
  // Future<void> _onPickImage(
  //   PickImageEvent event,
  //   Emitter<GetUserDetailState> emit,
  // ) async {
  //   emit(
  //     GetDetailUserState(
  //       status: BlocStatusState.loading,
  //       viewModel: state.viewModel,
  //     ),
  //   );

  //   try {
  //     final imageFile = await selectFile(event.source ?? ImageSource.gallery);
  //     final newViewModel = state.viewModel.copyWith(imageFile: imageFile);
  //     emit(state.copyWith(
  //       status: BlocStatusState.success,
  //       viewModel: newViewModel,
  //     ));
  //   } catch (e) {
  //     emit(
  //       state.copyWith(
  //         status: BlocStatusState.failure,
  //         viewModel: state.viewModel,
  //       ),
  //     );
  //   }
  // }

  Future<void> _onGetUserDetail(
    GetUserDetailEvent event,
    Emitter<GetUserDetailState> emit,
  ) async {
    emit(
      GetDetailUserState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );

    try {
      List<String> listImageUrl = [
        "https://121quotes.com/wp-content/uploads/2020/03/Cristiano-Ronaldo-Wallpaper-HD-For-Free-Download.jpg",
        'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/LeBron_James_%2851959977144%29_%28cropped2%29.jpg/800px-LeBron_James_%2851959977144%29_%28cropped2%29.jpg'
      ];
      List<XFile> listImageFile = await _downloadImage(listImageUrl);
      final response =
          await _userUserDetailCase.getUserDetailEntity(event.userId);
      final newViewModel = state.viewModel
          .copyWith(userDetailEntity: response, imageFiles: listImageFile);
      emit(state.copyWith(
        status: BlocStatusState.success,
        viewModel: newViewModel,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: BlocStatusState.failure,
          viewModel: state.viewModel,
        ),
      );
    }
  }

  Future<void> _onImageChanged(
    ImageChangedEvent event,
    Emitter<GetUserDetailState> emit,
  ) async {
    emit(
      GetDetailUserState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );

    try {
      final newViewModel =
          state.viewModel.copyWith(imageFiles: event.imageFiles);

      emit(state.copyWith(
        status: BlocStatusState.success,
        viewModel: newViewModel,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: BlocStatusState.failure,
          viewModel: state.viewModel,
        ),
      );
    }
  }

  Future<void> _onDeleteUser(
    DeleteUserEvent event,
    Emitter<GetUserDetailState> emit,
  ) async {
    emit(
      DeleteUserState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      await _userUserDetailCase.deleteUserEntity(event.userId);
      emit(
        DeleteUserState(
          status: BlocStatusState.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BlocStatusState.failure,
          viewModel: state.viewModel,
        ),
      );
    }
  }

  Future<void> _onUpdateUser(
    UpdateUserEvent event,
    Emitter<GetUserDetailState> emit,
  ) async {
    emit(
      UpdateUserState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      await _userUserDetailCase.updateUserEntity(event.userId, event.user);

      final newViewModel = state.viewModel
          .copyWith(userDetailEntity: state.viewModel.userDetailEntity);
      emit(state.copyWith(
        status: BlocStatusState.success,
        viewModel: newViewModel,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: BlocStatusState.failure,
          viewModel: state.viewModel,
        ),
      );
    }
  }

  selectFile(ImageSource source) async {
    if (source == ImageSource.camera) {
      await [
        Permission.camera,
      ].request();
      final pickedFile = await ImagePicker().pickImage(
        source: source,
      );
      if (pickedFile != null) {
        return pickedFile;
      }
    }
    if (source == ImageSource.gallery) {
      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        return pickedFile;
      }
    }
    return null;
  }

  Future<List<XFile>> _downloadImage(List<String> urls) async {
    List<XFile> imageList = [];
    for (var url in urls) {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final documentDirectory = await getTemporaryDirectory();
        final filePath =
            '${documentDirectory.path}/${DateTime.now().millisecondsSinceEpoch.toString()}.png';
        File file1 = File(filePath);
        await file1.writeAsBytes(response.bodyBytes);
        XFile xfile1 = XFile(file1.path);
        imageList.add(xfile1);
      }
    }

    return imageList;
  }
}
