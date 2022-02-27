import 'package:alumni_database/profiles/profile_model.dart';
import 'package:alumni_database/profiles/profile_notifier.dart';
import 'package:alumni_database/user/edit_profile.dart';
import 'package:alumni_database/views/filter/filter_view.dart';
import 'package:alumni_database/views/header.dart';
import 'package:alumni_database/views/search/profile_grid.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../responsive_layout_class.dart';
import 'filter_history.dart';

class Search extends ConsumerStatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {

  TextEditingController editingController = TextEditingController();

  late List<ProfileModel> profiles;

  @override
  void initState() {
    super.initState();
    //fetch profiles from provider
    ref.read(profilesProvider.notifier).getProfiles();
  }

  @override
  Widget build(BuildContext context) {
    //watch profiles provider and update profiles
    profiles = ref.watch(profilesProvider);

    //Sort profiles by first name
    profiles.sort((a, b) {
      return a.firstName.toLowerCase().compareTo(b.firstName.toLowerCase());
    });
    return Scaffold(
        backgroundColor: const Color(0xffF6F7FB),
        body: Column(
          children: [
            const Header(),
            const Divider(height: 1),
            Container(
              color: Colors.white,
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.69,
                        child: TextField(
                          onChanged: (value) {
                            // setState(() {
                            //   profiles = profileSampleData;
                            // });
                            // filterSearchResults(value);
                            if(value.length > 2) {
                              ref.read(profilesProvider.notifier).searchFilter(value);
                            }
                            else if(value.isEmpty) {
                              ref.read(profilesProvider.notifier).clear();
                            }
                          },
                          controller: editingController,
                          expands: false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffFAFAFA),
                            hoverColor: const Color(0xffFAFAFA),
                            hintText: 'Search',
                            contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                            prefixIcon: const Icon(
                              Icons.search,
                            ),
                            focusColor: const Color(0xffFAFAFA),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(color: Color(0xffFAFAFA))
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(color: Color(0xffFAFAFA))
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(color: Color(0xffFAFAFA))
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(color: Color(0xffFAFAFA))
                            ),
                          ),

                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          /*ref.read(profilesProvider.notifier).addState('Indiana');*/
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue,
                          ),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.0185),
                            child: const Center(
                              child: AutoSizeText(
                                'Search',
                                minFontSize: 10,
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilterHistory(),
                      // SizedBox(width: MediaQuery.of(context).size.width * 0.69),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          ref.read(profilesProvider.notifier).clear();
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade600),
                          ),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.015),
                            child: Center(
                              child: AutoSizeText(
                                'Clear Filters',
                                minFontSize: 10,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
            // const SearchArea(),
            // Container(
            //   height: MediaQuery.of(context).size.height * 0.1,
            //   color: Colors.white,
            // ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1, 8, MediaQuery.of(context).size.width * 0.1, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FilterView(),
                    profiles.isEmpty ? SizedBox(
                        width: MediaQuery.of(context).size.width * 0.595,
                        child: const Center(child: CircularProgressIndicator( color: Colors.blue))
                    ) : Expanded(
                      child: ResponsiveLayoutClass(
                        mobileView: ProfileGrid(profiles, 1),
                        tabletView: ProfileGrid(profiles, 2),
                        desktopView: ProfileGrid(profiles, 3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}
