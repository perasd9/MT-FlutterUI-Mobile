class Exercise {
  int? exerciseId;
  String naziv;

  Exercise({this.exerciseId, required this.naziv});

  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'naziv': naziv,
    };
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      exerciseId: json['vezbaId'],
      naziv: json['naziv'],
    );
  }

  @override
  String toString() {
    return naziv;
  }
  @override
  int get hashCode => super.hashCode;
}