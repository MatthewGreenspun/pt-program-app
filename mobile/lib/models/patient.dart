class Patient {
  String id;
  String doctorId;
  String name;
  String? email;
  List<String> programIds;
  List<String> programNames;
  Patient(this.id, this.doctorId, this.name, this.email, this.programIds,
      this.programNames);

  @override
  String toString() {
    return name;
  }
}
