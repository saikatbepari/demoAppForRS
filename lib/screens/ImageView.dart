import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatefulWidget {
  String name;
  String imageUrl;
  String photographer;

   ImageView({Key key, this.name, this.imageUrl, this.photographer}) : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(widget.name),
      ),
      body: Container(
          child: PhotoView(
            imageProvider: NetworkImage(widget.imageUrl),
          )
      ),
    );
  }
}
