import 'package:alumni_database/profiles/profile_model.dart';
import 'package:alumni_database/profiles/profile_notifier.dart';
import 'package:alumni_database/views/header.dart';
import 'package:alumni_database/views/profile/about_card.dart';
import 'package:alumni_database/views/profile/connect_card.dart';
import 'package:alumni_database/views/profile/education_card.dart';
import 'package:alumni_database/views/profile/experience_card.dart';
import 'package:alumni_database/views/profile/intro_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({required this.profileID});

  final String profileID;

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {

  late ProfileModel profile;

  @override
  void initState() {
    super.initState();
    profile = ref.read(profilesProvider.notifier).getProfile(widget.profileID);
  }

  @override
  Widget build(BuildContext context) {
    print(profile);
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Header(),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    IntroCard(profile: profile),
                    const SizedBox(height: 20),
                    AboutCard(profile: profile),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3425,
                          child: EducationCard(profile: profile),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3425,
                          child: ExperienceCard(profile: profile),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: const Text(
                        'View more on LinkedIn',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
                const SizedBox(width: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    ConnectCard(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
