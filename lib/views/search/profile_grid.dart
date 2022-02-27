import 'package:alumni_database/profiles/profile_model.dart';
import 'package:alumni_database/user/edit_profile.dart';
import 'package:alumni_database/views/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';

class ProfileGrid extends StatefulWidget {
  const ProfileGrid(this.profiles, this.crossAxisCount);

  final List<ProfileModel> profiles;
  final int crossAxisCount;

  @override
  _ProfileGridState createState() => _ProfileGridState();
}

class _ProfileGridState extends State<ProfileGrid> {

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      itemCount: widget.profiles.length,
      itemBuilder: (context, index) {
        return profileCard(widget.profiles[index]);
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,
      ),
    );
  }

  Widget profileCard(ProfileModel profile) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: HoverButton(
        onpressed: () {
          // showDialog(
          //   context: context,
          //   // barrierDismissible: false, // user must tap button!
          //   builder: (BuildContext context) {
          //     return const EditProfileModal(profileID: '0');
          //   },
          // );
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => ProfileView(profileID: profile.id),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return child;
            },
          ));
        },
        // height: 500,
        elevation: 0,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey.shade100, width: 1.5),
        ),
        color: Colors.white,
        hoverColor: Colors.white,
        hoverElevation: 1.5,
        splashColor: Colors.grey[50],
        child: Container(
          height: 600,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            // border: Border.all(color: Colors.grey.shade100, width: 1.5)
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.grey.shade50, width: 3),
                    color: Colors.white
                  ),
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(profile.avatarURL),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${profile.firstName} ${profile.lastName}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  profile.tagline,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  child: Container(
                    height: 38,
                    width: 140,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // padding: EdgeInsets.symmetric(horizontal: 15),
                    child: const Center(
                      child: Text(
                        'Send Message',
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.001
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
