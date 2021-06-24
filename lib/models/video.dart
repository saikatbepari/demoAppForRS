class Videos{
  int page;
  int perPage;
  int count;
  String url;
  List<Video> videos;

  Videos({this.page,this.perPage,this.count, this.url, this.videos});

  Videos.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    count = json['total_results'];
    url = json['url'];
    if (json['videos'] != null) {
      // ignore: deprecated_member_use
      videos = new List<Video>();
      json['videos'].forEach((v) {
        videos.add(new Video.fromJson(v));
      });
    }
  }
}

class Video{
  String name;
  String videoUrl;
  String image;
  String userName;
  String userUrl;
  bool isFav;

  Video({this.name, this.videoUrl, this.image, this.userName, this.isFav});

  Video.fromJson(Map<String, dynamic> json) {
    name = json['id'].toString();
    videoUrl = json['video_files'][0]['link'];
    image = json['image'];
    userName = json['user']['name'];
    userUrl = json['user']['url'];
    isFav = json['liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['videoUrl'] = this.videoUrl;
    data['image'] = this.image;
    data['userName'] = this.userName;
    data['userUrl'] = this.userUrl;
    data['isFav'] = this.isFav;
    return data;
  }
}