--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2 (Debian 17.2-1.pgdg120+1)
-- Dumped by pg_dump version 17.2 (Debian 17.2-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO public.games (id, creator_id, serie_id, status, score, created_at) VALUES ('692d300c-7e1d-49c5-9dd0-6db6272229d5', '5f032f38-cf26-4173-898f-9eaed932d78a', 'b51aa681-af69-4c4b-b902-400725071f61', 'STARTED', 94, '05-02-2025 19:38');
INSERT INTO public.games (id, creator_id, serie_id, status, score, created_at) VALUES ('f0242881-ba19-43aa-b43b-30f33a569fe4', '5f032f38-cf26-4173-898f-9eaed932d78a', '85678cf6-5977-45aa-b727-8d5c677f7e41', 'STARTED', 0, '05-02-2025 19:38');
INSERT INTO public.games (id, creator_id, serie_id, status, score, created_at) VALUES ('6db45d96-42dd-45e2-8238-e42b2fcc0468', '5f032f38-cf26-4173-898f-9eaed932d78a', '85678cf6-5977-45aa-b727-8d5c677f7e41', 'STARTED', 0, '06-02-2025 15:52');


--
-- Data for Name: game_photos; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO public.game_photos (game_id, photo_id) VALUES ('6db45d96-42dd-45e2-8238-e42b2fcc0468', '00ed930e-e697-4b2a-96a4-92f84ed79aec');
INSERT INTO public.game_photos (game_id, photo_id) VALUES ('6db45d96-42dd-45e2-8238-e42b2fcc0468', '3f616107-69e6-4586-afc3-8a73c6b86891');
INSERT INTO public.game_photos (game_id, photo_id) VALUES ('6db45d96-42dd-45e2-8238-e42b2fcc0468', '93b2408f-eb3a-492f-98f1-fd71c7f702e1');
INSERT INTO public.game_photos (game_id, photo_id) VALUES ('6db45d96-42dd-45e2-8238-e42b2fcc0468', '788af01e-36c3-4805-872c-c007c7758624');
INSERT INTO public.game_photos (game_id, photo_id) VALUES ('6db45d96-42dd-45e2-8238-e42b2fcc0468', 'f4b0d799-e1ff-4506-a783-b6cab4ef0f06');
INSERT INTO public.game_photos (game_id, photo_id) VALUES ('6db45d96-42dd-45e2-8238-e42b2fcc0468', '207178a9-c5ae-4808-bafa-8f608913b4dc');
INSERT INTO public.game_photos (game_id, photo_id) VALUES ('6db45d96-42dd-45e2-8238-e42b2fcc0468', '82fc87f1-453a-4e54-9e37-b216aeb1af9c');
INSERT INTO public.game_photos (game_id, photo_id) VALUES ('6db45d96-42dd-45e2-8238-e42b2fcc0468', '6a6a491c-a6a7-4e76-b2f3-3e0f337a3fd3');
INSERT INTO public.game_photos (game_id, photo_id) VALUES ('6db45d96-42dd-45e2-8238-e42b2fcc0468', 'ecc7ba07-95d1-4671-acd1-d975a676bed9');
INSERT INTO public.game_photos (game_id, photo_id) VALUES ('6db45d96-42dd-45e2-8238-e42b2fcc0468', 'a3e4f064-84f4-402f-a9e6-9b00ce361c50');


--
-- PostgreSQL database dump complete
--

