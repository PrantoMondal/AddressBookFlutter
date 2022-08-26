class ContactModel {
  int? id;
  String name;
  String mobile;
  String? email;
  String? streetAddress;
  String? dob;
  String? image;
  String? gender;
  String? website;

  ContactModel(
      {this.id,
      required this.name,
      required this.mobile,
      this.email,
      this.streetAddress,
      this.dob,
      this.image,
      this.gender,
      this.website});
}

final contactListDB = <ContactModel>[
  ContactModel(
      id: 1,
      name: 'Pranto',
      mobile: '+8801781100621',
      email: 'prantomondal517@gmail.com',
      gender: 'Male',
      streetAddress: 'Bashundhara Dhaka',
      website: 'www.flutter.dev',
      dob: '23/08/1996'),
  ContactModel(
      id: 2,
      name: 'Mondal',
      mobile: '+8801713139767',
      email: 'prantomondal517@gmail.com',
      gender: 'Male',
      streetAddress: 'Bashundhara Dhaka',
      website: 'www.flutter.dev',
      dob: '23/08/1996'),
];
