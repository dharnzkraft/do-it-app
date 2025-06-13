class Project {
  final String id;
  final String name;
  final DateTime fromDate;
  final DateTime toDate;
  final List<String> members;
  final List<String> tags;
  final String description;
  final String? imagePath;

  Project({
    required this.id,
    required this.name,
    required this.fromDate,
    required this.toDate,
    required this.members,
    required this.tags,
    required this.description,
    this.imagePath,
  });
}
