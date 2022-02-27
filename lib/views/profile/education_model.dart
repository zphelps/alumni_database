
import 'dart:ui';

class EducationModel {
  late String id;
  late String url;
  late String name;
  late int startDate;
  late int endDate;
  late String tagline;

  EducationModel({
    required this.id,
    required this.name,
    required this.url,
    required this.startDate,
    required this.endDate,
    required this.tagline,
  });

  EducationModel.blank() {
    id = '';
    name = '';
    url = '';
    startDate = 0;
    endDate = 0;
    tagline = '';
  }

  bool isEmpty() {
    if(id == '' && url == '' && name == '' && startDate == 0 && endDate == 0 && tagline == '') {
      return true;
    }
    return false;
  }
}