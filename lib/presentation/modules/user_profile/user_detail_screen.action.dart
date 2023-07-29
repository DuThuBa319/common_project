part of 'user_detail_screen.dart';

// ignore: library_private_types_in_public_api
extension UserDetailScreenAction on _UserDetailScreenState {
  void _blocListener(BuildContext context, GetUserDetailState state) {
    // Các phần code khác không thay đổi
  }

  // Future<void> _pickImage(ImageSource source, int index) async {
  //   final pickedImage = await imagePicker.pickImage(
  //       source: source); // ignore: invalid_use_of_protected_member
  //   if (pickedImage != null) {
  //     // ignore: invalid_use_of_protected_member
  //     setState(() {
  //       _images[index] = File(pickedImage.path);
  //       _imagePath = pickedImage.path;
  //     });
  //   } else {
  //     showToast('No image selected');
  //   }
  // }

  // void selectSource(BuildContext context, int index) async {
  //   await showModalBottomSheet<ImageSource>(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Container(
  //           height: MediaQuery.of(context).size.height * 0.26,
  //           decoration: const BoxDecoration(
  //               borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(30),
  //             topRight: Radius.circular(30),
  //           )),
  //           child: Wrap(
  //             children: [
  //               ListTile(
  //                 leading: const Icon(Icons.photo_library),
  //                 title: const Text('Gallery'),
  //                 onTap: () {
  //                   _pickImage(ImageSource.gallery, index);
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //               ListTile(
  //                 leading: const Icon(Icons.camera_alt),
  //                 title: const Text('Camera'),
  //                 onTap: () {
  //                   _pickImage(ImageSource.camera, index);
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //               ListTile(
  //                 leading: const Icon(Icons.drive_file_rename_outline_sharp),
  //                 title: const Text('Edit file name'),
  //                 onTap: () {
  //                   showDialog(
  //                     context: context,
  //                     builder: (context) {
  //                       return AlertDialog(
  //                         title: const Text('Submit new file'),
  //                         content: TextField(
  //                           onChanged: (value) {
  //                            folderPath.text = value;
  //                           },
  //                           decoration: const InputDecoration(
  //                               hintText: "New file name"),
  //                         ),
  //                         actions: [
  //                           ElevatedButton(
  //                             child: const Text('SUBMIT'),
  //                             onPressed: () {
  //                               // // Lấy dữ liệu của ảnh cũ
  //                               // final Uint8List imageBytes =
  //                               //     await _images[index]!.readAsBytes();
  //                               // String oldFilePath = _images[index]!.path;

  //                               // // Xóa ảnh cũ
  //                               // File oldImageFile = File(oldFilePath);
  //                               // await oldImageFile.delete();

  //                               // // Tạo tên mới cho ảnh
  //                               // String fileName = fileNameController
  //                               //         .text.isNotEmpty
  //                               //     ? fileNameController.text
  //                               //     : 'image_${DateTime.now().millisecondsSinceEpoch}';

  //                               // // Tạo thư mục cho đường dẫn mới
  //                               // Directory newDir =
  //                               //     await getTemporaryDirectory();
  //                               // String newFilePath =
  //                               //     '${newDir.path}/$fileName.jpg';

  //                               // // Đổi tên file và lưu vào đường dẫn mới
  //                               // File newImageFile =
  //                               //     await _images[index]!.copy(newFilePath);

  //                               // setState(() {
  //                               //   _images[index] = newImageFile;
  //                               // });

  //                               Navigator.of(context).pop();
  //                             },
  //                           ),
  //                         ],
  //                       );
  //                     },
  //                   );
  //                 },
  //               ),
  //               ListTile(
  //                 leading: const Icon(Icons.delete),
  //                 title: const Text('Remove'),
  //                 onTap: () {
  //                   // ignore: invalid_use_of_protected_member
  //                   setState(() {
  //                     _images[index] = null;
  //                   });
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  //   return;
  // }
}
