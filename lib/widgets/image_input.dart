import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as systemPath;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput({
    Key key,
    this.onSelectImage,
  }) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final _pickImage = ImagePicker();
    final _imageFile = await _pickImage.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (_imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(_imageFile.path);
    });

    final _appDir = await systemPath.getApplicationDocumentsDirectory();
    print('App Dir: ${_appDir.toString()}');

    final _fileName = path.basename(_imageFile.path);
    print('File Name: $_fileName');
    final _savedImage =
        await File(_imageFile.path).copy('${_appDir.path}/$_fileName');
    widget.onSelectImage(_savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: 150,
          height: 140,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).accentColor,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No Image'),
                    Icon(Icons.sentiment_dissatisfied),
                  ],
                ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture,
          ),
        )
      ],
    );
  }
}
