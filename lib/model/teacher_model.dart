class TeacherModel {
  final String id;
  final String teacherid;
  final String fullName;
  final String gender;
  final String specalization;
  final String phone;
  final String email;
  final String userid;
  final String facultyid;
  final String? imagePath;

  const TeacherModel({
    required this.id,
    required this.teacherid,
    required this.fullName,
    required this.gender,
    required this.specalization,
    required this.phone,
    required this.email,
    required this.userid,
    required this.facultyid,
    this.imagePath,
  });

  /// ✅ copyWith (must be inside class)
  TeacherModel copyWith({
    String? id,
    String? teacherid,
    String? fullName,
    String? gender,
    String? specalization,
    String? phone,
    String? email,
    String? userid,
    String? facultyid,
    String? imagePath,
  }) {
    return TeacherModel(
      id: id ?? this.id,
      teacherid: teacherid ?? this.teacherid,
      fullName: fullName ?? this.fullName,
      gender: gender ?? this.gender,
      specalization: specalization ?? this.specalization,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      userid: userid ?? this.userid,
      facultyid: facultyid ?? this.facultyid,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  /// ✅ toJson
  Map<String, dynamic> toJson() => {
        'id': id,
        'teacherid': teacherid,
        'fullName': fullName,
        'gender': gender,
        'specalization': specalization,
        'phone': phone,
        'email': email,
        'userid': userid,
        'facultyid': facultyid,
        'imagePath': imagePath,
      };

  /// ✅ fromJson (class name fixed)
  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['id'],
      teacherid: json['teacherid'],
      fullName: json['fullName'],
      gender: json['gender'],
      specalization: json['specalization'],
      phone: json['phone'],
      email: json['email'],
      userid: json['userid'],
      facultyid: json['facultyid'],
      imagePath: json['imagePath'],
    );
  }
}
