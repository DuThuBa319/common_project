import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'dialog/show_toast.dart';
part "custom_image_picker_action.dart";

// ignore: must_be_immutable
class ImagePickerWithGridView extends StatefulWidget {
  final List<XFile> imageFiles;
  final bool? isOnTapActive;
  final Function(List<XFile>) onImageRemoved;

  const ImagePickerWithGridView(
      {Key? key,
      required this.imageFiles,
      required this.isOnTapActive,
      required this.onImageRemoved})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ImagePickerWithGridViewState createState() =>
      _ImagePickerWithGridViewState();
}

class _ImagePickerWithGridViewState extends State<ImagePickerWithGridView> {
  final picker = ImagePicker();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _convertImagesToXFiles();
  //   print(imageFiles);
  // }
  late List<XFile> _imageFiles;

  @override
  void initState() {
    super.initState();
    // Sao chép danh sách ban đầu
  }

  @override
  Widget build(BuildContext context) {
    _imageFiles = List.from(widget.imageFiles);
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 15,
        mainAxisSpacing: 20,
        crossAxisCount: 2,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.imageFiles.length + 1,
      itemBuilder: (context, index) {
        if (index == widget.imageFiles.length) {
          return Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20),
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.blue),
                  borderRadius: BorderRadiusDirectional.circular(20),
                ),
                child: const Icon(Icons.people_alt_outlined,
                    color: Colors.blue, size: 50),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 4, color: Colors.white),
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.only(left: 120, top: 120),
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      side: const BorderSide(width: 2, color: Colors.blue),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    icon: const Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      if (widget.isOnTapActive == true) {
                        selectSource(context);
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        } else {
          return Stack(
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 20),
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.blue),
                    borderRadius: BorderRadiusDirectional.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    child: widget.imageFiles[index] != null
                        ? FullScreenWidget(
                            disposeLevel: DisposeLevel.Medium,
                            child: Image.file(
                              File(widget.imageFiles[index].path),
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.people_alt_outlined,
                            color: Colors.blue, size: 50),
                  )),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 4, color: Colors.white),
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.only(left: 120, top: 120),
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: IconButton(
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      if (widget.isOnTapActive == true) {
                        deleteImage(index);
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
