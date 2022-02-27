import 'package:alumni_database/profiles/profile_model.dart';
import 'package:alumni_database/views/profile/education_model.dart';
import 'package:alumni_database/views/profile/experience_model.dart';
import 'package:flutter/material.dart';
//
// List<ExperienceModel> sampleExperienceInfo = [
//   ExperienceModel(
//     name: 'Stanford University',
//     url: 'http://identity.stanford.edu/wp-content/uploads/2020/07/SU_New_BlockStree_2color_darkbgrd.png',
//     startDate: 2000,
//     endDate: 2003,
//     tagline: 'Billionaire in training',
//   ),
//   ExperienceModel(
//     name: 'Indiana University',
//     url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/Indiana_Hoosiers_logo.svg/300px-Indiana_Hoosiers_logo.svg.png',
//     startDate: 2000,
//     endDate: 2003,
//     tagline: 'Millionaire in training',
//   ),
// ];

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({required this.profile});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Experience',
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
            itemCount: profile.experience.length,
            itemBuilder: (context, index) {
              return ExperienceTile(profile.experience[index]);
            },
          )
        ],
      ),
    );
  }

  Widget ExperienceTile(ExperienceModel experience) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 25,
      leading: Image(
        image: NetworkImage(experience.url),
      ),
      title: Text(
        experience.tagline,
      ),
      subtitle: Text(
        experience.name,
      ),
    );
  }
}
