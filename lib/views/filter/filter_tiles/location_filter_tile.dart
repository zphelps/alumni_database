import 'package:alumni_database/shared_widgets/decorations/searchDropdownDecoration.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:alumni_database/profiles/profile_notifier.dart';

import '../../../const_data.dart';


class LocationFilterTile extends ConsumerStatefulWidget {
  const LocationFilterTile();

  @override
  _LocationFilterState createState() => _LocationFilterState();
}

class _LocationFilterState extends ConsumerState<LocationFilterTile> {
  String _selectedState = '';

  String _selectedCountry = '';

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Location'),
      childrenPadding: const EdgeInsets.fromLTRB(15, 0, 15, 16),
      children: <Widget>[
        const SizedBox(height: 6),
        DropdownSearch<String>(
          dropdownSearchDecoration: searchDropdownDecoration(),
          showSearchBox: true,
          showClearButton: false,
          mode: Mode.DIALOG,
          items: countries,
          label: "Select a country",
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
          // selectedItem: "Brazil"
        ),
        const SizedBox(height: 8),
            () {
          if(_selectedCountry == 'United States') {
            return DropdownSearch<String>(
              dropdownSearchDecoration: searchDropdownDecoration(),
              showSearchBox: true,
              showClearButton: false,
              mode: Mode.DIALOG,
              items: states,
              label: "Select a state",
              // hint: "country in menu mode",
              // popupItemDisabled: (String s) => s.startsWith('I'),
              onChanged: (value) {
                setState(() {
                  _selectedState = value ?? 'null';
                });
              },
              // selectedItem: "Brazil"
            );
          }
          return const SizedBox(height: 0);
        }(),
        const SizedBox(height: 12),
        Row(
          children: [
            InkWell(
              onTap: () {
                // var filters = context.read<FilterModel>();
                // filters.addState(_selectedState, context);
                try {
                  ref.read(profilesProvider.notifier).addLocation({
                    'state':_selectedState,
                    'country':_selectedCountry,
                  });
                } catch(e) {
                  if (kDebugMode) {
                    print(e);
                  }
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
    );
  }
}