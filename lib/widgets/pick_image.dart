import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:html' as html;

class PickImage extends StatefulWidget {
  final void Function(List<int>?, String name) callBack;
  const PickImage({Key? key, required this.callBack}) : super(key: key);

  @override
  PickImageState createState() => PickImageState();
}

class PickImageState extends State<PickImage> {
  XFile? photo;
  Uint8List? webImage;
  List<int>? selectedFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white70,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(0.0, 0.5),
            blurRadius: 30.0,
          )
        ],
      ),
      width: 100,
      height: 100,
      child: Center(
        child: webImage == null
            ? MaterialButton(
                onPressed: pickImage,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Center(
                    child: Image.network(
                      "https://static.thenounproject.com/png/3322766-200.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )
            : Container(
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: Image.memory(
                    webImage!,
                    height: 100.0,
                    width: 100.0,
                  ),
                ),
              ),
      ),
    );
  }

  // Future<void> pickImage() async {
  //   photo = await _picker.pickImage(source: ImageSource.gallery);

  //   if (photo != null) {
  //     webImage = await photo!.readAsBytes();
  //     setState(() {});
  //   }
  // }

  Future<void> pickImage() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = html.FileReader();

      reader.onLoadEnd.listen((event) {
        setState(() {
          webImage = const Base64Decoder()
              .convert(reader.result.toString().split(",").last);
          selectedFile = webImage;
          widget.callBack(selectedFile, files[0].name);
          print(files[0].name);
        });
      });
      reader.readAsDataUrl(file);
    });
  }
}
