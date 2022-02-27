import 'package:alumni_database/profiles/profile_model.dart';
import 'package:alumni_database/views/profile/education_model.dart';
import 'package:flutter/material.dart';

// List<EducationModel> sampleEducationInfo = [
//   EducationModel(
//     name: 'Stanford University',
//     url: 'http://identity.stanford.edu/wp-content/uploads/2020/07/SU_New_BlockStree_2color_darkbgrd.png',
//     startDate: 2000,
//     endDate: 2003,
//     tagline: 'Billionaire in training',
//   ),
//   EducationModel(
//     name: 'Indiana University',
//     url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/Indiana_Hoosiers_logo.svg/300px-Indiana_Hoosiers_logo.svg.png',
//     startDate: 2000,
//     endDate: 2003,
//     tagline: 'Millionaire in training',
//   ),
// ];

class EducationCard extends StatelessWidget {
  const EducationCard({required this.profile});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.675,
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
            'Education',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: profile.education.length,
            itemBuilder: (context, index) {
              return EducationTile(profile.education[index]);
            },
          )
        ],
      ),
    );
  }

  Widget EducationTile(EducationModel education) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 25,
      leading: Image(
        image: NetworkImage(education.url),
      ),
      title: Text(
        education.name,
      ),
      subtitle: Text(
        education.tagline,
      ),
    );
  }
}
