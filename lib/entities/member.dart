class Member {
  String firstName;
  String lastName;
  String phoneNumber;
  String city;
  String gender;
  int currentWeight;
  int requestedWeight;
  int height;
  DateTime birthDay;
  DateTime membershipStartDate;
  DateTime membershipEndDate;
  String uniqueId;
  Member(
      String firstName,
      String lastName,
      String phoneNumber,
      String city,
      String gender,
      int currentWeight,
      int requestedWeight,
      int height,
      DateTime birthDay,
      DateTime membershipStartDate,
      DateTime membershipEndDate,
      String uniqueId) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.phoneNumber = phoneNumber;
    this.city = city;
    this.gender = gender;
    this.currentWeight = currentWeight;
    this.requestedWeight = requestedWeight;
    this.height = height;
    this.birthDay = birthDay;
    this.membershipStartDate = membershipStartDate;
    this.membershipEndDate = membershipEndDate;
    this.uniqueId = uniqueId;
  }

  getJson() {
    return {
      "uniqueId": this.uniqueId,
      "firstName": this.firstName,
      "lastName": this.lastName,
      "phoneNumber": this.phoneNumber,
      "city": this.city,
      "gender": this.gender,
      "currentWeight": this.currentWeight,
      "requestedWeight": this.requestedWeight,
      "height": this.height,
      "birthDay": this.birthDay,
      "membershipStartDate": this.membershipStartDate.toString(),
      "membershipEndDate": this.membershipEndDate.toString()
    };
  }
}
