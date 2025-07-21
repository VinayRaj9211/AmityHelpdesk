class Engineer {
  final int id;
  final String campusName;
  final String engineerName;
  final String contact;
  final String mail;
  final String password;

  Engineer({
    required this.id,
    required this.campusName,
    required this.engineerName,
    required this.contact,
    required this.mail,
    required this.password,
  });

  factory Engineer.fromJson(Map<String, dynamic> json) {
    return Engineer(
      id: json['id'],
      campusName: json['campus_name'],
      engineerName: json['engineer_name'],
      contact: json['contact'],
      mail: json['mail'],
      password: json['password'],
    );
  }
}