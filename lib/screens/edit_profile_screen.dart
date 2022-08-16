import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:scoial_app/firebase/fb_storage_Controllar.dart';
import 'package:scoial_app/firebase/fb_store_Edit_users_controller.dart';
import 'package:scoial_app/firebase/fb_storeuser_auth_contraller.dart';
import 'package:scoial_app/models/usersAuth.dart';
import 'package:scoial_app/models/usersStoreEdit_models.dart';
import 'package:scoial_app/utils/helpers.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  UsersStoreEditModels? _usersStoreEditModels;
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> with Helpers {
  UploadTask? task1;
  File? file1;
  UploadTask? task2;
  File? file2;

  late TextEditingController _nameTextController;
  late TextEditingController _bioTextController;


  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController(text: widget._usersStoreEditModels?.name);
    _bioTextController = TextEditingController(text: widget._usersStoreEditModels?.bio);

  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _bioTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Edit Profile',
          style: GoogleFonts.nunito(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => uploadFile(),
              child: Text(
                'Update',
                style: GoogleFonts.nunito(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body:  ListView.builder(
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
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              if (file1 != null)
                                Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight:
                                          Radius.circular(4),
                                          topLeft:
                                          Radius.circular(4))),
                                  child: Image.file(
                                    File(file1!.path),
                                    fit: BoxFit.cover,
                                    height: 200.0,
                                    width: double.infinity,
                                  ),
                                )
                              else
                                Container(
                                    height: 140,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight:
                                            Radius.circular(4),
                                            topLeft:
                                            Radius.circular(4))),
                                    child: Image.network(
                                      'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png',
                                      fit: BoxFit.cover,
                                      height: 200.0,
                                      width: double.infinity,
                                    )),
                              IconButton(
                                  onPressed: () => selectFile1(),
                                  icon: CircleAvatar(
                                    radius: 20,
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 16,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            if (file2 != null)
                              CircleAvatar(
                                radius: 64,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: FileImage(
                                    File(file2!.path),
                                  ),
                                ),
                              )
                            else
                              CircleAvatar(
                                radius: 64,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                    radius: 60,
                                    backgroundImage: NetworkImage(
                                        'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png')),
                              ),

                            IconButton(
                                onPressed: () => selectFile2(),
                                icon: CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 16,
                                  ),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                      controller: _nameTextController,
                      keyboardType: TextInputType.name,
                      style: GoogleFonts.nunito(
                        color: Colors.black45,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_sharp),
                        hintText: UsersAuth().name,
                        hintMaxLines: 1,
                        hintTextDirection: TextDirection.ltr,
                        hintStyle: GoogleFonts.nunito(
                          color: Colors.black45,
                          fontWeight: FontWeight.w300,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.blue,
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                      controller: _bioTextController,
                      keyboardType: TextInputType.name,
                      style: GoogleFonts.nunito(
                        color: Colors.black45,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.info_outline_rounded),
                        hintText: 'Bio',
                        hintMaxLines: 1,
                        hintTextDirection: TextDirection.ltr,
                        hintStyle: GoogleFonts.nunito(
                          color: Colors.black45,
                          fontWeight: FontWeight.w300,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.blue,
                          ),
                        ),
                      )),



                ],
              ),
            );
          })
    );
  }

  void uploadFile() async {
    await uploadFile1();
    await uploadFile2();
    await _save();
  }

  Future selectFile1() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file1 = File(path));
  }

  Future selectFile2() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file2 = File(path));
  }

  Future<void> uploadFile1() async {
    if (file1 == null) return;

    final fileName = basename(file1!.path);
    final destination = 'Images/CoverProfaile/$fileName';
    task1 =
    Fb_Storage_Controllar.uploadFile(destination, file1!);

    final snapshot1 = await task1!.whenComplete(() {});
    final urlDownload1 = await snapshot1.ref.getDownloadURL();


    print('Download-Link: $urlDownload1');
  }

  Future<void> uploadFile2() async {
    if (file2 == null) return;

    final fileName = basename(file2!.path);
    final destination = 'Images/ImagesProfaile/$fileName';
    task2 =
        Fb_Storage_Controllar.uploadFile(destination, file2!);

    final snapshot2 = await task2!.whenComplete(() {});
    final urlDownload2 = await snapshot2.ref.getDownloadURL();


    print('Download-Link: $urlDownload2');


  }

  Future<void> _save() async {
    widget._usersStoreEditModels==null
    ? await FbStoreEditUsersController().create(usersStoreEditModels: await Editusers)
        : await FbStoreEditUsersController().updateEditUsers(updatedUsersEdit: await Editusers);
  }


  Future<UsersStoreEditModels> get Editusers async{
    UsersStoreEditModels users = UsersStoreEditModels();
    if (widget._usersStoreEditModels != null) {
      users.uId = widget._usersStoreEditModels!.uId;
    }
    final snapshot1 = await task1!.whenComplete(() {});
    final urlDownload1 = await snapshot1.ref.getDownloadURL();

    final snapshot2 = await task2!.whenComplete(() {});
    final urlDownload2 = await snapshot2.ref.getDownloadURL();
    users.name=_nameTextController.text;
    users.bio=_bioTextController.text;
    users.images=urlDownload2;
    users.cover=urlDownload1;





    return users;
  }


}
