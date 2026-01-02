class Feedback {
  final String explaination;
  final String hint;

  Feedback({required this.explaination, required this.hint});

  factory Feedback.fromJson(Map<String, dynamic> json) {
    return Feedback(
      explaination: json['explaination'] as String,
      hint: json['hint'] as String
    );
  }
  Map<String, dynamic> toJson(){
    return {
      'explaination': explaination,
      'hint': hint
    };
  }
}
