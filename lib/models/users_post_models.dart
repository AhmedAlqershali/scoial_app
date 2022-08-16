class UsersPostModels {
  String? uId;
  String? imagePost;
  String? text;
  String? dateTime;





  UsersPostModels();


  UsersPostModels.fromMap(Map<String, dynamic> map) {
    imagePost = map['imagePost'];
    text = map['text'];
    dateTime = map['dateTime'];

  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['imagePost'] = imagePost;
    map['text'] = text;
    map['dateTime'] = dateTime;

    return map;
  }


}
