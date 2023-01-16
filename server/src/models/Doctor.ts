export class Doctor {
  id: string;
  name: string;
  email: string;
  joinCode: string;
  constructor(id: string, name: string, email: string, joinCode: string) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.joinCode = joinCode;
  }
  static fromDb(args: string[]) {
    return new this(args[0], args[1], args[2], args[3]);
  }
  toJson() {
    return {
      id: this.id,
      name: this.name,
      email: this.email,
      joinCode: this.joinCode,
    };
  }
}
