enum Units {
  imperial,
  metric,
}

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
  exerciseId: string;
  sets: number;
  reps: number;
  time: number;
  weight: number;
  units: Units = Units.imperial;
  notes: string;
  hours: number;
  minutes: number;
  seconds: number;
  constructor(
    id: string,
    exerciseId: string,
    name: string,
    mediaLink: string = "",
    description: string = "",
    notes: string = "",
    sets: number,
    weight: number = 0,
    units: Units = Units.imperial,
    reps: number = 0,
    time: number = 0,
    hours: number,
    minutes: number,
    seconds: number
  ) {
    super(id, name, mediaLink, description);
    this.exerciseId = exerciseId;
    this.sets = sets;
    this.weight = weight;
    this.units = units;
    this.reps = reps;
    this.time = time;
    this.notes = notes;
    this.hours = hours;
    this.minutes = minutes;
    this.seconds = seconds;
  }

  static fromDb(args: any[]) {
    return new this(
      args[0],
      args[1],
      args[2],
      args[3] ?? "",
      args[4] ?? "",
      args[5] ?? "",
      args[6],
      args[7],
      args[8],
      args[9],
      args[10],
      args[11],
      args[12],
      args[13]
    );
  }
}
