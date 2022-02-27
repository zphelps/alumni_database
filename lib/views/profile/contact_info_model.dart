
class ProfileContactInfo {
  late String profileID;
  late String websiteURL;
  late String email;
  late String phone;
  late String instagramURL;
  late String facebookURL;
  late String twitterURL;

  ProfileContactInfo({
    required this.profileID,
    required this.websiteURL,
    required this.email,
    required this.phone,
    required this.instagramURL,
    required this.facebookURL,
    required this.twitterURL,
  });

  ProfileContactInfo.blank() {
    profileID = '';
    websiteURL = '';
    email = '';
    phone = '';
    instagramURL = '';
    twitterURL = '';
    facebookURL = '';
  }

  bool isEmpty() {
    if(profileID == '') {
      return true;
    }
    return false;
  }
}