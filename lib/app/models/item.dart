class Item {
  final String category;
  final String text;
  final String? fileName;
  final int? id;

  Item({required this.category, required this.text, this.fileName, this.id});
}