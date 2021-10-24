class User {
  late String name;
  late String lastname;
  late String birthDate;
  late String gender;
  late String emailAddress;
  late String phoneNumber;
  late String homeAddress;
  late int documentType;
  late String documentNumber;
  late String province;
  late String registerDate;

  User(this.name, this.lastname, this.birthDate, this.gender, this.emailAddress, this.phoneNumber, this.homeAddress, this.documentType, this.documentNumber, this.province, this.registerDate);

  @override
  String toString() {
    return 'name: $name, lastname: $lastname, birthDate: $birthDate, gender: $gender, '
        'emailAddress: $emailAddress, phoneNumber: $phoneNumber, homeAddress: $homeAddress,'
        'documentType: $documentType, documentNumber: $documentNumber, province: $province, registerDate: $registerDate' ;
  }
}