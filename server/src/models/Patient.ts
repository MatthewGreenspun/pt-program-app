export class Patient {
  id: string;
  doctorId: string;
  name: string;
  email: string;
  programIds: string[];
  programNames: string[];
  constructor(
    id: string,
    doctorId: string,
    name: string,
    email: string,
    programIds: string[],
    programNames: string[]
  ) {
    this.id = id;
    this.doctorId = doctorId;
    this.name = name;
    this.email = email;
    this.programIds = programIds;
    this.programNames = programNames;
  }
  static fromDb(args: any[]) {
    if (args[4][0] == null) {
      return new this(args[0], args[1], args[2], args[3] ?? "", [], []);
    }
    return new this(args[0], args[1], args[2], args[3] ?? "", args[4], args[5]);
  }
}
