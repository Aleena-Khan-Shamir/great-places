import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sys_path;

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onSelectedImage});
  final Function onSelectedImage;
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  Future<void> _takePicture() async {
    final imageFile = (await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 600));

    if (imageFile != null) {
      final File file = File(imageFile.path);

      setState(() {
        _storedImage = file;
      });

      final appDir = await sys_path.getApplicationDocumentsDirectory();
      final fileName = path.basename(imageFile.path);
      final savedImage = await file.copy('${appDir.path}/$fileName');

      widget.onSelectedImage(savedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 130,
          width: 130,
          decoration: BoxDecoration(border: Border.all()),
          child: _storedImage == null
              ? const Center(child: Text('No image taken'))
              : Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                ),
        ),
        TextButton.icon(
            onPressed: _takePicture,
            icon: const Icon(Icons.camera),
            label: const Text('Take picture'))
      ],
    );
  }
}
