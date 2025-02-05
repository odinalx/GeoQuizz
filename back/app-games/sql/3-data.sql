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

INSERT INTO public.games (id, creator_id, serie_id, status, score, created_at) VALUES ('f0242881-ba19-43aa-b43b-30f33a569fe4', '5f032f38-cf26-4173-898f-9eaed932d78a', 'b51aa681-af69-4c4b-b902-400725071f61', 'CREATED', 0, '05-02-2025 19:38');
INSERT INTO public.games (id, creator_id, serie_id, status, score, created_at) VALUES ('692d300c-7e1d-49c5-9dd0-6db6272229d5', '5f032f38-cf26-4173-898f-9eaed932d78a', 'b51aa681-af69-4c4b-b902-400725071f61', 'CREATED', 0, '05-02-2025 19:38');


--
-- PostgreSQL database dump complete
--

