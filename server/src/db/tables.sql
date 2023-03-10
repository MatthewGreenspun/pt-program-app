CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE doctors (
	id UUID NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),
	name VARCHAR(500) NOT NULL,
	email VARCHAR(500) NOT NULL,
	join_code VARCHAR(10) NOT NULL,
	pw_hash VARCHAR(200) NOT NULL
);

CREATE TABLE patients (
	id UUID NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),
	doctor_id UUID REFERENCES doctors(id) ON DELETE CASCADE,
	name VARCHAR(500) NOT NULL,
	email VARCHAR(500) DEFAULT ''
);

CREATE TABLE programs (
	id UUID NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),
	patient_id UUID REFERENCES patients(id) ON DELETE CASCADE,
	name VARCHAR(500) NOT NULL,
	description Text DEFAULT ''
);

CREATE TABLE exercises (
	id UUID NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),
	name VARCHAR(100) NOT NULL,
	media_link VARCHAR(1000) DEFAULT '',
	description Text DEFAULT ''
);

CREATE TABLE program_exercises (
	id UUID NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),
	exercise_id UUID REFERENCES exercises(id) ON DELETE CASCADE,
	program_id UUID REFERENCES programs(id) ON DELETE CASCADE,
	notes Text DEFAULT ''
);


CREATE TYPE unit AS ENUM ('imperial', 'metric');
CREATE TABLE exercise_modifications (
	id UUID NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),
	exercise_id UUID REFERENCES program_exercises(id) ON DELETE CASCADE,
	time TIMESTAMP DEFAULT NOW(),
	sets INTEGER NOT NULL,
	reps INTEGER DEFAULT 0,
	weight DECIMAL DEFAULT 0.0,
	units unit DEFAULT 'imperial',
	hours INTEGER DEFAULT 0,
	minutes INTEGER DEFAULT 0,
	seconds INTEGER DEFAULT 0
);