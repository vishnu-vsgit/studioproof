/// Studio Proof Project Data Model
class Project {
  final String id;
  final String title;
  final String category;
  final String year;
  final String tagline;
  final String clientType;
  final String description;
  final List<String> deliverables;
  final String imageAsset;
  final double aspectRatio;

  const Project({
    required this.id,
    required this.title,
    required this.category,
    required this.year,
    required this.tagline,
    required this.clientType,
    required this.description,
    required this.deliverables,
    required this.imageAsset,
    this.aspectRatio = 0.75, // Default portrait poster ratio
  });
}
