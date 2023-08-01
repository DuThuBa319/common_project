part of 'custom_image_picker.dart';

// ignore: library_private_types_in_public_api
extension ImagePickerAction on _ImagePickerWithGridViewState {

  Future<XFile?> sourceCamera(ImageSource source) async {
    final pickedFile =
        await picker.pickImage(imageQuality: 100, source: source);
    return pickedFile;
  }

  Future<XFile?> sourceGallery(ImageSource source) async {
    final pickedFile =
        await picker.pickImage(imageQuality: 100, source: source);
    return pickedFile;
  }

// Chọn ảnh từ thư mục trong folder assets
  Future<List<XFile?>> pickImagesFromAssetFolder(String folderPath) async {
    final List<String> imagePaths =
        await AssetImagePicker.pickImagePathsFromAssetFolder(folderPath);
    final pickedFiles =
        <XFile?>[];     // Tạo một danh sách rỗng để lưu trữ các XFile
    for (final imagePath in imagePaths) {
      final byteData = await rootBundle.load(
          imagePath);   // hàm  rootBundle.load Tải hình ảnh như là một ByteData
      final uint8List =
          byteData.buffer.asUint8List(); // Chuyển đổi ByteData thành Uint8List
      final tempDir =
          await getTemporaryDirectory(); // Lấy đường dẫn thư mục tạm thời
      final tempPath =
          '${tempDir.path}/${basename(imagePath)}'; // Đường dẫn tạm thời cho hình ảnh
      await File(tempPath)
          .writeAsBytes(uint8List); // Ghi Uint8List vào tệp tạm thời
      pickedFiles.add(
          XFile(tempPath)); // Thêm XFile mới vào danh sách các XFile đã chọn
    }
    return pickedFiles; // Trả về danh sách các XFile đã chọn
  }

  void selectSource(BuildContext context) async {
    await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.19,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  if (widget.isOnTapActive == true) {
                    final pickedFile = await sourceGallery(ImageSource.gallery);
                    if (pickedFile != null) {
                      // ignore: invalid_use_of_protected_member
                      setState(() {
                        imageList.add(pickedFile);
                        showToast('Pick image successfully');
                      });
                    }
                  }
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  if (widget.isOnTapActive == true) {
                    final pickedFile = await sourceCamera(ImageSource.camera);
                    if (pickedFile != null) {
                      // ignore: invalid_use_of_protected_member
                      setState(() {
                        imageList.add(pickedFile);
                        showToast('Pick image successfully');
                      });
                    }
                  }
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Asset Folder'),
                onTap: () async {
                  if (widget.isOnTapActive == true) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          // Các thuộc tính và nội dung của AlertDialog
                          content: TextField(
                              controller: TextEditingController(
                                  text: "lib/assets/images/"),
                              onChanged: (value) => widget.folderPath = value),
                          actions: <Widget>[
                            // Các button trong AlertDialog
                            TextButton(
                              child: const Text('Huỷ'),
                              onPressed: () {
                                Navigator.pop(context);
                                // Xử lý khi người dùng nhấn nút Huỷ
                              },
                            ),
                            TextButton(
                                child: const Text('Pick Image'),
                                onPressed: () async {
                                  print(widget.folderPath);
                                  if (widget.folderPath != "") {
                                    final pickedFiles =
                                        await pickImagesFromAssetFolder(
                                            widget.folderPath!);
                                    // ignore: invalid_use_of_protected_member
                                    setState(() {
                                      imageList.addAll(pickedFiles);
                                      showToast('Pick image successfully');

                                      // ignore: list_remove_unrelated_type
                                    });
                                  } else {
                                    Navigator.pop(context);
                                  }
                                  // ignore: invalid_use_of_protected_member

                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(
                                      context); // Xử lý khi người dùng nhấn nút OK
                                }),
                          ],
                        );
                      },
                    );
                  }
                  // ignore: use_build_context_synchronously
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void deleteImage(int index) {
    // ignore: invalid_use_of_protected_member
    setState(() {
      imageList.removeAt(index);
    });
  }
}

class AssetImagePicker {
  /*pickImagePathsFromAssetFolder nhận đầu vào là đường dẫn của thư mục folder và 
  trả về một Future<List<String>> chứa danh sách các đường dẫn hình ảnh 
  trong thư mục tương ứng.*/
  static Future<List<String>> pickImagePathsFromAssetFolder(
      String folderPath) async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    return manifestMap.keys
        .where((String key) => key.startsWith(folderPath))
        .toList();
    // mục đích ==> lấy danh sách các đường dẫn hình ảnh
  }
}
