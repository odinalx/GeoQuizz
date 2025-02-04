DROP TABLE IF EXISTS "games";

CREATE TABLE "public"."games" (
    "id" uuid NOT NULL,
    "creator_id" uuid NOT NULL,
    "serie_id" uuid NOT NULL,
    "status" VARCHAR(30) NOT NULL,
    "score" integer NOT NULL,
    "created_at" VARCHAR(30) NOT NULL
);
