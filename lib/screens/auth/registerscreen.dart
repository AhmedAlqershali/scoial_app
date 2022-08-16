import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoial_app/firebase/fb_auth_controllar.dart';
import 'package:scoial_app/firebase/fb_storeuser_auth_contraller.dart';
import 'package:scoial_app/models/firebase_response.dart';
import 'package:scoial_app/models/usersAuth.dart';
import '../../utils/helpers.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key,this.users}) : super(key: key);

  UsersAuth? users;


  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers {


  late TextEditingController _nameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _phoneTextController;

  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _phoneError;
  bool _showPassword = false;

  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _phoneTextController = TextEditingController();

    _tapGestureRecognizer = TapGestureRecognizer()..onTap = _navigateToRegister;
    // _tapGestureRecognizer.onTap = _navigateToRegister;
  }

  void _navigateToRegister() =>
      Navigator.pushNamed(context, '/register_screen');

  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _phoneTextController.dispose();
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 28,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Register ',
              style: GoogleFonts.nunito(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Register now to communicate with firends',
              style: GoogleFonts.nunito(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            TextField(
              controller: _nameTextController,
              keyboardType: TextInputType.name,
              enabled: true,
              style: GoogleFonts.nunito(
                color: Colors.black45,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
              expands: true,
              minLines: null,
              maxLines: null,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: 'Name',
                hintMaxLines: 1,
                hintTextDirection: TextDirection.ltr,
                hintStyle: GoogleFonts.nunito(
                  color: Colors.black45,
                  fontWeight: FontWeight.w300,
                ),
                errorText: _nameError,
                constraints: BoxConstraints(
                  // minHeight: 50,
                  maxHeight: _nameError == null ? 55 : 75,
                ),
                prefixIcon: Icon(Icons.person),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            TextField(
              controller: _emailTextController,
              keyboardType: TextInputType.emailAddress,
              enabled: true,
              style: GoogleFonts.nunito(
                color: Colors.black45,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
              expands: true,
              minLines: null,
              maxLines: null,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: 'Email',
                hintMaxLines: 1,
                hintTextDirection: TextDirection.ltr,
                hintStyle: GoogleFonts.nunito(
                  color: Colors.black45,
                  fontWeight: FontWeight.w300,
                ),
                prefixIcon: Icon(Icons.email),
                errorText: _emailError,
                constraints: BoxConstraints(
                  // minHeight: 50,
                  maxHeight: _emailError == null ? 55 : 75,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: _passwordTextController,
              keyboardType: TextInputType.text,
              minLines: 1,
              maxLines: 1,
              expands: false,
              style: GoogleFonts.nunito(
                color: Colors.black45,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
              obscureText: !_showPassword,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: 'Password',
                hintMaxLines: 1,
                hintTextDirection: TextDirection.ltr,
                hintStyle: GoogleFonts.nunito(
                  color: Colors.black45,
                  fontWeight: FontWeight.w300,
                ),
                prefixIcon: Icon(Icons.lock),
                errorText: _passwordError,
                constraints: BoxConstraints(
                  // minHeight: 50,
                  maxHeight: _passwordError == null ? 55 : 75,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                  icon: Icon(
                    _showPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _phoneTextController,
              keyboardType: TextInputType.number,
              minLines: 1,
              maxLines: 1,
              expands: false,
              style: GoogleFonts.nunito(
                color: Colors.black45,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: 'Phone',
                hintMaxLines: 1,
                hintTextDirection: TextDirection.ltr,
                hintStyle: GoogleFonts.nunito(
                  color: Colors.black45,
                  fontWeight: FontWeight.w300,
                ),
                errorText: _phoneError,
                constraints: BoxConstraints(
                  // minHeight: 50,
                  maxHeight: _phoneError == null ? 55 : 75,
                ),
                prefixIcon: Icon(Icons.phone),

                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => performRegister(),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff00C569),
                  minimumSize: const Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              child: Text(
                'SIGN IN',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performRegister()async {
    if (checkData()) {
      await Register();
       await _save();
       await FbAuthControllar().signOut();
    }
  }

  bool checkData() {
    if (_nameTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty&&
        _phoneTextController.text.isNotEmpty) {
      updateErrorsState();

      return true;
    }

    updateErrorsState();
    return false;
  }

  void updateErrorsState() {
    setState(() {
      _nameError = _nameTextController.text.isEmpty ? 'Enter your Name' : null;
      _emailError =
      _emailTextController.text.isEmpty ? 'Enter email address' : null;
      _passwordError =
      _passwordTextController.text.isEmpty ? 'Enter your password' : null;
      _phoneError =
      _phoneTextController.text.isEmpty ? 'Enter your phone' : null;
    });
  }

  Future<void> Register() async {
    FirebaseResponse firebaseResponse = await FbAuthControllar().createAccount(
        email: _emailTextController.text,
        password: _passwordTextController.text

    );

    showSnackBar(
      context,
      message: firebaseResponse.message,
      error: !firebaseResponse.success,
    );
    if (firebaseResponse.success) Navigator.pop(context);
  }

  Future<void> _save()async{
    bool status= widget.users==
        await FbStoreuserAuthContraller().create(users: _users);


    if (status) {
      widget.users == null ? clear() : Navigator.pop(context);
    }

  }





  UsersAuth get _users {
    UsersAuth users = UsersAuth();
    if (widget.users != null) {
      users.uId = widget.users!.uId;
    }
    users.name=_nameTextController.text;
    users.email=_emailTextController.text;
    users.phone=_phoneTextController.text;

    return users;
  }



  void clear() {
    _nameTextController.text = '';
    _emailTextController.text = '';
    _passwordTextController.text = '';
    _phoneTextController.text = '';
  }
}
