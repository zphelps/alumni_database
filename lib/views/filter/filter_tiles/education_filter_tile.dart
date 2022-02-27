import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:alumni_database/profiles/profile_notifier.dart';
import 'package:flutter_textfield_autocomplete/flutter_textfield_autocomplete.dart';
import 'package:http/http.dart';

import '../../../const_data.dart';


class EducationFilterTile extends ConsumerStatefulWidget {
  const EducationFilterTile({Key? key}) : super(key: key);

  @override
  _EducationFilterState createState() => _EducationFilterState();
}

class _EducationFilterState extends ConsumerState<EducationFilterTile> {

  final GlobalKey<TextFieldAutoCompleteState<String>> _textFieldAutoCompleteKey = GlobalKey();

  List<String> universityNames = [];

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
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    String _selectedUniversity = '';

    TextEditingController _controller = TextEditingController();

    return ExpansionTile(
      title: const Text('Education'),
      childrenPadding: const EdgeInsets.fromLTRB(15, 0, 15, 16),
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFieldAutoComplete(
                  decoration: educationDecoration(),
                  clearOnSubmit: false,
                  controller: _controller,
                  itemSubmitted: (String item) {
                    _selectedUniversity = item;
                  },
                  style: const TextStyle(
                    fontSize: 14,
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
              const SizedBox(height: 12),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      _formKey.currentState!.save();
                      if(_formKey.currentState!.validate() && _selectedUniversity == _controller.value.text) {
                        ref.read(profilesProvider.notifier).addEducation(_selectedUniversity);
                      }
                    },
                    child: Container(
                      height: 35,
                      width: MediaQuery.of(context).size.width * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue,
                      ),
                      child: const Center(
                        child: AutoSizeText(
                          'Apply',
                          minFontSize: 10,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      _controller.clear();
                    },
                    child: Container(
                      height: 35,
                      width: MediaQuery.of(context).size.width * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue, width: 1),
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: AutoSizeText(
                          'Clear',
                          minFontSize: 10,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  InputDecoration educationDecoration() {
    return InputDecoration(
      counterText: '',
      hintText: 'Search all universities',
      hintStyle: const TextStyle(
        fontSize: 14,
      ),
      labelStyle: const TextStyle(
        fontSize: 14,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      fillColor: const Color(0xffFAFAFA),
      filled: true,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xffFAFAFA))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xffFAFAFA))),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xffFAFAFA))),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xffFAFAFA))),
    );
  }
}