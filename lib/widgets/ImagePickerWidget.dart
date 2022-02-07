import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:olx/form/cat_provider.dart';
import 'package:provider/provider.dart';
import 'package:galleryimage/galleryimage.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _image = null;
  final picker = ImagePicker();
  bool _uploading = false;

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<CategoryProvider>(context);

    Future<String> uploadFile() async {
      File file = File(_image!.path);
      String imagename =
          'productImage/${DateTime.now().microsecondsSinceEpoch}';
      String downloadUrl = '';
      try {
        await FirebaseStorage.instance.ref(imagename).putFile(file);
        downloadUrl =
            await FirebaseStorage.instance.ref(imagename).getDownloadURL();
        if (downloadUrl != null) {
          setState(() {
            _image = null;
            _provider.getImages(downloadUrl);
            // print(_provider.urlList.length);
          });
        }
      } on FirebaseException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cancelled')),
        );
      }
      return downloadUrl;
    }

    Future getImage() async {
      final PickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        if (PickedFile != null) {
          _image = File(PickedFile.path);
        } else {
          print('No image selected');
        }
      });
    }

    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              'Upload Images',
              style: TextStyle(color: Colors.black),
            ),
          ),
          Column(
            children: [
              Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: FittedBox(
                  child: _image == null
                      ? Icon(
                          CupertinoIcons.photo_on_rectangle,
                          color: Colors.blueGrey,
                        )
                      : Image.file(_image!),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              if (_provider.urlList.length > 0)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: InkWell(
                    onTap: () {
                      print(_provider.urlList.length);
                    },
                    child: GalleryImage(
                      imageUrls: _provider.urlList,
                    ),
                  ),
                ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: NeumorphicButton(
                          style: NeumorphicStyle(
                            color: Colors.green.shade100,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_image != null) {
                                _uploading = true;
                                uploadFile().then((url) {
                                  if (url != null) {
                                    setState(() {
                                      _uploading = false;
                                    });
                                  }
                                });
                              }
                            });
                          },
                          child: Text(
                            'Save',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          )),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: NeumorphicButton(
                          style: NeumorphicStyle(
                            color: Colors.red.shade100,
                          ),
                          onPressed: () {
                            setState(() {
                              _image = null;
                            });
                          },
                          child: Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NeumorphicButton(
                        onPressed: () {
                          getImage();
                        },
                        style: NeumorphicStyle(
                          color: Colors.greenAccent,
                        ),
                        child: Center(
                          child: Text(
                            _provider.urlList.length > 0
                                ? 'Upload more Images'
                                : 'Upload Images',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              if (_uploading)
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
                )
            ],
          )
        ],
      ),
    );
  }
}
