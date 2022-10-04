import 'package:ambulance_app_v1/const/app_image_const.dart';
import 'package:ambulance_app_v1/const/app_size_const.dart';
import 'package:ambulance_app_v1/services/api_service.dart';
import 'package:ambulance_app_v1/views/auth/signup_screen.dart';
import 'package:ambulance_app_v1/views/dashboard/home_page.dart';
import 'package:ambulance_app_v1/widgets/custom_button_widget.dart';
import 'package:ambulance_app_v1/widgets/custom_paint_widget.dart';
import 'package:ambulance_app_v1/widgets/custom_text_form_field_widget.dart';
import 'package:ambulance_app_v1/widgets/progress_HUD.dart';
import 'package:flutter/material.dart';
import 'package:ambulance_app_v1/global.dart' as global;

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isAPICallProcess = false;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: _isAPICallProcess,
      child: Scaffold(
        body: CustomPaint(
          size: MediaQuery.of(context).size,
          painter: BackGroundPainter(context),
          child: Padding(
            padding: const EdgeInsets.all(AppSize.DEFAULT_PADDING),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Image.asset(
                    AppImage.LOGIN_ICON,
                    height: 150,
                  ),

                  // login box
                  const SizedBox(
                    height: 100,
                  ),
                  const Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 20,
                    ),
                  ),
                  CustomTextFormField(
                    controller: _email,
                    label: "Email",
                    type: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid full name';
                      }
                      return null;
                    },
                  ),
                  CustomFormPasswordField(
                    controller: _password,
                    label: "Password",
                    type: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: AppSize.DEFAULT_SPACE,
                  ),
                  CustomButton(
                    lable: "Sign in",
                    onPressed: () => login(),
                  ),
                  CustomButton(
                    lable: "Sign Up",
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignUp()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void loginTemp() {
  //   Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (BuildContext context) => const HomePage()));
  // }

  void login() {
    if (_formKey.currentState!.validate()) {
      Map<String, String> data = {
        "email": _email.text.trim(),
        "password": _password.text.trim()
      };

      setState(() {
        _isAPICallProcess = true;
      });
      FocusScope.of(context).requestFocus(FocusNode());

      APIService().login(data).then((value) {
        setState(() {
          _isAPICallProcess = false;
        });
        if (value != null) {
          global.currentUser = value;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Welcome " + value.fullName.toString()),
            ),
          );
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const HomePage()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("The email or password is incorrect"),
            ),
          );
        }
      });
    }
  }
}
