class StudentModel {
  final int id;
  final String name;
  final String surname;
  final String? birth;
  final String? adress;
  final String group;

  StudentModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.birth,
    required this.adress,
    required this.group,
  });

  factory StudentModel.fromMap(Map<String, dynamic> data) {
    return StudentModel(
      id: data["id"],
      name: data["name"],
      surname: data["surname"],
      birth: data["birth"],
      adress: data["adress"],
      group: data["group"],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'surname': surname,
        'birth': birth,
        'adress': adress,
        'group': group,
      };
}
