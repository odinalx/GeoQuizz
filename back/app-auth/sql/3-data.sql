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
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO public.users (id, email, password, role) VALUES ('445c8ae6-db38-4cb3-a238-0665937abcbf', 'odin@test.com', '$2y$10$elFIBcWSzxuQX7o8Ad7xieQjfp9buspdoWL1HloxVIIX6cY38hK9q', 15);
INSERT INTO public.users (id, email, password, role) VALUES ('5f032f38-cf26-4173-898f-9eaed932d78a', 'victor@test.com', '$2y$10$ljgFp8/jxs05ouycpuDUXePnKiBciPI/j0OEroOkncCEPFfzKm8q2', 15);


--
-- PostgreSQL database dump complete
--

