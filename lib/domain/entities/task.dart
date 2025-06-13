class Task {
  final String name;
  final String id;
  final DateTime fromDate;
  final DateTime toDate;
  final String assignedMember;
  final String tag;
  final String comment;

  Task({
    required this.name,
    required this.id,
    required this.fromDate,
    required this.toDate,
    required this.assignedMember,
    required this.tag,
    required this.comment,
  });
}