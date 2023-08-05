part of 'user_detail_screen.dart';

// ignore: library_private_types_in_public_api
extension UserDetailScreenAction on _UserDetailScreenState {
  void _blocListener(BuildContext context, GetUserDetailState state) {
    // Các phần code khác không thay đổi
  }

  Future<List<XFile>> _downloadImage(List<String> url) async {
    final response1 = await http.get(Uri.parse(url[0]));
    final response2 = await http.get(Uri.parse(url[1]));

    if (response1.statusCode == 200) {
      final documentDirectory = await getTemporaryDirectory();
      final filePath =
          '${documentDirectory.path}/${DateTime.now().millisecondsSinceEpoch.toString()}.png';
      File file1 = File(filePath);
      await file1.writeAsBytes(response1.bodyBytes);
      XFile xfile1 = XFile(file1.path);
      setState(() {
        imageList.add(xfile1);
      });
      print(imageList);
    }

    if (response2.statusCode == 200) {
      final documentDirectory = await getTemporaryDirectory();
      final filePath =
          '${documentDirectory.path}/${DateTime.now().millisecondsSinceEpoch.toString()}.png';
      File file2 = File(filePath);
      await file2.writeAsBytes(response2.bodyBytes);
      XFile xfile2 = XFile(file2.path);
      setState(() {
        imageList.add(xfile2);
      });
      print(imageList);
    }
    return imageList;
  }

  // Future<void> saveImageToGallery(String imageUrl) async {
  //   final response = await http.get(Uri.parse(imageUrl));
  //   if (response.statusCode == 200) {
  //     Directory directory = await getTemporaryDirectory();
  //     String fileName = 'ronaldo.jpg';
  //     File file = File('${directory.path}/$fileName');
  //     await file.writeAsBytes(response.bodyBytes);
  //     final result = await ImageGallerySaver.saveFile(file.path);
  //     if (result['isSuccess']) {
  //       showToast("Saving successfullu");
  //     } else {
  //       showToast("Saving failed");
  //     }
  //   }
  // }
  Future<void> saveImageToGallery(String imageUrl) async {
    var response = await Dio()
        .get(imageUrl, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "Cr7.png");
    print(result);
  }
}

  // Future<void> downloadAndSaveImage(String imageUrl) async {
  //   // Lấy thư mục gốc của dự án
  //   final directory = await getApplicationDocumentsDirectory();
  //   final projectDirectory = directory.path;

  //   // Tạo đường dẫn và tên file cho hình ảnh
  //   const fileName = 'example.png';
  //   final filePath = '$projectDirectory/$fileName';
  //   print(filePath);
  //   // Kiểm tra xem hình ảnh đã tồn tại chưa, nếu đã tồn tại thì không cần tải lại
  //   if (await File(filePath).exists()) {
  //     return;
  //   }

  //   // Tải xuống hình ảnh từ mạng
  //   final response = await http.get(Uri.parse(imageUrl));

  //   if (response.statusCode == 200) {
  //     // Lưu hình ảnh vào tệp tin trong thư mục của dự án
  //     final file = File(filePath);
  //     await file.writeAsBytes(response.bodyBytes);

  //     print('Hình ảnh đã được tải xuống và lưu vào $filePath');
  //   } else {
  //     throw Exception('Không thể tải xuống hình ảnh từ $imageUrl');
  //   }
  // }
  

