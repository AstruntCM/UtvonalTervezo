--
-- PostgreSQL database dump
--

\restrict vnPkaZwiBStaUQkfUsD28XbErecOxt1uXpAi980vLEZUIf6OqDh5XR0fSgzWA4Q

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2026-03-08 13:59:48

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
-- TOC entry 221 (class 1259 OID 25466)
-- Name: connection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.connection (
    connection_id integer NOT NULL,
    stop_a integer NOT NULL,
    stop_b integer NOT NULL,
    duration smallint,
    route_id integer NOT NULL,
    "order" smallint
);


ALTER TABLE public.connection OWNER TO postgres;

--
-- TOC entry 4956 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN connection.stop_a; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.connection.stop_a IS 'kulcs';


--
-- TOC entry 4957 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN connection.stop_b; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.connection.stop_b IS 'kulcs';


--
-- TOC entry 4958 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN connection.duration; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.connection.duration IS 'A és B megállók közötti utazási idő percben';


--
-- TOC entry 4959 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN connection.route_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.connection.route_id IS 'kulcs';


--
-- TOC entry 4960 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN connection."order"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.connection."order" IS 'Azt jelenti, hogy hányadik A-B szakasz a route-on, mert nehéz lenne összekötni ezeket a szakaszokat.';


--
-- TOC entry 222 (class 1259 OID 25474)
-- Name: connection_connection_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.connection ALTER COLUMN connection_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.connection_connection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 25460)
-- Name: route; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.route (
    route_id integer NOT NULL,
    route_name character varying(100)
);


ALTER TABLE public.route OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 25475)
-- Name: route_route_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.route ALTER COLUMN route_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.route_route_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 25453)
-- Name: stop; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stop (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.stop OWNER TO postgres;

--
-- TOC entry 4961 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE stop; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.stop IS 'Egyetlen megálló';


--
-- TOC entry 4962 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN stop.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.stop.id IS 'max áttesszük integerre, ha kevés (32.767)';


--
-- TOC entry 224 (class 1259 OID 25476)
-- Name: stop_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.stop ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.stop_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 225 (class 1259 OID 25479)
-- Name: timetable; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.timetable (
    route_id integer NOT NULL,
    start_time timestamp with time zone NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.timetable OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 25485)
-- Name: timetable_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.timetable ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.timetable_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 25493)
-- Name: trip; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trip (
    trip_id smallint NOT NULL,
    total_duration smallint NOT NULL
);


ALTER TABLE public.trip OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 25501)
-- Name: trip_segment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trip_segment (
    id integer NOT NULL,
    trip_id smallint NOT NULL,
    schedule_id integer NOT NULL,
    on_stop integer NOT NULL,
    off_stop integer NOT NULL
);


ALTER TABLE public.trip_segment OWNER TO postgres;

--
-- TOC entry 4963 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN trip_segment.schedule_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.trip_segment.schedule_id IS 'Ebből tudjuk, hogy pl a 4-es villamosra szállt fel 8:00-kor (timetable hozzáfér a routehoz)';


--
-- TOC entry 4964 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN trip_segment.on_stop; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.trip_segment.on_stop IS 'melyik megállónál szállt fel (pl 1)';


--
-- TOC entry 4965 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN trip_segment.off_stop; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.trip_segment.off_stop IS 'Melyik megállónál szállt le (pl 4)';


--
-- TOC entry 229 (class 1259 OID 25500)
-- Name: trip_segment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.trip_segment ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.trip_segment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 25492)
-- Name: trip_trip_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.trip ALTER COLUMN trip_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.trip_trip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4941 (class 0 OID 25466)
-- Dependencies: 221
-- Data for Name: connection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.connection (connection_id, stop_a, stop_b, duration, route_id, "order") FROM stdin;
\.


--
-- TOC entry 4940 (class 0 OID 25460)
-- Dependencies: 220
-- Data for Name: route; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.route (route_id, route_name) FROM stdin;
\.


--
-- TOC entry 4939 (class 0 OID 25453)
-- Dependencies: 219
-- Data for Name: stop; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stop (id, name) FROM stdin;
\.


--
-- TOC entry 4945 (class 0 OID 25479)
-- Dependencies: 225
-- Data for Name: timetable; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.timetable (route_id, start_time, id) FROM stdin;
\.


--
-- TOC entry 4948 (class 0 OID 25493)
-- Dependencies: 228
-- Data for Name: trip; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trip (trip_id, total_duration) FROM stdin;
\.


--
-- TOC entry 4950 (class 0 OID 25501)
-- Dependencies: 230
-- Data for Name: trip_segment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trip_segment (id, trip_id, schedule_id, on_stop, off_stop) FROM stdin;
\.


--
-- TOC entry 4966 (class 0 OID 0)
-- Dependencies: 222
-- Name: connection_connection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.connection_connection_id_seq', 1, false);


--
-- TOC entry 4967 (class 0 OID 0)
-- Dependencies: 223
-- Name: route_route_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.route_route_id_seq', 1, false);


--
-- TOC entry 4968 (class 0 OID 0)
-- Dependencies: 224
-- Name: stop_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stop_id_seq', 1, false);


--
-- TOC entry 4969 (class 0 OID 0)
-- Dependencies: 226
-- Name: timetable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.timetable_id_seq', 1, false);


--
-- TOC entry 4970 (class 0 OID 0)
-- Dependencies: 229
-- Name: trip_segment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trip_segment_id_seq', 1, false);


--
-- TOC entry 4971 (class 0 OID 0)
-- Dependencies: 227
-- Name: trip_trip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trip_trip_id_seq', 1, false);


--
-- TOC entry 4785 (class 2606 OID 25473)
-- Name: connection connection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.connection
    ADD CONSTRAINT connection_pkey PRIMARY KEY (connection_id);


--
-- TOC entry 4783 (class 2606 OID 25465)
-- Name: route route_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.route
    ADD CONSTRAINT route_pkey PRIMARY KEY (route_id);


--
-- TOC entry 4781 (class 2606 OID 25513)
-- Name: stop stop_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stop
    ADD CONSTRAINT stop_pkey PRIMARY KEY (id);


--
-- TOC entry 4787 (class 2606 OID 25491)
-- Name: timetable timetable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetable
    ADD CONSTRAINT timetable_pkey PRIMARY KEY (id);


--
-- TOC entry 4789 (class 2606 OID 25499)
-- Name: trip trip_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_pkey PRIMARY KEY (trip_id);


--
-- TOC entry 4791 (class 2606 OID 25510)
-- Name: trip_segment trip_segment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trip_segment
    ADD CONSTRAINT trip_segment_pkey PRIMARY KEY (id);


-- Completed on 2026-03-08 13:59:48

--
-- PostgreSQL database dump complete
--

\unrestrict vnPkaZwiBStaUQkfUsD28XbErecOxt1uXpAi980vLEZUIf6OqDh5XR0fSgzWA4Q

