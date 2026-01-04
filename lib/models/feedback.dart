class FeedbackModel {
  final String explaination;
  final String hint;

  FeedbackModel({required this.explaination, required this.hint});

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
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
