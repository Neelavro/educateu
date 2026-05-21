import 'package:dartz/dartz.dart';
import 'package:educateu/domain/entities/security_question_entity.dart';
import 'package:educateu/domain/entities/student_entity.dart';
import 'package:educateu/domain/repositories/authentication_repository.dart';

class AuthenticationUseCase {
  final AuthenticationRepository repository;

  AuthenticationUseCase({required this.repository});

  Future<Either<String, StudentEntity>> login(Map<String, dynamic> payload) {
    return repository.login(payload);
  }

  Future<Either<String, List<SecurityQuestionEntity>>> getSecurityQuestions() {
    return repository.getSecurityQuestions();
  }
  Future<Either<String, String>> changePassword(Map<String, dynamic> payload) {
    return repository.changePassword(payload);
  }
  Future<Either<String, StudentEntity>> loginOtp(Map<String, dynamic> payload) {
    return repository.loginOtp(payload);
  }
}