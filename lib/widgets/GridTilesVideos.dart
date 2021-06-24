import 'dart:developer';
import 'package:exercise_app/screens/VideoPlayerScreen.dart';
import 'package:flutter/material.dart';


class GridTilesVideos extends StatelessWidget {
  String name;
  String imageUrl;
  String slug;
  String videoUrl;
  String userName;

  GridTilesVideos(
      {Key key,
        @required this.name,
        @required this.imageUrl,
        @required this.slug,
        @required this.videoUrl,
        @required this.userName,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Identifier: '+slug);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoPlayerScreen(
                  ref: name,
                  videoUrl: videoUrl,
                  userName: userName,
                )),
          );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width/2,
          height: MediaQuery.of(context).size.height/2,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: <Widget>[
              Image.network(
                imageUrl,
                width: MediaQuery.of(context).size.width/2,
                height: MediaQuery.of(context).size.height/2,
                fit: BoxFit.cover,
              ),
              Container(
                color: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(name, style: TextStyle(fontSize: 28, color: Colors.white)),
                    Text(userName, style: TextStyle(fontSize: 22, color: Colors.white)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
