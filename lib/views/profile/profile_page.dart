// ignore_for_file: deprecated_member_use

import 'package:ambulance_app_v1/views/auth/signin_screen.dart';
import 'package:ambulance_app_v1/views/auth/signup_screen.dart';
import 'package:ambulance_app_v1/views/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import '../../widgets/subheading_widget.dart';
import 'package:ambulance_app_v1/global.dart' as global;

// ignore: must_be_immutable
class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Info",
          style: TextStyle(
            color: Color.fromARGB(255, 252, 252, 252),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
            icon: const Icon(
              Icons.logout_rounded,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignIn()),
              );
            }),

        ///////////////////////////////// Edit//////////
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => EditProfile(
                        appUserData: global.currentUser,
                      )));
            },
          ),
        ],
      ),

      /////////body///////
      body: ListView(
        padding: const EdgeInsets.only(left: 16, top: 0, right: 16),
        children: [
          const SizedBox(
            height: 70,
          ),
          const Text(
            "User Details",
            style: TextStyle(
              color: Color.fromARGB(255, 6, 97, 6),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            "Full Name",
            style: TextStyle(
              color: Color.fromARGB(255, 6, 97, 6),
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "${global.currentUser.fullName!.toUpperCase()} ",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Email Address",
            style: TextStyle(
              color: Color.fromARGB(255, 6, 97, 6),
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "${global.currentUser.email!.toUpperCase()} ",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "NIC Number",
            style: TextStyle(
              color: Color.fromARGB(255, 6, 97, 6),
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "${global.currentUser.nic!.toUpperCase()} ",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Phone Number",
            style: TextStyle(
              color: Color.fromARGB(255, 6, 97, 6),
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "${global.currentUser.phoneNo!.toUpperCase()} ",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Date of Birth",
            style: TextStyle(
              color: Color.fromARGB(255, 6, 97, 6),
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "${global.currentUser.dateOfBirth!.toUpperCase()} ",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Gender",
            style: TextStyle(
              color: Color.fromARGB(255, 6, 97, 6),
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "${global.currentUser.gender!.toUpperCase()} ",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Blood Group",
            style: TextStyle(
              color: Color.fromARGB(255, 6, 97, 6),
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "${global.currentUser.bloodGroup!.toUpperCase()} ",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  signOut() {
    // _authState.signOut();
  }
}
