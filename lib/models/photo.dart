class Photos{
  int count;
  String next;
  List<Photo> photos;

  Photos({this.count, this.next, this.photos});

  Photos.fromJson(Map<String, dynamic> json) {
    count = json['total_results'];
    next = json['next_page'];
    if (json['photos'] != null) {
      // ignore: deprecated_member_use
      photos = new List<Photo>();
      json['photos'].forEach((v) {
        photos.add(new Photo.fromJson(v));
      });
    }
  }
}

class Photo{
  String name;
  String imageUrl;
  String photographer;
  String photographerUrl;
  bool isFav;

  Photo({this.name, this.imageUrl, this.photographer, this.photographerUrl, this.isFav});

  Photo.fromJson(Map<String, dynamic> json) {
    name = json['id'].toString();
    imageUrl = json['src']['original'];
    photographer = json['photographer'];
    photographerUrl = json['photographer_url'];
    isFav = json['liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['photographer'] = this.photographer;
    data['photographerUrl'] = this.photographerUrl;
    data['isFav'] = this.isFav;
    return data;
  }
}