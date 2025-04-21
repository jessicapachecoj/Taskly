class Task {
  String? id;
  String title;
  String description;
  DateTime createdAt;
  bool isCompleted;
  bool isFavorite;
  String userId;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.userId,
    DateTime? createdAt,
    this.isCompleted = false,
    this.isFavorite = false,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      userId: map['userId'],
      createdAt: map['createdAt'].toDate(),
      isCompleted: map['isCompleted'],
      isFavorite: map['isFavorite'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'userId': userId,
      'createdAt': createdAt,
      'isCompleted': isCompleted,
      'isFavorite': isFavorite,
    };
  }
}