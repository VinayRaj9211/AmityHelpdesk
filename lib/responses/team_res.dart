class Engineer {
  final int id;
  final String campusName;
  final String engineerName;
  final String contact;
  final String mail;
  final String password;
  final String engType;
  final int managerId;

  Engineer({
    required this.id,
    required this.campusName,
    required this.engineerName,
    required this.contact,
    required this.mail,
    required this.password,
    required this.engType,
    required this.managerId,
  });

  factory Engineer.fromJson(Map<String, dynamic> json) {
    return Engineer(
      id: json['id'],
      campusName: json['campus_name'],
      engineerName: json['engineer_name'],
      contact: json['contact'],
      mail: json['mail'],
      password: json['password'],
      engType: json['eng_type'] ?? '',
      managerId: json['manager_id'],
    );
  }
}
