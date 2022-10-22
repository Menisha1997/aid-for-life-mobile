import 'package:ambulance_app_v1/const/app_size_const.dart';
import 'package:ambulance_app_v1/models/app_user_model.dart';
import 'package:ambulance_app_v1/services/api_service.dart';
import 'package:ambulance_app_v1/widgets/custom_button_widget.dart';
import 'package:ambulance_app_v1/widgets/custom_text_form_field_widget.dart';
import 'package:ambulance_app_v1/widgets/progress_HUD.dart';
import 'package:flutter/material.dart';
import 'package:ambulance_app_v1/global.dart' as global;

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.appUserData}) : super(key: key);

  final AppUser appUserData;
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isAPICallProcess = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  fetchUserData() {
    _fullname.text = widget.appUserData.fullName!;
    _nic.text = widget.appUserData.nic!;
    _phone.text = widget.appUserData.phoneNo!;
    _dob.text = widget.appUserData.dateOfBirth!;
    _gender.text = widget.appUserData.gender!;
    _bloodGroup.text = widget.appUserData.bloodGroup!;
  }

  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _nic = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _bloodGroup = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: _isAPICallProcess,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
        ),
        body: Padding(
          // ignore: prefer_const_constructors
          padding: const EdgeInsets.all(AppSize.DEFAULT_PADDING),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
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
                const SizedBox(
                  height: 15,
                ),
                CustomButton(
                  lable: "Save",
                  onPressed: () {
                    update();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void update() {
    if (_formKey.currentState!.validate()) {
      AppUser data = AppUser(
        email: widget.appUserData.email,
        bloodGroup: _bloodGroup.text.trim(),
        dateOfBirth: _dob.text.trim(),
        fullName: _fullname.text.trim(),
        gender: _gender.text.trim(),
        nic: _nic.text.trim(),
        password: widget.appUserData.password,
        phoneNo: _phone.text.trim(),
        id: widget.appUserData.id,
      );

      setState(() {
        _isAPICallProcess = true;
      });
      FocusScope.of(context).requestFocus(FocusNode());
      APIService().updateUserProfile(data).then((value) {
        setState(() {
          _isAPICallProcess = false;
        });
        if (value.id != null) {
          global.currentUser = value;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Successfully Saved"),
            ),
          );
          Navigator.of(context).pop();
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
}
