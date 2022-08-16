import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoial_app/firebase/fb_store_Edit_users_controller.dart';
import 'package:scoial_app/models/usersStoreEdit_models.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot<UsersStoreEditModels>>(
              stream: FbStoreEditUsersController().getEditUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  return StreamBuilder<QuerySnapshot<UsersStoreEditModels>>(
                      stream: FbStoreEditUsersController().getEditUsers(),
                      builder: (context, snapshot){
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 85,
                                  child: Card(
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage: NetworkImage(
                                              snapshot.data!.docs[index].data().images!),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          snapshot.data!.docs[index].data().name!,
                                          style: GoogleFonts.nunito(
                                              color: Colors.black, height: 1.4),
                                        ),



                                      ],
                                    ),
                                  ),
                                );

                              });


                        } else {
                          return Center(
                            child: Text(''),
                          );
                        }
                      });



                } else {
                  return Center(
                    child: Text(''),
                  );
                }
              }),


      ),
    );
  }
}
