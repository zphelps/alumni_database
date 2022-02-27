import 'dart:convert';

import 'package:alumni_database/profiles/profile_model.dart';
import 'package:alumni_database/profiles/profile_notifier.dart';
import 'package:alumni_database/shared_widgets/decorations/searchDropdownDecoration.dart';
import 'package:alumni_database/shared_widgets/decorations/textFieldDecoration.dart';
import 'package:alumni_database/user/edit_school.dart';
import 'package:alumni_database/views/profile/education_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_textfield_autocomplete/flutter_textfield_autocomplete.dart';
import 'package:http/http.dart';

import '../const_data.dart';

class EditProfileModal extends ConsumerStatefulWidget {
  const EditProfileModal({required this.profileID});

  final String profileID;

  @override
  _EditProfileModalState createState() => _EditProfileModalState();
}

class _EditProfileModalState extends ConsumerState<EditProfileModal> {

  late ProfileModel profile;

  final _formKey = GlobalKey<FormState>();

  late String _selectedState;
  late String _selectedCountry;

  late ProfileModel profileToBeSaved;

  @override
  void initState() {
    super.initState();
    profile = ref.read(profileProvider(widget.profileID));
    profileToBeSaved = profile;
    _selectedState = profile.state;
    _selectedCountry = profile.country;
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(profilesProvider);
    return AlertDialog(
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(30),
          ),
          child: InkWell(
            onTap: () {
              _formKey.currentState!.save();
              if(_formKey.currentState!.validate()) {
                ref.read(profilesProvider.notifier).setProfile(profileToBeSaved);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.white,
                    content: const Text(
                      'Your profile has been updated.',
                      style: TextStyle(
                        color: Colors.black
                      ),
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
                Navigator.of(context).pop();
              }
            },
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0001,
              ),
            ),
          ),
        )
      ],
      contentPadding: EdgeInsets.zero,
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.85,
          child: SingleChildScrollView(
            child: Padding(
              padding: const AlertDialog().contentPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close,
                        ),
                      )
                    ],
                  ),
                  Divider(height: 20, color: Colors.grey[400],),
                  const SizedBox(height: 20),

                  TextFormField(
                    decoration: textFieldDecoration().copyWith(label: const Text('First Name*')),
                    initialValue: profile.firstName,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    onSaved: (value) {
                      setState(() {
                        profileToBeSaved.firstName = value ?? '';
                      });
                    },
                    validator: (value) {
                      if((value ?? '').isNotEmpty) {
                        return null;
                      }
                      return 'Please provide a valid first name.';
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: textFieldDecoration().copyWith(label: const Text('Last Name*')),
                    initialValue: profile.lastName,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    onSaved: (value) {
                      setState(() {
                        profileToBeSaved.lastName = value ?? '';
                      });
                    },
                    validator: (value) {
                      if((value ?? '').isNotEmpty) {
                        return null;
                      }
                      return 'Please provide a valid last name.';
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: textFieldDecoration().copyWith(label: const Text('Headline*')),
                    initialValue: profile.tagline,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    onSaved: (value) {
                      setState(() {
                        profileToBeSaved.tagline = value ?? '';
                      });
                    },
                    validator: (value) {
                      if((value ?? '').isNotEmpty) {
                        return null;
                      }
                      return 'Please provide a valid headline.';
                    },
                  ),

                  const Divider(height: 25),

                  const Text(
                    'Education',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  for (EducationModel education in profile.education)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xffFAFAFA),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              barrierDismissible: false,
                              barrierColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return EditSchoolModal(education: education, profileID: profile.id,);
                              });
                        },
                        child: Row(
                          children: [
                            Text(
                              education.name,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.edit,
                              color: Colors.grey[500],
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          barrierColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return EditSchoolModal(education: EducationModel.blank(), profileID: profile.id);
                          });
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.add,
                          size: 20,
                        ),
                        SizedBox(width: 2),
                        Text(
                            'Add School'
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 20),

                  const Text(
                    'Location',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownSearch<String>(
                    dropdownSearchDecoration: searchDropdownDecoration(),
                    showSearchBox: true,
                    showClearButton: false,
                    mode: Mode.DIALOG,
                    items: countries,
                    label: "",
                    dropDownButton: Icon(
                      Icons.edit,
                      color: Colors.grey[500],
                      size: 20,
                    ),
                    dropdownSearchBaseStyle: const TextStyle(
                      fontSize: 15,
                    ),
                    selectedItem: _selectedCountry,
                    // hint: "country in menu mode",
                    // popupItemDisabled: (String s) => s.startsWith('I'),
                    onChanged: (value) {
                      setState(() {
                        _selectedCountry = value ?? 'null';
                        if(_selectedCountry != 'United States') {
                          _selectedState = '';
                        }
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        profileToBeSaved.country = value ?? '';
                      });
                    },
                    validator: (value) {
                      if((value ?? '').isNotEmpty) {
                        return null;
                      }
                      return 'Please provide a valid country.';
                    },
                  ),
                  const SizedBox(height: 12),
                      () {
                    if(_selectedCountry == 'United States') {
                      return DropdownSearch<String>(
                        dropdownSearchDecoration: searchDropdownDecoration(),
                        showSearchBox: true,
                        showClearButton: false,
                        mode: Mode.DIALOG,
                        items: states,
                        dropdownSearchBaseStyle: const TextStyle(
                          fontSize: 15,
                        ),
                        selectedItem: _selectedState,
                        label: "Select a state",
                        dropDownButton: Icon(
                          Icons.edit,
                          color: Colors.grey[500],
                          size: 20,
                        ),
                        // hint: "country in menu mode",
                        // popupItemDisabled: (String s) => s.startsWith('I'),
                        onChanged: (value) {
                          setState(() {
                            _selectedState = value ?? 'null';
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            profileToBeSaved.state = value ?? '';
                          });
                        },
                        validator: (value) {
                          if((value ?? '').isNotEmpty) {
                            return null;
                          }
                          return 'Please provide a valid state';
                        },
                      );
                    }
                    return const SizedBox(height: 0);
                  }(),

                  const Divider(height: 20),

                  const Text(
                    'Contact Info',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Add or edit your social info, email, websites and more',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),

                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: const [
                        Icon(
                          Icons.add,
                          size: 20,
                        ),
                        SizedBox(width: 2),
                        Text(
                            'Edit contact info'
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 20, color: Colors.grey.shade400,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
