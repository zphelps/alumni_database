
import 'package:alumni_database/views/filter/filter_tiles/education_filter_tile.dart';
import 'package:alumni_database/views/filter/filter_tiles/location_filter_tile.dart';
import 'package:alumni_database/views/filter/filter_tiles/years_of_graduation_filter_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterView extends ConsumerStatefulWidget {
  const FilterView();

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends ConsumerState<FilterView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.fromLTRB(0, 8, 8, 0),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey.shade100, width: 1)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            '   Filter',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          LocationFilterTile(),
          YearsOfGraduationFilterTile(),
          EducationFilterTile(),
          ExpansionTile(
            title: Text('Company'),
            children: <Widget>[
              ListTile(title: Text('This is tile number 1')),
            ],
          ),
        ],
      ),
    );
  }
}
