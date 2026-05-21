import 'package:equatable/equatable.dart';

class StudentEntity extends Equatable {
  final String id;
  final String firstName;
  final String? email;
  final bool mfaEnabled;
  final bool isTemporaryPassword;
  final String? accessToken;
  final String? refreshToken;

  StudentEntity({
    required this.id,
    required this.firstName,
    this.email,
    required this.mfaEnabled,
    required this.isTemporaryPassword,
    this.accessToken,
    this.refreshToken,
  });

  factory StudentEntity.fromJson(Map<String, dynamic> json) {
    return StudentEntity(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      email: json['email'],
      mfaEnabled: json['mfaEnabled'] ?? false,
      isTemporaryPassword: json['isTemporaryPassword'] ?? false,
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'email': email,
    'mfaEnabled': mfaEnabled,
    'isTemporaryPassword': isTemporaryPassword,
    'accessToken': accessToken,
    'refreshToken': refreshToken,
  };

  @override
  List<Object?> get props => [
    id,
    firstName,
    email,
    mfaEnabled,
    isTemporaryPassword,
    accessToken,
    refreshToken,
  ];
}