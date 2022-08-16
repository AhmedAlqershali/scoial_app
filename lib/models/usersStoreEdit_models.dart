class UsersStoreEditModels {
  String? uId;
  String? name;
  String? bio;
  String? images;
  String? cover;




  UsersStoreEditModels();


  UsersStoreEditModels.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    bio = map['bio'];
    images = map['images'];
    cover = map['cover'];

  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name;
    map['bio'] = bio;
    map['images'] = images;
    map['cover'] = cover;

    return map;
  }


}
