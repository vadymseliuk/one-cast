class Bottle {
  final String title;
  final String year;
  final String amount;
  final String imagePath;
  final List<Map<String, String>> details;

  final TastingNotes? tastingNotes;
  final YourNotes? yourNotes;
  final List<HistoryItem> history;

  Bottle({
    required this.title,
    required this.year,
    required this.amount,
    required this.imagePath,
    this.details = const [],
    this.tastingNotes,
    this.yourNotes,
    this.history = const [],
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
      tastingNotes: json['tastingNotes'] != null
          ? TastingNotes.fromJson(json['tastingNotes'])
          : null,
      yourNotes: json['yourNotes'] != null
          ? YourNotes.fromJson(json['yourNotes'])
          : null,
      history:
          (json['history'] as List<dynamic>?)
              ?.map((e) => HistoryItem.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'year': year,
    'amount': amount,
    'imagePath': imagePath,
    'details': details,
    'tastingNotes': tastingNotes?.toJson(),
    'yourNotes': yourNotes?.toJson(),
    'history': history.map((h) => h.toJson()).toList(),
  };
}

class TastingNotes {
  final String by;
  final String nose;
  final String palate;
  final String finish;

  TastingNotes({
    required this.by,
    required this.nose,
    required this.palate,
    required this.finish,
  });

  factory TastingNotes.fromJson(Map<String, dynamic> json) {
    return TastingNotes(
      by: json['by'] ?? '',
      nose: json['nose'] ?? '',
      palate: json['palate'] ?? '',
      finish: json['finish'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'by': by,
    'nose': nose,
    'palate': palate,
    'finish': finish,
  };
}

class YourNotes {
  final String nose;
  final String palate;
  final String finish;

  YourNotes({required this.nose, required this.palate, required this.finish});

  factory YourNotes.fromJson(Map<String, dynamic> json) {
    return YourNotes(
      nose: json['nose'] ?? '',
      palate: json['palate'] ?? '',
      finish: json['finish'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'nose': nose,
    'palate': palate,
    'finish': finish,
  };
}

class HistoryItem {
  final String title;
  final String description;
  final List<String> attachments;

  HistoryItem({
    required this.title,
    required this.description,
    required this.attachments,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      attachments: List<String>.from(json['attachments'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'attachments': attachments,
  };
}
