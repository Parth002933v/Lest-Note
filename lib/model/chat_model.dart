class NoteModel {
  NoteModel({
    required this.createdAt,
    required this.title,
    required this.content,
    required this.updatedAt,
  });
  late final String createdAt;
  late final String title;
  late final String content;
  late final String updatedAt;

  NoteModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    title = json['title'];
    content = json['content'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['createdAt'] = createdAt;
    _data['title'] = title;
    _data['content'] = content;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}
