class UserData {
  String? firstName;
  String? lastName;
  DateTime? birthday;
  String? gender;
  String? username;
  String? email;
  String? phoneNumber;
  String? password;
  String? profileImagePath;

  UserData({
    this.firstName,
    this.lastName,
    this.birthday,
    this.gender,
    this.username,
    this.email,
    this.phoneNumber,
    this.password,
    this.profileImagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'birthday': birthday?.toIso8601String(),
      'gender': gender,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'profileImagePath': profileImagePath,
    };
  }
}

