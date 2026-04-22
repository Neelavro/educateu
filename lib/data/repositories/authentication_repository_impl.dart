import 'dart:convert';
import 'package:educateu/domain/entities/security_question_entity.dart';

import '../../core/helper.dart';
import 'package:dartz/dartz.dart';
import 'package:educateu/domain/entities/student_entity.dart';
import 'package:educateu/domain/repositories/authentication_repository.dart';
import 'package:http/http.dart' as http;
import '../../core/urls.dart';
import '../models/security_question_model.dart';
import '../models/student_model.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  Future<Either<String, StudentEntity>> login(Map<String, dynamic> payload) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.authBaseUrl}${studentEndpoint}${loginEndpoint}',
      );

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      final json = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final StudentEntity s = Student.fromJson(json).toEntity();

        return Right(s);
      }

      return Left(json['message'] as String? ?? 'Login failed');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<SecurityQuestionEntity>>> getSecurityQuestions() async {
    print('${ApiConstants.authBaseUrl}$studentEndpoint$securityQuestionEndpoint',);
    try {
      final url = Uri.parse(
        '${ApiConstants.authBaseUrl}$securityQuestionEndpoint',
      );


      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final json = jsonDecode(response.body);
      print("object");
      print(json);
      if (json["statusCode"] == 200) {
        final List<SecurityQuestionEntity> questions = (json['data']['questions'] as List)
            .map((e) => SecurityQuestion.fromJson(e as Map<String, dynamic>).toEntity())
            .toList();
        print(questions);
        return Right(questions);
      }

      final error = (json as Map<String, dynamic>)['message'] as String? ?? 'Failed to fetch security questions';
      return Left(error);
    } catch (e) {
      return Left(e.toString());
    }
  }
  @override
  Future<Either<String, String>> changePassword(Map<String, dynamic> payload) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.authBaseUrl}${changePasswordEndpoint}',
      );

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json',
          'Authorization': 'Bearer ${currentStudent.value.accessToken}',
        },


        body: jsonEncode(payload),
      );

      final json = jsonDecode(response.body) as Map<String, dynamic>;

      if (json["statusCode"] == 200) {
        return Right(json['message']);
      }

      return Left(json['message'] as String? ?? 'Login failed');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, StudentEntity>> loginOtp(Map<String, dynamic> payload) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.authBaseUrl}${sendOtpEndPoint}',
      );

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json',
          'Authorization': 'Bearer ${currentStudent.value.accessToken}',
        },


        body: jsonEncode(payload),
      );

      final json = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final StudentEntity s = Student.fromJson(json).toEntity();

        return Right(s);
      }

      return Left(json['message'] as String? ?? 'Login failed');
    } catch (e) {
      return Left(e.toString());
    }
  }

}