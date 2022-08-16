class UsersAuth {
   String? uId;
   String? name;
   String? email;
   String? phone;




   UsersAuth();


   UsersAuth.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    email = map['email'];
    phone = map['phone'];

  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;

    return map;
  }


}
