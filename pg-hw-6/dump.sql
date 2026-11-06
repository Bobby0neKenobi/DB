--
-- PostgreSQL database dump
--

\restrict 1hOrgqBzkR1iNNFdC3XzNHM77NiDbIxAfrVRbRBqEIKysX7qkom3pwcy8maIoae

-- Dumped from database version 18.6 (Debian 18.6-1.pgdg13+2)
-- Dumped by pg_dump version 18.6 (Debian 18.6-1.pgdg13+2)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: class; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.class (
    id integer CONSTRAINT classes_id_not_null NOT NULL,
    grade smallint CONSTRAINT classes_grade_not_null NOT NULL,
    class character varying(2) CONSTRAINT classes_class_not_null NOT NULL
);


ALTER TABLE public.class OWNER TO postgres;

--
-- Name: classes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.classes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.classes_id_seq OWNER TO postgres;

--
-- Name: classes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.classes_id_seq OWNED BY public.class.id;


--
-- Name: lesson; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lesson (
    id integer NOT NULL,
    class_id integer NOT NULL,
    teacher_id integer NOT NULL,
    period smallint NOT NULL,
    weekday_id integer NOT NULL,
    subject_id integer NOT NULL,
    room_id integer NOT NULL,
    weekday_type_id integer DEFAULT 1 NOT NULL,
    subject_type_id integer DEFAULT 2 NOT NULL,
    room_type_id integer DEFAULT 3 NOT NULL,
    CONSTRAINT lesson_period_check CHECK (((period >= 1) AND (period <= 7))),
    CONSTRAINT lesson_room_type_id_check CHECK ((room_type_id = 3)),
    CONSTRAINT lesson_subject_type_id_check CHECK ((subject_type_id = 2)),
    CONSTRAINT lesson_weekday_type_id_check CHECK ((weekday_type_id = 1))
);


ALTER TABLE public.lesson OWNER TO postgres;

--
-- Name: lesson_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lesson_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lesson_id_seq OWNER TO postgres;

--
-- Name: lesson_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lesson_id_seq OWNED BY public.lesson.id;


--
-- Name: lookup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lookup (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.lookup OWNER TO postgres;

--
-- Name: lookup_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lookup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lookup_id_seq OWNER TO postgres;

--
-- Name: lookup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lookup_id_seq OWNED BY public.lookup.id;


--
-- Name: lookup_value; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lookup_value (
    lookup_id integer NOT NULL,
    id integer NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.lookup_value OWNER TO postgres;

--
-- Name: teacher; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teacher (
    id integer CONSTRAINT teachers_id_not_null NOT NULL,
    first_name character varying(50) CONSTRAINT teachers_first_name_not_null NOT NULL,
    last_name character varying(50) CONSTRAINT teachers_last_name_not_null NOT NULL
);


ALTER TABLE public.teacher OWNER TO postgres;

--
-- Name: teachers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teachers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.teachers_id_seq OWNER TO postgres;

--
-- Name: teachers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teachers_id_seq OWNED BY public.teacher.id;


--
-- Name: class id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class ALTER COLUMN id SET DEFAULT nextval('public.classes_id_seq'::regclass);


--
-- Name: lesson id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson ALTER COLUMN id SET DEFAULT nextval('public.lesson_id_seq'::regclass);


--
-- Name: lookup id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lookup ALTER COLUMN id SET DEFAULT nextval('public.lookup_id_seq'::regclass);


--
-- Name: teacher id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher ALTER COLUMN id SET DEFAULT nextval('public.teachers_id_seq'::regclass);


--
-- Data for Name: class; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.class (id, grade, class) FROM stdin;
1	11	A
2	11	B
\.


--
-- Data for Name: lesson; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lesson (id, class_id, teacher_id, period, weekday_id, subject_id, room_id, weekday_type_id, subject_type_id, room_type_id) FROM stdin;
14	1	1	1	1	1	1	1	2	3
15	1	3	3	1	2	2	1	2	3
16	1	4	4	1	3	3	1	2	3
17	1	5	5	1	4	3	1	2	3
18	2	3	1	1	2	2	1	2	3
19	2	1	2	1	1	2	1	2	3
20	2	1	1	2	1	1	1	2	3
21	2	4	2	2	3	3	1	2	3
22	1	5	1	2	4	3	1	2	3
23	1	1	2	3	1	1	1	2	3
24	2	5	3	3	4	3	1	2	3
25	1	3	1	4	2	2	1	2	3
26	2	3	5	5	2	1	1	2	3
\.


--
-- Data for Name: lookup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lookup (id, name) FROM stdin;
1	weekday
2	subject
3	room
\.


--
-- Data for Name: lookup_value; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lookup_value (lookup_id, id, value) FROM stdin;
1	1	Monday
1	2	Tuesday
1	3	Wednesday
1	4	Thursday
1	5	Friday
2	1	Mathematics
2	2	Gradivni elementi
2	3	Physics
2	4	Databases
3	1	204
3	2	105
3	3	310
\.


--
-- Data for Name: teacher; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teacher (id, first_name, last_name) FROM stdin;
1	Tsvetanka	Todorova
4	Georgi	Parkov
5	Pavel	Belev
3	Bistra	Basheva
\.


--
-- Name: classes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.classes_id_seq', 7, true);


--
-- Name: lesson_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lesson_id_seq', 26, true);


--
-- Name: lookup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lookup_id_seq', 3, true);


--
-- Name: teachers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teachers_id_seq', 5, true);


--
-- Name: class classes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class
    ADD CONSTRAINT classes_pkey PRIMARY KEY (id);


--
-- Name: lesson lesson_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson
    ADD CONSTRAINT lesson_pkey PRIMARY KEY (id);


--
-- Name: lookup lookup_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lookup
    ADD CONSTRAINT lookup_name_key UNIQUE (name);


--
-- Name: lookup lookup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lookup
    ADD CONSTRAINT lookup_pkey PRIMARY KEY (id);


--
-- Name: lookup_value lookup_value_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lookup_value
    ADD CONSTRAINT lookup_value_pkey PRIMARY KEY (lookup_id, id);


--
-- Name: class one_class_combination; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class
    ADD CONSTRAINT one_class_combination UNIQUE (grade, class);


--
-- Name: lesson one_class_per_room_slot; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson
    ADD CONSTRAINT one_class_per_room_slot UNIQUE (room_id, weekday_id, period);


--
-- Name: lesson one_lesson_per_class_slot; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson
    ADD CONSTRAINT one_lesson_per_class_slot UNIQUE (class_id, weekday_id, period);


--
-- Name: lesson one_lesson_per_teacher_slot; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson
    ADD CONSTRAINT one_lesson_per_teacher_slot UNIQUE (teacher_id, weekday_id, period);


--
-- Name: teacher teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (id);


--
-- Name: lesson lesson_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson
    ADD CONSTRAINT lesson_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.class(id);


--
-- Name: lesson lesson_lookup_room_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson
    ADD CONSTRAINT lesson_lookup_room_fkey FOREIGN KEY (room_type_id, room_id) REFERENCES public.lookup_value(lookup_id, id);


--
-- Name: lesson lesson_lookup_subject_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson
    ADD CONSTRAINT lesson_lookup_subject_fkey FOREIGN KEY (subject_type_id, subject_id) REFERENCES public.lookup_value(lookup_id, id);


--
-- Name: lesson lesson_lookup_weekday_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson
    ADD CONSTRAINT lesson_lookup_weekday_fkey FOREIGN KEY (weekday_type_id, weekday_id) REFERENCES public.lookup_value(lookup_id, id);


--
-- Name: lesson lesson_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson
    ADD CONSTRAINT lesson_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.teacher(id);


--
-- Name: lookup_value lookup_value_lookup_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lookup_value
    ADD CONSTRAINT lookup_value_lookup_id_fkey FOREIGN KEY (lookup_id) REFERENCES public.lookup(id);


--
-- PostgreSQL database dump complete
--

\unrestrict 1hOrgqBzkR1iNNFdC3XzNHM77NiDbIxAfrVRbRBqEIKysX7qkom3pwcy8maIoae

