import 'package:alumni_database/profiles/profile_model.dart';
import 'package:alumni_database/profiles/profile_notifier.dart';
import 'package:alumni_database/sample_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterHistory extends ConsumerWidget {
  FilterHistory();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> filterLabels = ref.watch(profilesProvider.notifier).filterLabels;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.69,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
            children: filterLabels.map((e) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Chip(
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                      color: Colors.grey[600]
                  ),
                  labelPadding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  side: BorderSide(color: Colors.grey.shade600, width: 1),
                  // onPressed: () {
                  //
                  // },
                  onDeleted: () {
                    // var filters = context.read<FilterModel>();
                    // ref.read(filterProvider.notifier).
                    // filters.remove(e);
                    String filterIdentifier = e.split(' ').first;
                    if(filterIdentifier == 'Works') {
                      ref.read(profilesProvider.notifier).removeLocation(e);
                    }
                    else if(filterIdentifier == 'Graduated') {
                      ref.read(profilesProvider.notifier).removeGraduationRange(e);
                    }
                    else if(filterIdentifier == 'Went') {
                      ref.read(profilesProvider.notifier).removeEducation(e);
                    }

                  },
                  deleteIconColor: Colors.grey[600],
                  deleteIcon: Icon(
                    Icons.close,
                    color: Colors.grey[600],
                    size: 16,
                  ),
                  label: Text(e),
                ),
              );
            }).toList()
        ),
      ),
    );
  }
}
