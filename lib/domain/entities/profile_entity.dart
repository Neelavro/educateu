
class ProfileEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String alternateEmail;
  final String bio;
  final String username;
  final String studentNo;
  final String mobile;
  final String address;
  final String? photoPath;
  final String nationality;
  final String accountStatus;
  final DateTime joinDate;
  final bool mfaEnabled;
  final bool isTemporaryPassword;
  final List<String> academicInfo;

  ProfileEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.alternateEmail,
    required this.bio,
    required this.username,
    required this.studentNo,
    required this.mobile,
    required this.address,
    this.photoPath,
    required this.nationality,
    required this.accountStatus,
    required this.joinDate,
    required this.mfaEnabled,
    required this.isTemporaryPassword,
    required this.academicInfo,
  });

  String get fullName => '$firstName $lastName'.trim();
}