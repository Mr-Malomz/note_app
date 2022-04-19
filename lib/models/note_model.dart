class Note {
  final String? $id;
  final String title;
  final String note;

  Note({this.$id, required this.title, required this.note});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note($id: json['\$id'], title: json['title'], note: json['note']);
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'note': note};
  }
}
