part of 'user_detail_screen.dart';

// ignore: library_private_types_in_public_api
extension UserDetailScreenAction on _UserDetailScreenState {
  void _blocListener(BuildContext context, GetUserDetailState state) {
    if (state is UpdateUserState && state.status == BlocStatusState.success) {
      detailBloc.add(GetUserDetailEvent(userId: widget.id));
      showToast('Update User Successfully');
    }
    if (state is DeleteUserState && state.status == BlocStatusState.success) {
      widget.userBloc.add(GetListUserEvent());
      showToast('Delete User Successfully');

      Navigator.pop(context);
    }
    if (state is GetDetailUserState &&
        state.status == BlocStatusState.success) {
      UserEntity user = state.viewModel.userDetailEntity!;

      showToast('Get User Successfully');
    }
  }

  Future<ImageSource?> selectSource() async {
    await showModalBottomSheet<ImageSource>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.21,
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
                    _pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Camera'),
                  onTap: () {
                    _pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Remove'),
                  onTap: () {
                    setState(() {
                      _imagePath = null;
                      _image = null;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
    return null;
  }
}

