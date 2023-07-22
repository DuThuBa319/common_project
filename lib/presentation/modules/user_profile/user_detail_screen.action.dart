part of 'user_detail_screen.dart';

// ignore: library_private_types_in_public_api
extension UserDetailScreenAction on _UserDetailScreenState {
  void _blocListener(BuildContext context, GetUserDetailState state) {
    if (state is GetDetailUserState &&
        state.status == BlocStatusState.loading) {
      showToast('Is loading User');
    }

    if (state is GetDetailUserState &&
        state.status == BlocStatusState.success) {
      showToast('Get User Successfully');
    }

    if (state is UpdateUserState && state.status == BlocStatusState.success) {
      detailBloc.add(GetUserDetailEvent(userId: widget.id));
      showToast('Update User Successfully');
    }

    if (state is DeleteUserState && state.status == BlocStatusState.success) {
      widget.userBloc.add(GetListUserEvent());
      showToast('Delete User Successfully');

      Navigator.pop(context);
    }
  }

  Future<void> _pickImage(ImageSource source, int index) async {
    final pickedImage = await imagePicker.pickImage(
        source: source); // ignore: invalid_use_of_protected_member
    if (pickedImage != null) {
      // ignore: invalid_use_of_protected_member
      setState(() {
        _images[index] = File(pickedImage.path);
        _imagePath = pickedImage.path;
        // fileNameController.text = pickedImage.name ?? '';
      });
    } else {
      showToast('No image selected');
    }
  }

  void selectSource(BuildContext context, int index) async {
    await showModalBottomSheet<ImageSource>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.26,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () {
                    _pickImage(ImageSource.gallery, index);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Camera'),
                  onTap: () {
                    _pickImage(ImageSource.camera, index);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.drive_file_rename_outline_sharp),
                  title: const Text('Edit dit file name'),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Submit new file'),
                            content: TextField(
                              onChanged: (value) {
                                fileNameController.text = value;
                              },
                              decoration: const InputDecoration(
                                  hintText: " New file name"),
                            ),
                            actions: [
                              ElevatedButton(
                                  child: const Text('SUBMIT'),
                                  onPressed: () async {
                                    final Uint8List imageBytes =
                                        await _images[index]!.readAsBytes();
                                    String fileName = fileNameController
                                            .text.isNotEmpty
                                        ? fileNameController.text
                                        : 'image_${DateTime.now().millisecondsSinceEpoch}';
                                    final result =
                                        await ImageGallerySaver.saveImage(
                                            isReturnImagePathOfIOS: true,
                                            imageBytes,
                                            name: fileName);
                                    if (result['isSuccess']) {
                                      print('Lưu hình ảnh thành công!');
                                      // ignore: invalid_use_of_protected_member
                                    } else {
                                      print('Lưu hình ảnh thất bại.');
                                    }

                                    // 2 DÒNG NÀY EM ĐỂ XÓA FILE CŨ NHƯNG KHÔNG LÀM ĐƯỢC
                                    File oldImageFile =
                                        File(_images[index]!.path);
                                    await oldImageFile.delete();

                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).pop();
                                  }),
                            ],
                          );
                        });

                    // ignore: invalid_use_of_protected_member
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Remove'),
                  onTap: () {
                    // ignore: invalid_use_of_protected_member
                    setState(() {
                      _images[index] = null;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
    return;
  }
}
