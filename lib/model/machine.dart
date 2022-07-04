const String tableMachines = 'machine';

class NoteFields {
  static final List<String> values = [id, name, type];
  static const String id = '_id';
  static const String name = 'name';
  static const String type = 'type';
}

class Machine {
  final int? id;
  final String name;
  final int type;

  const Machine({this.id, required this.name, required this.type});

  Machine copy({int? id, String? name, int? type}) => Machine(
      id: id ?? this.id, name: name ?? this.name, type: type ?? this.type);

  static Machine fromJson(Map<String, Object?> json) => Machine(
      id: json[NoteFields.id] as int?,
      name: json[NoteFields.name] as String,
      type: json[NoteFields.type] as int);
  Map<String, Object?> toJson() =>
      {NoteFields.id: id, NoteFields.name: name, NoteFields.type: type};
}
