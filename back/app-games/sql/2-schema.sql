DROP TABLE IF EXISTS "games";

CREATE TABLE "public"."games" (
    "id" uuid NOT NULL,
    "creator_id" uuid NOT NULL,
    "serie_id" uuid NOT NULL,
    "status" VARCHAR(30) NOT NULL,
    "score" integer NOT NULL,
    "created_at" VARCHAR(30) NOT NULL
);

ALTER TABLE games ADD PRIMARY KEY (id);

CREATE TABLE game_photos (
    game_id UUID NOT NULL,
    photo_id UUID NOT NULL,
    PRIMARY KEY (game_id, photo_id),
    FOREIGN KEY (game_id) REFERENCES games(id) ON DELETE CASCADE
);