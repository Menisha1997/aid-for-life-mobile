import 'package:ambulance_app_v1/const/app_image_const.dart';
import 'package:ambulance_app_v1/const/app_size_const.dart';
import 'package:ambulance_app_v1/global.dart' as global;
import 'package:ambulance_app_v1/models/app_user_model.dart';
import 'package:ambulance_app_v1/services/api_service.dart';
import 'package:ambulance_app_v1/views/user/dashboard/home_page.dart';
import 'package:ambulance_app_v1/widgets/custom_button_widget.dart';
import 'package:ambulance_app_v1/widgets/custom_paint_widget.dart';
import 'package:ambulance_app_v1/widgets/custom_text_form_field_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/progress_HUD.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isAPICallProcess = false;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _nic = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _bloodGroup = TextEditingController();

  void signUp() {}

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: _isAPICallProcess,
      child: Scaffold(
        body: CustomPaint(
          size: MediaQuery.of(context).size,
          painter: BackGroundPainter(context),
          child: Padding(
            // ignore: prefer_const_constructors
            padding: const EdgeInsets.all(AppSize.DEFAULT_PADDING),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Image.asset(
                    AppImage.LOGIN_ICON,
                    height: 60,
                  ),

                  // login box
                  const SizedBox(
                    height: 05,
                  ),

                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 20,
                    ),
                  ),

                  CustomTextFormField(
                    controller: _fullname,
                    label: "Full Name",
                    type: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid full name';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    controller: _nic,
                    label: "NIC",
                    type: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid NIC';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    controller: _phone,
                    label: "Ph-No",
                    type: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid phone';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    controller: _dob,
                    label: "DateOfBirth",
                    type: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid full name';
                      }
                      return null;
                    },
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Date format must be yyyy/mm/dd",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  CustomTextFormField(
                    controller: _gender,
                    label: "Gender",
                    type: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid full name';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    controller: _bloodGroup,
                    label: "Blood Group",
                    type: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid full name';
                      }
                      return null;
                    },
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
                    height: 15,
                  ),
                  CustomButton(
                    lable: "Register",
                    onPressed: () {
                      signup();
                    },
                  ),
                  CustomButton(
                    lable: "Back",
                    onPressed: () {
                      Navigator.of(context).pop();
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

  void signup() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    AppUser data = AppUser(
      email: _email.text.trim(),
      bloodGroup: _bloodGroup.text.trim(),
      dateOfBirth: _dob.text.trim(),
      fullName: _fullname.text.trim(),
      gender: _gender.text.trim(),
      nic: _nic.text.trim(),
      password: _password.text.trim(),
      phoneNo: _phone.text.trim(),
    );

    setState(() {
      _isAPICallProcess = true;
    });
    FocusScope.of(context).requestFocus(FocusNode());
    APIService().signup(data).then((value) {
      setState(() {
        _isAPICallProcess = false;
      });
      if (value.id != null) {
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
            content: Text("Something went wrong"),
          ),
        );
      }
    });
  }
}
