class Bottle {
  final String title;
  final String year;
  final String amount;
  final String imagePath;
  final List<Map<String, String>> details;

  Bottle({
    required this.title,
    required this.year,
    required this.amount,
    required this.imagePath,
    this.details = const [],
  });

  factory Bottle.fromJson(Map<String, dynamic> json) {
    final rawDetails = json['details'] as List<dynamic>?;

    return Bottle(
      title: json['title'] as String,
      year: json['year'] as String,
      amount: json['amount'] as String,
      imagePath: json['imagePath'] as String,
      details:
          rawDetails?.map((e) => Map<String, String>.from(e)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'year': year,
    'amount': amount,
    'imagePath': imagePath,
    'details': details,
  };
}
