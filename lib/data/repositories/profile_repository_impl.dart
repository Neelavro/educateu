import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../core/helper.dart';
import '../../core/urls.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../models/profile_model.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  @override
  Future<Either<String, ProfileEntity>> getProfile() async {
    try {
      final url = Uri.parse(
        '${ApiConstants.authBaseUrl}$profileEndpoint',
      );

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${currentStudent.value.accessToken}',
        },
      );

      final json = jsonDecode(response.body) as Map<String, dynamic>;

      if (json['statusCode'] == 200) {
        final profile = ProfileModel.fromJson(
          json['data']['profile'] as Map<String, dynamic>,
        );

        // Resolve photo URL if photo path exists
        String? resolvedPhotoUrl;
        if (profile.photoFilePath != null) {
          final fileUrlResult = await _getFileUrl(profile.photoFilePath!);
          resolvedPhotoUrl = fileUrlResult.fold((_) => null, (url) => url);
        }

        return Right(profile.toEntity(resolvedPhotoUrl: resolvedPhotoUrl));
      }

      return Left(json['message'] as String? ?? 'Failed to fetch profile');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> _getFileUrl(String filePath) async {
    try {
      final encodedPath = Uri.encodeComponent(filePath);
      final url = Uri.parse(
        '${ApiConstants.authBaseUrl}$studentPortalEndpoint$encodedPath',
      );

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${currentStudent.value.accessToken}',
        },
      );

      final json = jsonDecode(response.body) as Map<String, dynamic>;

      if (json['statusCode'] == 200) {
        return Right(json['data']['url'] as String);
      }

      return Left(json['message'] as String? ?? 'Failed to get file URL');
    } catch (e) {
      return Left(e.toString());
    }
  }
}