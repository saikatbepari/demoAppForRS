import 'dart:convert';
import 'package:exercise_app/helper/Urls.dart';
import 'package:http/http.dart' as http;
import 'package:exercise_app/models/photo.dart';
import 'package:exercise_app/widgets/CircularProgress.dart';
import 'package:exercise_app/widgets/GridTilesPhotos.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

Photos photos;

class PhotosList extends StatefulWidget {
  final String slug;


  PhotosList({Key key, this.slug}) : super(key: key);

  @override
  _PhotosListState createState() => _PhotosListState();
}

class _PhotosListState extends State<PhotosList> {
  int pageNumberB = 1;
  int totalCountB = 0;
  int totalPagesB = 0;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCategoryList(widget.slug, pageNumberB),
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('No Internet');
          case ConnectionState.waiting:
            return CircularProgress();
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              return createListView(context, snapshot);
        }
      },
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    Photos list = snapshot.data;
    List<Photo> results = list.photos;
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            primary: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            padding: EdgeInsets.all(1.0),
            /*childAspectRatio: 8.0 / 9.0,*/
            children: List<Widget>.generate(results.length, (index) {
              if(results[index].imageUrl == null){
                results[index].imageUrl = 'dummy.jpg';
              }
              return GridTile(
                  child: GridTilesPhotos(
                    name: results[index].name,
                    photographer: results[index].photographer,
                    imageUrl: results[index].imageUrl,
                    slug: results[index].name,
                  )
              );
            }),
          ),
          Divider(height: 1.0, color: Color(0xFFe2e2e2),thickness: 1.0,),
          Padding(
            padding:  EdgeInsets.all(20),
            child: Column(
              children: [
                Text((totalCountB <21) ? 'Showing all $totalCountB results.' :'Showing Page '+(pageNumberB).toString()+' of '+(totalPagesB).toString()+' (Total: $totalCountB results).'),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      OutlineButton(
                          borderSide: BorderSide(color: Color(0xFFe1e5e8)),
                          onPressed: (){
                            if((pageNumberB > totalPagesB) || (pageNumberB > 0)){
                              setState(() {
                                pageNumberB--;
                              });
                            }
                            else{
                              Toast.show("Page 1 Reached.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                            }
                          },
                          color: Color(0xFFe1e5e8),
                          textColor: Color(0xFFe1e5e8),
                          child: Container(
                            height: 30.0,
                            child: Center(
                              child: Text('Previous Page',
                                  style: TextStyle(fontSize: 15.0, fontFamily: 'Brand-Bold', color: Color(0xFF383635))),
                            ),
                          )
                      ),
                      RaisedButton(
                        onPressed: (){
                          if(pageNumberB < totalPagesB){
                            setState(() {
                              pageNumberB++;
                            });
                          }
                          else{
                            Toast.show("Page "+(totalPagesB).toString()+" Reached.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                          }
                        },
                        color: Color(0xFFd16608),
                        textColor: Colors.white,
                        child: Container(
                          height: 30,
                          child: Center(
                            child: Text(
                              'Next Page',
                              style: TextStyle(fontSize: 15, fontFamily: 'Poppins-Bold'),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<Photos> getCategoryList(String slug, int page) async {
    print('Page: $page');
    if (photos == null) {
      final response = await http.get(
          Urls.ROOT_URL + slug + '?page=$page&per_page=20',
          headers: {
            'content-type': 'application/json',
            'Authorization': '563492ad6f917000010000012af6b33c3cb84220abb8aacf83110a5c',
          }
      );
      print(response.toString());
      int statusCode = response.statusCode;
      var body = json.decode(response.body);

      if (statusCode == 200) {
        photos = Photos.fromJson(body);
        totalCountB = photos.count;
        totalPagesB = totalCountB~/20;

        print('total count: $totalCountB');
        print('total pages: $totalPagesB');
        return photos;
      }
    } else {
      return photos;
    }
  }
}
