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