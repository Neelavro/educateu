


import '../../domain/entities/security_question_entity.dart';

class SecurityQuestion {
  final String id;
  final String question;

  const SecurityQuestion({
    required this.id,
    required this.question,
  });

  factory SecurityQuestion.fromJson(Map<String, dynamic> json) {
    return SecurityQuestion(
      id: json['id'] as String,
      question: json['question'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'question': question,
  };
  SecurityQuestionEntity toEntity() => SecurityQuestionEntity(
    id: id,
    question: question,
  );
}