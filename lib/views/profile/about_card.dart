import 'package:alumni_database/profiles/profile_model.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class AboutCard extends StatelessWidget {
  const AboutCard({required this.profile});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.69,
      // height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 10),
          ExpandableText(
            profile.bio == '' ? '${profile.firstName} has not added a bio yet.' : profile.bio,
            maxLines: 3,
            expandText: 'view more',
            animationDuration: const Duration(seconds: 1),
            collapseText: 'view less',
            linkColor: Colors.black,
            linkStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13
            ),
            animation: true,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
