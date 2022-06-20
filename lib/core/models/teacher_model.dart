class TeacherModel {
  final String id;
  final String name;
  final String surname;
  final List<String> groupsList;
  final String uid;

  TeacherModel(
    this.id,
    this.name,
    this.surname,
    this.groupsList,
    this.uid,
  );
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'surname': surname,
        'groups_list': groupsList,
        'uid': uid,
      };
}
