import 'package:dartz/dartz.dart';
import 'package:educateu/domain/entities/profile_entity.dart';

import '../../data/models/profile_model.dart';

abstract class ProfileRepository {
  Future<Either<String, ProfileEntity>> getProfile();
  Future<Either<String, String>> updateProfile(Map<String, dynamic> payload);
}