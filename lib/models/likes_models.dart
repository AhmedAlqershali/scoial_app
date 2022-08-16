class LikesModel {
  String? uId;
  int? likes;
  bool boolLikes=false;




  LikesModel();


  LikesModel.fromMap(Map<String, dynamic> map) {
    likes = map['likes'];
    boolLikes = map['boolLikes'];

  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['likes'] = likes;
    map['boolLikes'] = boolLikes;

    return map;
  }


}
