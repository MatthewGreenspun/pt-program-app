export class Program {
  id: string;
  patient: string;
  name: string;
  description?: string;
  constructor(id: string, patient: string, name: string, description: string) {
    this.id = id;
    this.patient = patient;
    this.name = name;
    this.description = description;
  }
  static fromDb(args: string[]) {
    return new this(args[0], args[1], args[2], args[3]);
  }
}
