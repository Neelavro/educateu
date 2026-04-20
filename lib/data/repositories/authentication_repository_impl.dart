import 'dart:convert';
import '../../core/helper.dart';
import 'package:dartz/dartz.dart';
import 'package:educateu/domain/entities/student_entity.dart';
import 'package:educateu/domain/repositories/authentication_repository.dart';
import 'package:http/http.dart' as http;
import '../../core/urls.dart';
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
        currentStudent.value = s;
        return Right(s);
      }

      return Left(json['message'] as String? ?? 'Login failed');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<SecurityQuestion>>> getSecurityQuestions()async{
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
        currentStudent.value = s;
        return Right(s);
      }

      return Left(json['message'] as String? ?? 'Login failed');
    } catch (e) {
      return Left(e.toString());
    }
  }
}