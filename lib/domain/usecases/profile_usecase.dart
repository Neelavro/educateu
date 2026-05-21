import 'package:dartz/dartz.dart';
import 'package:educateu/domain/entities/profile_entity.dart';
import 'package:educateu/domain/repositories/profile_repository.dart';

class ProfileUseCase {
  final ProfileRepository profileRepository;

  ProfileUseCase({required this.profileRepository});

  Future<Either<String, ProfileEntity>> getProfile() {
    return profileRepository.getProfile();
  }
  Future<Either<String, String>> updateProfile(Map<String, dynamic> payload) {
    return profileRepository.updateProfile(payload);
  }
}