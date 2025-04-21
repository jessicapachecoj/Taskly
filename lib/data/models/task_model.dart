import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final String userId;
  final DateTime createdAt;
  final bool isCompleted;
  final bool isFavorite;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.createdAt,
    this.isCompleted = false,
    this.isFavorite = false,
  });

  // Corrigindo o método de criação de Task a partir do DocumentSnapshot
  factory Task.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    
    // Verificando se a chave 'createdAt' está disponível
    final createdAt = data['createdAt'] != null ? (data['createdAt'] as Timestamp).toDate() : DateTime.now();
    
    return Task(
      id: snapshot.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      userId: data['userId'] ?? '',
      createdAt: createdAt,
      isCompleted: data['isCompleted'] ?? false,
      isFavorite: data['isFavorite'] ?? false,
    );
  }

  // Método para converter um objeto Task para mapa de dados
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

  // Método para copiar a tarefa com modificações
  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? userId,
    DateTime? createdAt,
    bool? isCompleted,
    bool? isFavorite,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
