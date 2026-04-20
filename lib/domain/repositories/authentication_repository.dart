import 'package:dartz/dartz.dart';
import 'package:educateu/domain/entities/student_entity.dart';

import '../entities/security_question_entity.dart';

abstract class AuthenticationRepository {
  Future<Either<String, StudentEntity>> login(Map<String, dynamic> payload);
  Future<Either<String, List<SecurityQuestionEntity>>> getSecurityQuestions();
  Future<Either<String, String>> changePassword(Map<String, dynamic> payload);
  Future<Either<String, String>> loginOtp(Map<String, dynamic> payload);
}