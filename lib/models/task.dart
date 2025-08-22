class Task {
  final int? id;
  final String title;
  final String description;
  final String category;
  final int points;
  final String assignedTo;
  final String dueDate;
  final bool isDone; 

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.points,
    required this.assignedTo,
    required this.dueDate,
    this.isDone = false, 
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'points': points,
      'assignedTo': assignedTo,
      'dueDate': dueDate,
      'completed': isDone ? 1 : 0, 
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      points: map['points'],
      assignedTo: map['assignedTo'],
      dueDate: map['dueDate'],
      isDone: map['isDone'] == 1, 
    );
  }
}