class TaskModel {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  // Método para converter de Map para TaskModel
  factory TaskModel.fromMap(Map<String, dynamic> data) {
    return TaskModel(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
    );
  }

  // Método para converter de TaskModel para Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }
}
