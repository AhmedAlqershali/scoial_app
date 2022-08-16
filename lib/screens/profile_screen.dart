import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoial_app/firebase/fb_store_Edit_users_controller.dart';
import 'package:scoial_app/firebase/fb_storeuser_auth_contraller.dart';
import 'package:scoial_app/models/usersAuth.dart';
import 'package:scoial_app/models/usersStoreEdit_models.dart';
import 'package:scoial_app/screens/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);
  UsersStoreEditModels? _usersStoreEditModels;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<UsersStoreEditModels>>(
          stream: FbStoreEditUsersController().getEditUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            height: 190,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.topCenter,
                                  child: Container(
                                    height: 140,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(4),
                                            topLeft: Radius.circular(4))),
                                    child: Image.network(
                                      snapshot.data!.docs[index].data().cover!,
                                      fit: BoxFit.cover,
                                      height: 200.0,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                    radius: 64,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundImage: NetworkImage(snapshot
                                          .data!.docs[index]
                                          .data()
                                          .images!),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            snapshot.data!.docs[index].data().name!,
                            style: GoogleFonts.nunito(
                                color: Colors.black, fontSize: 18),
                          ),
                          Text(
                            getusers.bio!,
                            style: GoogleFonts.nunito(
                                color: Colors.grey, fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        Text(
                                          '100 ',
                                          style: GoogleFonts.nunito(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          'Posts ',
                                          style: GoogleFonts.nunito(
                                              color: Colors.grey, fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        Text(
                                          '253 ',
                                          style: GoogleFonts.nunito(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          'Photos ',
                                          style: GoogleFonts.nunito(
                                              color: Colors.grey, fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        Text(
                                          '10k ',
                                          style: GoogleFonts.nunito(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          'Followers ',
                                          style: GoogleFonts.nunito(
                                              color: Colors.grey, fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        Text(
                                          '65 ',
                                          style: GoogleFonts.nunito(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          'Followings ',
                                          style: GoogleFonts.nunito(
                                              color: Colors.grey, fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Add Photos',
                                    style: GoogleFonts.nunito(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(double.infinity, 40),
                                      primary: Colors.white,
                                      elevation: 0),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  onPressed: () => Get.to(EditProfileScreen()),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(double.infinity, 40),
                                      primary: Colors.white,
                                      elevation: 0),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  });
            } else {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      height: 190,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(4),
                                      topLeft: Radius.circular(4))),
                              child: Image.network(
                                'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png',
                                fit: BoxFit.cover,
                                height: 200.0,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          CircleAvatar(
                              radius: 64,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage('https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png'),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),


                    Text(
                      'name',
                      style: GoogleFonts.nunito(
                          color: Colors.black, fontSize: 18),
                    ),

                    Text(
                      getusers.bio!,
                      style: GoogleFonts.nunito(
                          color: Colors.grey, fontSize: 14),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    '100 ',
                                    style: GoogleFonts.nunito(
                                        color: Colors.black,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    'Posts ',
                                    style: GoogleFonts.nunito(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    '253 ',
                                    style: GoogleFonts.nunito(
                                        color: Colors.black,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    'Photos ',
                                    style: GoogleFonts.nunito(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    '10k ',
                                    style: GoogleFonts.nunito(
                                        color: Colors.black,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    'Followers ',
                                    style: GoogleFonts.nunito(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    '65 ',
                                    style: GoogleFonts.nunito(
                                        color: Colors.black,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    'Followings ',
                                    style: GoogleFonts.nunito(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'Add Photos',
                              style: GoogleFonts.nunito(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 40),
                                primary: Colors.white,
                                elevation: 0),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () => Get.to(EditProfileScreen()),
                            child: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 40),
                                primary: Colors.white,
                                elevation: 0),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
  UsersStoreEditModels get getusers {
    UsersStoreEditModels users = UsersStoreEditModels();
    UsersAuth usersAuth = UsersAuth();
    if (widget._usersStoreEditModels != null) {
      users.uId = widget._usersStoreEditModels!.uId;
    }
    users.bio=users.bio;

    users.bio='Write Bio';


    return users;
  }
}
