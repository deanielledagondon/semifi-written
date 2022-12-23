class TaskModel {
  int? id;
  final String title;
  DateTime createdAt;
  bool isChecked;

  TaskModel({
    this.id,
    required this.title,
    required this.createdAt,
    required this.isChecked,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'creationDate': createdAt.toString(),
      'isChecked': isChecked ? 1 : 0,
    };
  }

  @override
  String toString() {
    return 'TaskModel(id : $id, title : $title, createdAt : $createdAt, isChecked : $isChecked)';
  }
}
