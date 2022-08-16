import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:scoial_app/firebase/fb_storage_Controllar.dart';
import 'package:scoial_app/firebase/fb_storePost_controller.dart';
import 'package:scoial_app/firebase/fb_store_Edit_users_controller.dart';
import 'package:scoial_app/models/usersAuth.dart';
import 'package:scoial_app/models/usersStoreEdit_models.dart';
import 'package:scoial_app/models/users_post_models.dart';



class PostScreen extends StatefulWidget {
  PostScreen({Key? key}) : super(key: key);
  UsersPostModels? _usersPostModels;
  UsersStoreEditModels? _usersStoreEditModels;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  UploadTask? task1;
  File? file1;

  late TextEditingController _TextController;

  @override
  void initState() {
    super.initState();
    _TextController = TextEditingController(text: widget._usersPostModels?.text);
  }

  @override
  void dispose() {
    _TextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<QuerySnapshot<UsersStoreEditModels>>(
          stream: FbStoreEditUsersController().getEditUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 1000,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20, top: 20),
                            child: Container(
                              height: 180,
                              child: Column(

                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundImage: NetworkImage(
                                            snapshot
                                            .data!
                                                .docs[index]
                                                .data()
                                                .images!
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          snapshot.data!.docs[index].data().name!,
                                          style: GoogleFonts.nunito(
                                              color: Colors.black, height: 1.4),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: _TextController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(


                                        hintText: 'What is on your mind . . .',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          if (file1 != null)
                            Container(
                              height: 500,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(4),
                                      topLeft: Radius.circular(4))),
                              child: Image.file(
                                File(file1!.path),
                                fit: BoxFit.cover,
                                height: 500.0,
                                width: double.infinity,
                              ),
                            )
                          else
                            Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(4),
                                      topLeft: Radius.circular(4))),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () => selectFile1(),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.image),
                                    ),
                                    Text('add Photo')
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: ElevatedButton(
                                    onPressed: () => save(),
                                    child: Text('Post'),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text(''),
              );
            }
          }),
    );
  }











  Future selectFile1() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file1 = File(path));
  }

  Future<void> uploadFile1() async {
    if (file1 == null) return;

    final fileName = basename(file1!.path);
    final destination = 'Images/PostImage/$fileName';
    task1 = Fb_Storage_Controllar.uploadFile(destination, file1!);

    final snapshot1 = await task1!.whenComplete(() {});
    final urlDownload1 = await snapshot1.ref.getDownloadURL();

    print('Download-Link: $urlDownload1');
  }

  void save() async {
    await uploadFile1();

    await FbStorePostController().create(UsersPostModels: await postModels);
  }




  Future<UsersPostModels> get postModels async{
    UsersPostModels postModels = UsersPostModels();
    if (widget._usersPostModels != null) {
      postModels.uId = widget._usersPostModels!.uId;
    }


    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd – kk:mm');
    String formattedDate = formatter.format(now);
    print(formattedDate);


    final snapshot1 = await task1!.whenComplete(() {});
    final urlDownload1 = await snapshot1.ref.getDownloadURL();




    postModels.text=_TextController.text;
    postModels.imagePost=urlDownload1;
    postModels.dateTime=formattedDate;



    return postModels;
  }
}
