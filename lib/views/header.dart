import 'package:alumni_database/user/edit_profile.dart';
import 'package:alumni_database/views/search/search.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const Search(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return child;
                },
              ));
            },
            child: const Image(
              height: 50,
              width: 50,
              image: AssetImage('assets/ptlogo.jpg'),
            ),
          ),
          const SizedBox(width: 15),
          const Text(
            'Park Tudor Alumni Directory',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          const Spacer(),
          const Text(
            'Welcome, Zach!',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(width: 15),
          const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/SeniorPhotoHeadshot.jpg'),
          ),
          const SizedBox(width: 10),
          PopupMenuButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.expand_more),
            onSelected: (value) {
              if(value == 'Edit') {
                showDialog(
                  context: context,
                  useRootNavigator: false,
                  // barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return const EditProfileModal(profileID: '0');
                  },
                );
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  child: Text('Edit your profile'),
                  value: "Edit",
                ),
                PopupMenuItem(
                  child: Text('Account settings'),
                ),
                PopupMenuItem(
                  child: Text('Help'),
                ),
                PopupMenuItem(
                  child: Text('Sign Out'),
                )
              ];
            },
          ),
        ],
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
    );
  }
}
