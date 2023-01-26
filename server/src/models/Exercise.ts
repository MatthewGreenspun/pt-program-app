export class Exercise {
  id: string;
  name: string;
  mediaLink: string;
  description: string;

  constructor(
    id: string,
    name: string,
    mediaLink: string = "",
    description: string = ""
  ) {
    this.id = id;
    this.name = name;
    this.mediaLink = mediaLink;
    this.description = description;
  }
  static fromDb(args: string[]) {
    return new this(args[0], args[1], args[2] ?? "", args[3] ?? "");
  }
  toJson() {
    return {
      id: this.id,
      name: this.name,
      mediaLink: this.mediaLink,
      description: this.description,
    };
  }
}

export class ProgramExercise extends Exercise {
  sets: number;
  reps: number;
  time: number;
  weight: number;
  isDone: boolean;
  notes: string;
  constructor(
    id: string,
    name: string,
    sets: number,
    weight: number = 0,
    reps: number = 0,
    time: number = 0,
    mediaLink: string = "",
    description: string = "",
    notes: string = "",
    isDone: boolean = false
  ) {
    super(id, name, mediaLink, description);
    this.sets = sets;
    this.weight = weight;
    this.reps = reps;
    this.time = time;
    this.notes = notes;
    this.isDone = isDone;
  }
}
