class TaskEntity {
  final int id;
  final String username;
  final String title;
  final String? description;
  final bool isCompleted;

  TaskEntity({
    required this.id,
    required this.username,
    required this.title,
    this.description,
    required this.isCompleted,
  });

  factory TaskEntity.fromJson(Map<String, dynamic> json) {
    return TaskEntity(
      id: json['id'] as int,
      username: json['username'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      isCompleted: json['is_completed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'title': title,
      if (description != null) 'description': description,
      'is_completed': isCompleted,
    };
  }

  TaskEntity copyWith({
    int? id,
    String? username,
    String? title,
    String? description,
    bool? isCompleted,
    bool setToNullDescription =
        false, // Para permitir establecer 'description' a null explícitamente
  }) {
    return TaskEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      title: title ?? this.title,
      description: setToNullDescription
          ? null
          : (description ?? this.description),
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() {
    return 'TaskDto(id: $id, username: "$username", title: "$title", description: "$description", isCompleted: $isCompleted)';
  }

  @override
  bool operator == (Object other) {
    if (identical(this, other)) return true;

    return other is TaskEntity &&
        other.id == id &&
        other.username == username &&
        other.title == title &&
        other.description == description &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        title.hashCode ^
        description.hashCode ^
        isCompleted.hashCode;
  }
}
