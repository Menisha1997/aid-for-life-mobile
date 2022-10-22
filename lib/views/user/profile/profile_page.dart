// ignore_for_file: deprecated_member_use

import 'package:ambulance_app_v1/global.dart' as global;
import 'package:ambulance_app_v1/views/user/job_requests/all_jobs_of_user.dart';
import 'package:ambulance_app_v1/views/user/profile/edit_profile.dart';
import 'package:ambulance_app_v1/widgets/subheading_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.logout_rounded,
          ),
          onPressed: () => signOut(),
        ),
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
      body: ListView(
        padding: const EdgeInsets.only(left: 16, top: 0, right: 16),
        children: [
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
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
          const SubHeadingRow(icon: Icons.person, lable: "My Account"),
          const Divider(
            height: 15,
            thickness: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          listButton(context, Icons.shopping_cart, "Requests", () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AllJobRequests()),
            );
          }),
          const SizedBox(
            height: 40,
          ),
          const SubHeadingRow(
            icon: Icons.extension_sharp,
            lable: "For more",
          ),
          const Divider(
            height: 15,
            thickness: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          listButton(context, Icons.question_mark_rounded, "Get Help", () {}),
        ],
      ),
    );
  }

  Widget listButton(
    BuildContext context,
    IconData icon,
    String lable,
    VoidCallback onPressed,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 4, bottom: 4),
      alignment: Alignment.topLeft,
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        // color: Colors.white70,
        // border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
            ),
            const SizedBox(
              width: 15,
            ),
            Container(
              //color: Colors.amberAccent,
              alignment: Alignment.center,
              child: Text(
                lable,
                maxLines: 2,
                style: Theme.of(context).textTheme.button!.copyWith(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  signOut() {
    // _authState.signOut();
  }
}
