

import 'package:dartz/dartz.dart';
import 'package:educateu/domain/entities/student_entity.dart';
import 'package:educateu/domain/repositories/authentication_repository.dart';

class AuthenticationUseCase {
  final AuthenticationRepository repository;

  AuthenticationUseCase({required this.repository});

  Future<Either<String, StudentEntity>> login(Map<String, dynamic> payload) {
    return repository.login(payload);
  }
}