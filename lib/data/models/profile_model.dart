import 'dart:convert';

import 'package:educateu/data/models/profile_photo_model.dart';

import '../../domain/entities/profile_entity.dart';

class ProfileModel {
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
  final ProfilePhoto? photo;
  final String nationality;
  final String accountStatus;
  final DateTime joinDate;
  final bool mfaEnabled;
  final bool isTemporaryPassword;
  final List<String> academicInfo;

  ProfileModel({
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
    this.photo,
    required this.nationality,
    required this.accountStatus,
    required this.joinDate,
    required this.mfaEnabled,
    required this.isTemporaryPassword,
    required this.academicInfo,
  });

  String get fullName => '$firstName $lastName'.trim();
  String? get photoFilePath => photo?.path;


  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    ProfilePhoto? photo;
    if (json['photo'] != null && json['photo'].toString().isNotEmpty) {
      try {
        photo = ProfilePhoto.fromJson(jsonDecode(json['photo'] as String));
      } catch (_) {}
    }

    return ProfileModel(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      alternateEmail: json['alternateEmail'] ?? '',
      bio: json['bio'] ?? '',
      username: json['username'] ?? '',
      studentNo: json['studentNo'] ?? '',
      mobile: json['mobile'] ?? '',
      address: json['address'] ?? '',
      photo: photo,
      nationality: json['nationality'] ?? '',
      accountStatus: json['accountStatus'] ?? '',
      joinDate: DateTime.parse(json['joinDate']),
      mfaEnabled: json['mfaEnabled'] ?? false,
      isTemporaryPassword: json['isTemporaryPassword'] ?? false,
      academicInfo: List<String>.from(json['academicInfo'] ?? []),
    );
  }

  ProfileEntity toEntity({String? resolvedPhotoUrl}) {
    return ProfileEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      alternateEmail: alternateEmail,
      bio: bio,
      username: username,
      studentNo: studentNo,
      mobile: mobile,
      address: address,
      photoPath: resolvedPhotoUrl,
      nationality: nationality,
      accountStatus: accountStatus,
      joinDate: joinDate,
      mfaEnabled: mfaEnabled,
      isTemporaryPassword: isTemporaryPassword,
      academicInfo: academicInfo,
    );
  }
}

