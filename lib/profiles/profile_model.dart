import 'package:alumni_database/views/profile/education_model.dart';
import 'package:alumni_database/views/profile/experience_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class ProfileModel extends Equatable {
  ProfileModel({required this.id, required this.firstName,
    required this.lastName, required this.tagline, required this.bio,
    required this.avatarURL, required this.state, required this.country,
    required this.graduationYear, required this.education, required this.experience});
  late String id;
  late String firstName;
  late String lastName;
  late String tagline;
  late String bio;
  late String avatarURL;
  late String state;
  late String country;
  late int graduationYear;
  late List<EducationModel> education;
  late List<ExperienceModel> experience;

  @override
  List<Object> get props => [id, firstName, lastName, tagline, bio,
    avatarURL, state, country, graduationYear, education, experience];

  @override
  bool get stringify => true;

  ProfileModel.blank() {
    id = '';
    firstName = '';
    lastName = '';
    tagline = '';
    bio = '';
    avatarURL = '';
    state = '';
    country = '';
    graduationYear = -1;
    education = [];
    experience = [];
  }

  factory ProfileModel.fromMap(Map<String, dynamic>? data, String documentId) {
    if (data == null) {
      throw StateError('missing data for article: $documentId');
    }

    final firstName = data['firstName'] as String?;
    if (firstName == null) {
      throw StateError('missing firstName for profile: $documentId');
    }

    final lastName = data['lastName'] as String?;
    if (lastName == null) {
      throw StateError('missing lastName for profile: $documentId');
    }

    final tagline = data['tagline'] as String?;
    if (tagline == null) {
      throw StateError('missing tagline for profile: $documentId');
    }

    final bio = data['bio'] as String?;
    if (bio == null) {
      throw StateError('missing bio for profile: $documentId');
    }

    final avatarURL = data['avatarURL'] as String?;
    if (avatarURL == null) {
      throw StateError('missing avatarURL for profile: $documentId');
    }

    final state = data['state'] as String?;
    if (state == null) {
      throw StateError('missing state for profile: $documentId');
    }

    final country = data['country'] as String?;
    if (country == null) {
      throw StateError('missing country for profile: $documentId');
    }

    final graduationYear = data['graduationYear'] as int?;
    if (graduationYear == null) {
      throw StateError('missing graduationYear for profile: $documentId');
    }

    final education = data['education'] as List<EducationModel>?;
    if (education == null) {
      throw StateError('missing education for profile: $documentId');
    }

    final experience = data['experience'] as List<ExperienceModel>?;
    if (experience == null) {
      throw StateError('missing experience for profile: $documentId');
    }

    return ProfileModel(
      id: documentId,
      firstName: firstName,
      lastName: lastName,
      tagline: tagline,
      bio: bio,
      avatarURL: avatarURL,
      state: state,
      country: country,
      graduationYear: graduationYear,
      education: education,
      experience: experience,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'tagline': tagline,
      'bio': bio,
      'avatarURL': avatarURL,
      'state': state,
      'country': country,
      'graduationYear': graduationYear,
      'education': education,
      'experience': experience,
    };
  }
}