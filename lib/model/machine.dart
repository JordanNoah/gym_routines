const String tableMachines = 'machine';

class NoteFields {
  static final List<String> values = [id, name];
  static const String id = '_id';
  static const String name = 'name';
}

class Machine {
  final int? id;
  final String name;

  const Machine({this.id, required this.name});

  Machine copy({int? id, String? name}) =>
      Machine(id: id ?? this.id, name: name ?? this.name);

  static Machine fromJson(Map<String, Object?> json) => Machine(
      id: json[NoteFields.id] as int?, name: json[NoteFields.name] as String);
  Map<String, Object?> toJson() => {NoteFields.id: id, NoteFields.name: name};
}
