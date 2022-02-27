import 'dart:convert';
import 'dart:html';

import 'package:alumni_database/profiles/profile_model.dart';
import 'package:alumni_database/profiles/profile_notifier.dart';
import 'package:alumni_database/shared_widgets/decorations/searchDropdownDecoration.dart';
import 'package:alumni_database/shared_widgets/decorations/textFieldDecoration.dart';
import 'package:alumni_database/views/profile/education_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_textfield_autocomplete/flutter_textfield_autocomplete.dart';
import 'package:http/http.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EditSchoolModal extends ConsumerStatefulWidget {
  const EditSchoolModal({required this.education, required this.profileID});

  final String profileID;
  final EducationModel education;

  @override
  ConsumerState<EditSchoolModal> createState() => _EditSchoolModalState();
}

class _EditSchoolModalState extends ConsumerState<EditSchoolModal> {

  final GlobalKey<TextFieldAutoCompleteState<String>> _textFieldAutoCompleteKey = GlobalKey();

  final _formKey = GlobalKey<FormState>();

  List<String> universityNames = [];

  EducationModel educationToBeSaved = EducationModel.blank();

  Future<void> _getUniversities() async {
    try {

      Response response = await get(Uri.parse('http://universities.hipolabs.com/search?'));
      List<dynamic> data = jsonDecode(response.body);

      for(int i = 0; i < data.length; i++) {
        universityNames.add(data[i]['name']);
      }

    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _getUniversities();
    educationToBeSaved.name = widget.education.isEmpty() ? '' : widget.education.name;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    _controller.text = educationToBeSaved.name;

    return AlertDialog(
      scrollable: true,
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
              if(_formKey.currentState!.validate() && educationToBeSaved.name == _controller.value.text) {
                ProfileModel profile = ref.read(profileProvider(widget.profileID));
                if(!widget.education.isEmpty()) {
                  int index = profile.education.indexWhere((e) => e.id == widget.education.id);
                  profile.education.removeWhere((e) => e.id == widget.education.id);
                  profile.education.insert(index, educationToBeSaved);
                }
                else {
                  profile.education.add(educationToBeSaved);
                }
                ref.read(profilesProvider.notifier).setProfile(profile);
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
                children: [
                  Row(
                    children: [
                      Text(
                        widget.education.isEmpty() ? 'Add Education' : 'Edit Education',
                        style: const TextStyle(
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
                  Divider(height: 20, color: Colors.grey.shade400,),
                  const SizedBox(height: 10),
                  TextFieldAutoComplete(
                      decoration: searchDropdownDecoration().copyWith(label: const Text('University Name*')),
                      clearOnSubmit: false,
                      controller: _controller,
                      itemSubmitted: (String item) {
                        // _selectedUniversity = item;
                        educationToBeSaved.name = item;
                      },
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      key: _textFieldAutoCompleteKey,
                      suggestions: universityNames,
                      itemBuilder: (context, String item) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            width: 120,
                            child: AutoSizeText(
                              item,
                              maxLines: 2,
                              minFontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      },
                      itemSorter: (String a, String b) {
                        return a.compareTo(b);
                      },
                      itemFilter: (String item, query) {
                        return item
                            .toLowerCase()
                            .startsWith(query.toLowerCase());
                      }
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    decoration: textFieldDecoration().copyWith(label: const Text('Headline*')),
                    initialValue: widget.education.isEmpty() ? '' : widget.education.tagline,
                    validator: (value) {
                      if((value ?? '').isEmpty) {
                        return 'Please enter a valid headline.';
                      }
                      return null;
                    },
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    onSaved: (value) {
                      setState(() {
                        educationToBeSaved.tagline = value ?? '';
                      });
                    },
                  ),

                  const SizedBox(height: 10),

                  TextFormField(
                    decoration: textFieldDecoration().copyWith(label: const Text('Start Year*')),
                    initialValue: widget.education.isEmpty() ? '' : '${widget.education.startDate}',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    validator: (value) {
                      if(int.tryParse((value ?? '')) != null) {
                        return null;
                      }
                      return 'Please enter a valid year.';
                    },
                    onSaved: (value) {
                      if(int.tryParse((value ?? '')) != null) {
                        setState(() {
                          educationToBeSaved.startDate = int.tryParse(value ?? '')!;
                        });
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  TextFormField(
                    decoration: textFieldDecoration().copyWith(label: const Text('End Year (or expected)*')),
                    initialValue: widget.education.isEmpty() ? '' : '${widget.education.endDate}',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    validator: (value) {
                      if(int.tryParse((value ?? '')) != null) {
                        return null;
                      }
                      return 'Please enter a valid year.';
                    },
                    onSaved: (value) {
                      if(int.tryParse((value ?? '')) != null) {
                        setState(() {
                          educationToBeSaved.endDate = int.tryParse(value ?? '')!;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
