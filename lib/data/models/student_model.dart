
import '../../domain/entities/student_entity.dart';

class Student {
  final String id;
  final String firstName;
  final String? email;
  final bool mfaEnabled;
  final bool isTemporaryPassword;
  final String? accessToken;
  final String? refreshToken;

  const Student({
    required this.id,
    required this.firstName,
    this.email,
    required this.mfaEnabled,
    required this.isTemporaryPassword,
    this.accessToken,
    this.refreshToken,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    final student = data['student'] as Map<String, dynamic>;

    return Student(
      id: student['id'] as String,
      firstName: student['firstName'] as String,
      email: student['email'] as String?,
      mfaEnabled: student['mfaEnabled'] as bool? ?? false,
      isTemporaryPassword: student['isTemporaryPassword'] as bool? ?? false,
      accessToken: data['accessToken'] as String?,
      refreshToken: data['refreshToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'data': {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'student': {
        'id': id,
        'firstName': firstName,
        'email': email,
        'mfaEnabled': mfaEnabled,
        'isTemporaryPassword': isTemporaryPassword,
      },
    },
  };

  // inside Student model
  StudentEntity toEntity() => StudentEntity(
    id: id,
    firstName: firstName,
    email: email,
    mfaEnabled: mfaEnabled,
    isTemporaryPassword: isTemporaryPassword,
    accessToken: accessToken,
    refreshToken: refreshToken,
  );
}