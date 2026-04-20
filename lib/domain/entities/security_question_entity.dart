
import 'package:equatable/equatable.dart';

class SecurityQuestionEntity extends Equatable {
  final String id;
  final String question;

  const SecurityQuestionEntity({
    required this.id,
    required this.question,
  });

  @override
  List<Object?> get props => [id, question];
}