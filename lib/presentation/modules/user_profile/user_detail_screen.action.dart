part of 'user_detail_screen.dart';

// ignore: library_private_types_in_public_api
extension UserDetailScreenAction on _UserDetailScreenState {
  void _blocListener(BuildContext context, GetUserDetailState state) {
    // Các phần code khác không thay đổi
  }

  Future<void> downloadAndSaveImage(String imageUrl, String fileName) async {
    var response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      final Directory directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/assets/$fileName';

      final File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      print('Hình ảnh đã được tải xuống và lưu thành công!');

      // Đổi tên nếu cần thiết
      String newFileName = 'new_$fileName';
      String newPath = '${directory.path}/assets/$newFileName';

      await file.rename(newPath);

      print('Hình ảnh đã được đổi tên thành công!');
    } else {
      print('Lỗi khi tải xuống hình ảnh!');
    }
  }
  
}
