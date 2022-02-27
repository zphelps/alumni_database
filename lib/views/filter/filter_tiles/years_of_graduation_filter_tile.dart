import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:alumni_database/profiles/profile_notifier.dart';

import '../../../const_data.dart';

class YearsOfGraduationFilterTile extends ConsumerStatefulWidget {
  const YearsOfGraduationFilterTile({Key? key}) : super(key: key);

  @override
  _YearsOfGraduationFilterState createState() => _YearsOfGraduationFilterState();
}

class _YearsOfGraduationFilterState extends ConsumerState<YearsOfGraduationFilterTile> {
  @override
  Widget build(BuildContext context) {

    String _startYear = '';
    String _endYear = '';

    final _formKey = GlobalKey<FormState>();

    return ExpansionTile(
      title: const Text('Years of Graduation'),
      childrenPadding: const EdgeInsets.fromLTRB(15, 0, 15, 16),
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                      width: 75,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),],
                        maxLength: 4,
                        autofocus: true,
                        validator: (value) {
                          int year = int.parse(value ?? '0');
                          if(year > 1950) {
                            return null;
                          }
                          return 'Invalid.';
                        },
                        onSaved: (value) {
                          setState(() {
                            _startYear = value ?? '';
                          });
                        },
                        decoration: yearsOfGraduationDecoration(),
                        // onChanged: (value) {
                        //   setState(() {
                        //     _startYear = value;
                        //   });
                        // },
                      )
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'TO',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 6),
                  SizedBox(
                    width: 75,
                    child: TextFormField(
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),],
                      maxLength: 4,
                      validator: (value) {
                        int year = int.parse(value ?? '0');
                        if(year > 1950) {
                          return null;
                        }
                        return 'Invalid.';
                      },
                      textAlign: TextAlign.center,
                      decoration: yearsOfGraduationDecoration(),
                      onSaved: (year) {
                        setState(() {
                          _endYear = year ?? '';
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      _formKey.currentState!.save();
                      if(_formKey.currentState!.validate()) {
                        int start = int.parse(_startYear);
                        int end = int.parse(_endYear);
                        ref.read(profilesProvider.notifier).addGraduationRange(start, end);
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
                    onTap: () {},
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

  InputDecoration yearsOfGraduationDecoration() {
    return InputDecoration(
      counterText: '',
      hintText: 'YYYY',
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