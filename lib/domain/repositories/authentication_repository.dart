import 'package:dartz/dartz.dart';
import 'package:educateu/domain/entities/student_entity.dart';

abstract class AuthenticationRepository {
  Future<Either<String, StudentEntity>> login(Map<String, dynamic> payload);
  Future<Either<String, List<SecurityQuestionEntity>>> getSecurityQuestions();
}