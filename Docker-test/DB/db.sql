CREATE TABLE "client" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "username" varchar(150) UNIQUE NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "password" varchar(255) NOT NULL,
  "first_name" varchar(30) NOT NULL,
  "last_name" varchar(30) NOT NULL,
  "is_staff" bool,
  "is_superuser" bool
);

CREATE TABLE "staff" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "username" varchar(150) UNIQUE NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "password" varchar(255) NOT NULL,
  "is_staff" bool,
  "is_superuser" bool,
  "staff_type" int
);

CREATE TABLE "staff_type" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "type" varchar(100) NOT NULL
);

CREATE TABLE "group" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" varchar
);

CREATE TABLE "client_groups" (
  "client" int,
  "group" int
);

CREATE TABLE "staff_groups" (
  "staff" int,
  "group" int
);

CREATE TABLE "permission" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" varchar
);

CREATE TABLE "client_permissions" (
  "client" int,
  "permission" int
);

CREATE TABLE "staff_permissions" (
  "staff" int,
  "permission" int
);

CREATE TABLE "flight" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "flight_number" varchar(10) UNIQUE NOT NULL,
  "departure" timestamptz NOT NULL,
  "arrival" timestamptz NOT NULL,
  "plane" int,
  "track_origin" int,
  "track_destination" int
);

CREATE TABLE "plane" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "model" varchar(100) NOT NULL,
  "second_class_capacity" int NOT NULL,
  "first_class_capacity" int NOT NULL
);

CREATE TABLE "booking" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "booking_date" timestamptz DEFAULT (CURRENT_TIMESTAMP),
  "price" float NOT NULL,
  "booking_type" int,
  "client" int,
  "flight" int
);

CREATE TABLE "booking_type" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "type" varchar(30) NOT NULL
);

CREATE TABLE "working" (
  "staff" int,
  "flight" int
);

CREATE TABLE "airport" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" varchar(100) NOT NULL,
  "location" varchar(100) NOT NULL
);

CREATE TABLE "track" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "track_number" varchar(10) NOT NULL,
  "length" int NOT NULL,
  "airport" int
);

ALTER TABLE "staff" ADD FOREIGN KEY ("staff_type") REFERENCES "staff_type" ("id");

ALTER TABLE "client_groups" ADD FOREIGN KEY ("client") REFERENCES "client" ("id");

ALTER TABLE "client_groups" ADD FOREIGN KEY ("group") REFERENCES "group" ("id");

ALTER TABLE "staff_groups" ADD FOREIGN KEY ("staff") REFERENCES "staff" ("id");

ALTER TABLE "staff_groups" ADD FOREIGN KEY ("group") REFERENCES "group" ("id");

ALTER TABLE "client_permissions" ADD FOREIGN KEY ("client") REFERENCES "client" ("id");

ALTER TABLE "client_permissions" ADD FOREIGN KEY ("permission") REFERENCES "permission" ("id");

ALTER TABLE "staff_permissions" ADD FOREIGN KEY ("staff") REFERENCES "staff" ("id");

ALTER TABLE "staff_permissions" ADD FOREIGN KEY ("permission") REFERENCES "permission" ("id");

ALTER TABLE "flight" ADD FOREIGN KEY ("plane") REFERENCES "plane" ("id");

ALTER TABLE "flight" ADD FOREIGN KEY ("track_origin") REFERENCES "track" ("id");

ALTER TABLE "flight" ADD FOREIGN KEY ("track_destination") REFERENCES "track" ("id");

ALTER TABLE "booking" ADD FOREIGN KEY ("booking_type") REFERENCES "booking_type" ("id");

ALTER TABLE "booking" ADD FOREIGN KEY ("client") REFERENCES "client" ("id");

ALTER TABLE "booking" ADD FOREIGN KEY ("flight") REFERENCES "flight" ("id");

ALTER TABLE "working" ADD FOREIGN KEY ("staff") REFERENCES "staff" ("id");

ALTER TABLE "working" ADD FOREIGN KEY ("flight") REFERENCES "flight" ("id");

ALTER TABLE "track" ADD FOREIGN KEY ("airport") REFERENCES "airport" ("id");
