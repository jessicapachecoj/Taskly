class TaskModel {
  String id; // Agora o id é mutável
  final String title;
  final String description;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  // Atualizado para não receber o ID na criação, o ID será atribuído depois
  factory TaskModel.fromMap(Map<String, dynamic> data) {
    return TaskModel(
      id: '', // O ID será atribuído depois
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }
}
