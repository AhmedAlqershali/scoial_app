import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoial_app/firebase/fb_likes_controller.dart';
import 'package:scoial_app/firebase/fb_storePost_controller.dart';
import 'package:scoial_app/firebase/fb_store_Edit_users_controller.dart';
import 'package:scoial_app/models/likes_models.dart';
import 'package:scoial_app/models/usersStoreEdit_models.dart';
import 'package:scoial_app/models/users_post_models.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key}) : super(key: key);
   LikesModel? likesModel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [

            Expanded(
              child: Container(
                child: StreamBuilder<QuerySnapshot<UsersPostModels>>(
                    stream: FbStorePostController().getPostUsers(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        return ListView.builder(

                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {

                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Card(

                                  elevation: 10,
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Column(


                                    children: [


                                      Row(
                                        children: [
                                          SizedBox(

                                            width: 10,
                                          ),
                                          Expanded(

                                              child: StreamBuilder<QuerySnapshot<UsersStoreEditModels>>(
                                                  stream: FbStoreEditUsersController().getEditUsers(),
                                                  builder: (context, snapshot){
                                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                                      return Center(child: CircularProgressIndicator());
                                                    } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                                                      return SizedBox(
                                                        height: 40,
                                                        child: ListView.builder(
                                                            itemCount: snapshot.data!.docs.length,
                                                            itemBuilder: (context, index) {
                                                              return Row(
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
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Icon(
                                                                    Icons.check_circle,
                                                                    color: Colors.blue,
                                                                    size: 16,
                                                                  )
                                                                ],
                                                              );
                                                            }),
                                                      );


                                                    } else {
                                                      return Center(
                                                        child: Text(''),
                                                      );
                                                    }
                                                  })
                                          ),
                                          Text(
                                            snapshot.data!.docs[index].data().dateTime!,
                                            style: GoogleFonts.nunito(
                                                color: Colors.grey, height: 1.4),
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.more_horiz,
                                                size: 16,
                                              )),
                                        ],
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 15),
                                        child: Container(
                                          width: double.infinity,
                                          height: 1,
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index].data().text!,
                                        style: GoogleFonts.nunito(
                                          color: Colors.black,
                                          height: 1.3,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                      Container(
                                        height: 140.0,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  snapshot.data!.docs[index].data().imagePost!),
                                              fit: BoxFit.contain,

                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                        child: Row(

                                          children: [

                                            Expanded(
                                              child: InkWell(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.favorite,size: 16,color: Colors.red ,),
                                                      SizedBox(width: 5,),
                                                      Text('1200',style: GoogleFonts.nunito(color: Colors.grey),)
                                                    ],
                                                  ),
                                                ),onTap: (){},),
                                            ),
                                            Spacer(),
                                            Expanded(
                                              child: InkWell(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.chat,size: 16,color: Colors.red ,),
                                                      Text('1200 Comment',style: GoogleFonts.nunito(color: Colors.grey),)
                                                    ],
                                                  ),
                                                ),onTap: (){},),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: Container(
                                          width: double.infinity,
                                          height: 1,
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            InkWell(

                                              child: Row(
                                                children: [
                                                  SizedBox(

                                                    child: StreamBuilder<QuerySnapshot<UsersStoreEditModels>>(
                                                        stream: FbStoreEditUsersController().getEditUsers(),
                                                        builder: (context, snapshot) {
                                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                                            return Center(child: CircularProgressIndicator());
                                                          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                                                            return ListView.builder(
                                                                itemCount: 1,
                                                                itemBuilder: (context, index) {
                                                                  return CircleAvatar(
                                                                        radius: 15,
                                                                        backgroundImage: NetworkImage(
                                                                            snapshot.data!.docs[index].data().images!),
                                                                      );



                                                                });
                                                          } else {
                                                            return Center(
                                                              child: Text(''),
                                                            );
                                                          }
                                                        }),
                                                    width: 45,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      'write a comment ...',
                                                      style: GoogleFonts.nunito(
                                                          color: Colors.grey),
                                                    ),
                                                    margin: EdgeInsets.only(bottom: 20),
                                                  ),
                                                ],
                                              ),












                                              onTap: (){




                                              },

                                            ),
                                            SizedBox(
                                              width: 120,
                                            ),

                                            Container(
                                              margin: EdgeInsets.only(bottom: 20),

                                              child: InkWell(

                                                child: Row(
                                                  children: [
                                                    Icon(Icons.favorite,size: 16,color: Colors.red ,),
                                                    SizedBox(width: 5,),
                                                    Text('Like',style: GoogleFonts.nunito(color: Colors.grey),)
                                                  ],
                                                ),
                                                onTap: (){},),
                                            ),

                                          ],
                                        ),
                                      )

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
                    }),
              ),
            ),
            SizedBox(height: 15,)







          ],
        ),

    );
  }






  int? taplikes(){
    if (LikesModel().likes == null) {
      return LikesModel().likes;
    }
    int count = 0;
    setState(() {
      if (LikesModel().boolLikes == true) {

        count += 1;
        LikesModel().likes = count;
      }else{
        LikesModel().likes =count;
      }

    });

    return LikesModel().likes;
  }





}
