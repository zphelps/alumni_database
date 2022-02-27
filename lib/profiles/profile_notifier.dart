import 'dart:collection';

import 'package:alumni_database/profiles/profile_model.dart';
import 'package:alumni_database/sample_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilesNotifier extends StateNotifier<List<ProfileModel>> {
  ProfilesNotifier() : super([]);

  List<ProfileModel> allProfiles = [];
  List<String> filterLabels = [];

  Future<void> getProfiles() async {
    await Future.delayed(const Duration(seconds: 1));
    allProfiles = profileSampleData;
    state = profileSampleData;
  }

  ProfileModel getProfile(String profileID) {
    return allProfiles.where((element) => element.id == profileID).toList().first;
  }

  Future<void> setProfile(ProfileModel profile) async {
    allProfiles.removeWhere((element) => element.id == profile.id);
    allProfiles.add(profile);
    List<ProfileModel> newList = [];
    newList.addAll(allProfiles);
    state = newList;
  }

  void searchFilter(String query) {
    Iterable<ProfileModel> filteredProfiles = allProfiles.where((element) {
      return element.firstName.toLowerCase().contains(query.toLowerCase()) || element.lastName.toLowerCase().contains(query.toLowerCase());
    });
    state = filteredProfiles.toList();
  }

  void addLocation(Map location) {
    String stateFilter = location['state'];
    String countryFilter = location['country'];
    Set<ProfileModel> newFilteredProfiles = HashSet();
    if(state != allProfiles) {
      newFilteredProfiles.addAll(state.toList());
    }
    List<ProfileModel> profilesToAdd = allProfiles.where((profile) {
      if(stateFilter.isEmpty) {
        if(profile.country == countryFilter) {
          return true;
        }
      }
      else {
        if(profile.state == stateFilter) {
          return true;
        }
      }
      return false;
    }).toList();
    newFilteredProfiles.addAll(profilesToAdd);
    if(stateFilter.isNotEmpty) {
      filterLabels.add('Works in $stateFilter, $countryFilter');
    }
    else {
      filterLabels.add('Works in $countryFilter');
    }
    state = newFilteredProfiles.toList();
  }

  void removeLocation(String filterLabel) {
    List<String> splitFilter;
    String stateFilter = '';
    String countryFilter = '';
    if(filterLabel.contains(',')) {
      splitFilter = filterLabel.split(', ');
      countryFilter = splitFilter.last;
      stateFilter = splitFilter[0].split(' ').sublist(2).join(' ');
    }
    else {
      splitFilter = filterLabel.split(' ');
      countryFilter = splitFilter.sublist(2).join(" ");
    }
    Set<ProfileModel> newFilteredProfiles = HashSet();
    if(state != allProfiles) {
      newFilteredProfiles.addAll(state.toList());
    }
    List<ProfileModel> profilesToRemove = allProfiles.where((profile) {
      if(stateFilter.isEmpty) {
        if(profile.country == countryFilter) {
          return true;
        }
      }
      else {
        if(profile.state == stateFilter) {
          return true;
        }
      }
      return false;
    }).toList();
    newFilteredProfiles.removeAll(profilesToRemove);
    filterLabels.remove(filterLabel);
    if(newFilteredProfiles.isEmpty) {
      state = allProfiles;
    }
    else {
      state = newFilteredProfiles.toList();
    }
  }

  void addGraduationRange(int start, int end) {
    Set<ProfileModel> newFilteredProfiles = HashSet();
    if(state != allProfiles) {
      newFilteredProfiles.addAll(state.toList());
    }
    List<ProfileModel> profilesToAdd = [];
    for(int i = start; i <= end; i++) {
      profilesToAdd.addAll(allProfiles.where((profile) {
        if(profile.graduationYear == i) {
          return true;
        }
        return false;
      }).toList());
    }
    newFilteredProfiles.addAll(profilesToAdd);
    filterLabels.add('Graduated between $start and $end');
    state = newFilteredProfiles.toList();
  }

  void removeGraduationRange(String graduationRangeFilter) {
    List<String> splitFilter;
    int start = 0;
    int end = 0;
    splitFilter = graduationRangeFilter.split(' ');
    start = int.parse(splitFilter[splitFilter.length - 3]);
    end = int.parse(splitFilter[splitFilter.length - 1]);
    Set<ProfileModel> newFilteredProfiles = HashSet();
    if(state != allProfiles) {
      newFilteredProfiles.addAll(state.toList());
    }
    List<ProfileModel> profilesToRemove = [];
    for(int i = start; i <= end; i++) {
      profilesToRemove.addAll(allProfiles.where((profile) {
        if(profile.graduationYear == i) {
          return true;
        }
        return false;
      }).toList());
    }
    newFilteredProfiles.removeAll(profilesToRemove);
    filterLabels.remove(graduationRangeFilter);
    if(newFilteredProfiles.isEmpty) {
      state = allProfiles;
    }
    else {
      state = newFilteredProfiles.toList();
    }
  }

  void addEducation(String university) {
    Set<ProfileModel> newFilteredProfiles = HashSet();
    if(state != allProfiles) {
      newFilteredProfiles.addAll(state.toList());
    }
    List<ProfileModel> profilesToAdd = [];
    profilesToAdd.addAll(allProfiles.where((profile) {
      if(profile.education.any((element) => element.name == university)) {
        return true;
      }
      return false;
    }).toList());
    newFilteredProfiles.addAll(profilesToAdd);
    filterLabels.add('Went to $university');
    state = newFilteredProfiles.toList();
  }

  void removeEducation(String filterLabel) {
    List<String> splitFilter;
    splitFilter = filterLabel.split(' ');
    String universityFilter = splitFilter.sublist(2).join(" ");
    Set<ProfileModel> newFilteredProfiles = HashSet();
    if(state != allProfiles) {
      newFilteredProfiles.addAll(state.toList());
    }
    List<ProfileModel> profilesToRemove = allProfiles.where((profile) {
      if(profile.education.any((element) => element.name == universityFilter)) {
        return true;
      }
      return false;
    }).toList();
    newFilteredProfiles.removeAll(profilesToRemove);
    filterLabels.remove(filterLabel);
    if(newFilteredProfiles.isEmpty) {
      state = allProfiles;
    }
    else {
      state = newFilteredProfiles.toList();
    }
  }

  void clear() {
    state = allProfiles;
    filterLabels.clear();
  }

}

final profilesProvider = StateNotifierProvider<ProfilesNotifier, List<ProfileModel>>((ref) {
  return ProfilesNotifier();
});

final profileProvider = Provider.family<ProfileModel, dynamic>((ref, profileID) {
  final profiles = ref.watch(profilesProvider);
  return profiles.where((element) => element.id == profileID).toList().first;
});