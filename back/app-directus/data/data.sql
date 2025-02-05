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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: directus_access; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_access (
    id uuid NOT NULL,
    role uuid,
    "user" uuid,
    policy uuid NOT NULL,
    sort integer
);


ALTER TABLE public.directus_access OWNER TO root;

--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50),
    user_agent text,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    origin character varying(255)
);


ALTER TABLE public.directus_activity OWNER TO root;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_activity_id_seq OWNER TO root;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(64),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying,
    color character varying(255),
    item_duplication_fields json,
    sort integer,
    "group" character varying(64),
    collapse character varying(255) DEFAULT 'open'::character varying NOT NULL,
    preview_url character varying(255),
    versioning boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_collections OWNER TO root;

--
-- Name: directus_comments; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_comments (
    id uuid NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid
);


ALTER TABLE public.directus_comments OWNER TO root;

--
-- Name: directus_dashboards; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_dashboards (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64) DEFAULT 'dashboard'::character varying NOT NULL,
    note text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    color character varying(255)
);


ALTER TABLE public.directus_dashboards OWNER TO root;

--
-- Name: directus_extensions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_extensions (
    enabled boolean DEFAULT true NOT NULL,
    id uuid NOT NULL,
    folder character varying(255) NOT NULL,
    source character varying(255) NOT NULL,
    bundle uuid
);


ALTER TABLE public.directus_extensions OWNER TO root;

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    translations json,
    note text,
    conditions json,
    required boolean DEFAULT false,
    "group" character varying(64),
    validation json,
    validation_message text
);


ALTER TABLE public.directus_fields OWNER TO root;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_fields_id_seq OWNER TO root;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize bigint,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json,
    focal_point_x integer,
    focal_point_y integer,
    tus_id character varying(64),
    tus_data json,
    uploaded_on timestamp with time zone
);


ALTER TABLE public.directus_files OWNER TO root;

--
-- Name: directus_flows; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_flows (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64),
    color character varying(255),
    description text,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    trigger character varying(255),
    accountability character varying(255) DEFAULT 'all'::character varying,
    options json,
    operation uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_flows OWNER TO root;

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


ALTER TABLE public.directus_folders OWNER TO root;

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO root;

--
-- Name: directus_notifications; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_notifications (
    id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(255) DEFAULT 'inbox'::character varying,
    recipient uuid NOT NULL,
    sender uuid,
    subject character varying(255) NOT NULL,
    message text,
    collection character varying(64),
    item character varying(255)
);


ALTER TABLE public.directus_notifications OWNER TO root;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.directus_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_notifications_id_seq OWNER TO root;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.directus_notifications_id_seq OWNED BY public.directus_notifications.id;


--
-- Name: directus_operations; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_operations (
    id uuid NOT NULL,
    name character varying(255),
    key character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    options json,
    resolve uuid,
    reject uuid,
    flow uuid NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_operations OWNER TO root;

--
-- Name: directus_panels; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_panels (
    id uuid NOT NULL,
    dashboard uuid NOT NULL,
    name character varying(255),
    icon character varying(64) DEFAULT NULL::character varying,
    color character varying(10),
    show_header boolean DEFAULT false NOT NULL,
    note text,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    options json,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_panels OWNER TO root;

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text,
    policy uuid NOT NULL
);


ALTER TABLE public.directus_permissions OWNER TO root;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_permissions_id_seq OWNER TO root;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_policies; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_policies (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'badge'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_policies OWNER TO root;

--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer,
    filter json,
    icon character varying(64) DEFAULT 'bookmark'::character varying,
    color character varying(255)
);


ALTER TABLE public.directus_presets OWNER TO root;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_presets_id_seq OWNER TO root;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(64),
    one_deselect_action character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


ALTER TABLE public.directus_relations OWNER TO root;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_relations_id_seq OWNER TO root;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer,
    version uuid
);


ALTER TABLE public.directus_revisions OWNER TO root;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_revisions_id_seq OWNER TO root;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    parent uuid
);


ALTER TABLE public.directus_roles OWNER TO root;

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent text,
    share uuid,
    origin character varying(255),
    next_token character varying(64)
);


ALTER TABLE public.directus_sessions OWNER TO root;

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(255) DEFAULT '#6644FF'::character varying NOT NULL,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text,
    storage_default_folder uuid,
    basemaps json,
    mapbox_key character varying(255),
    module_bar json,
    project_descriptor character varying(100),
    default_language character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    custom_aspect_ratios json,
    public_favicon uuid,
    default_appearance character varying(255) DEFAULT 'auto'::character varying NOT NULL,
    default_theme_light character varying(255),
    theme_light_overrides json,
    default_theme_dark character varying(255),
    theme_dark_overrides json,
    report_error_url character varying(255),
    report_bug_url character varying(255),
    report_feature_url character varying(255),
    public_registration boolean DEFAULT false NOT NULL,
    public_registration_verify_email boolean DEFAULT true NOT NULL,
    public_registration_role uuid,
    public_registration_email_filter json
);


ALTER TABLE public.directus_settings OWNER TO root;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_settings_id_seq OWNER TO root;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_shares; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_shares (
    id uuid NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    role uuid,
    password character varying(255),
    user_created uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    times_used integer DEFAULT 0,
    max_uses integer
);


ALTER TABLE public.directus_shares OWNER TO root;

--
-- Name: directus_translations; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_translations (
    id uuid NOT NULL,
    language character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.directus_translations OWNER TO root;

--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128),
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(255) DEFAULT NULL::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255),
    provider character varying(128) DEFAULT 'default'::character varying NOT NULL,
    external_identifier character varying(255),
    auth_data json,
    email_notifications boolean DEFAULT true,
    appearance character varying(255),
    theme_dark character varying(255),
    theme_light character varying(255),
    theme_light_overrides json,
    theme_dark_overrides json
);


ALTER TABLE public.directus_users OWNER TO root;

--
-- Name: directus_versions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_versions (
    id uuid NOT NULL,
    key character varying(64) NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    hash character varying(255),
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid,
    delta json
);


ALTER TABLE public.directus_versions OWNER TO root;

--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url character varying(255) NOT NULL,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections character varying(255) NOT NULL,
    headers json,
    was_active_before_deprecation boolean DEFAULT false NOT NULL,
    migrated_flow uuid
);


ALTER TABLE public.directus_webhooks OWNER TO root;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_webhooks_id_seq OWNER TO root;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: photos; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.photos (
    id uuid NOT NULL,
    serie_id uuid,
    name character varying(255),
    lat character varying(255),
    long character varying(255),
    url character varying(255),
    link character varying(255)
);


ALTER TABLE public.photos OWNER TO root;

--
-- Name: series; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.series (
    id uuid NOT NULL,
    name character varying(255),
    description character varying(255)
);


ALTER TABLE public.series OWNER TO root;

--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_notifications id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_notifications ALTER COLUMN id SET DEFAULT nextval('public.directus_notifications_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- Data for Name: directus_access; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_access (id, role, "user", policy, sort) FROM stdin;
2342d796-045a-49d1-a88c-b67180bb8c0f	\N	\N	abf8a154-5b1c-4a46-ac9c-7300570f4f17	1
606653a4-d132-4246-80f0-59ff9f6f0efb	105cea0d-738a-437b-9183-a23a33deacde	\N	e36db6ca-f905-43df-bf77-de2846a7eb8a	\N
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, origin) FROM stdin;
1	login	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:47:20.798+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	9d83a681-8388-4ff9-ae4b-7038fad0560a	http://localhost:33556
2	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:47:45.762+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	1	http://localhost:33556
3	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:47:45.767+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_collections	series	http://localhost:33556
4	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:47:52.107+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	2	http://localhost:33556
5	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:48:00.93+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	3	http://localhost:33556
6	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:48:26.791+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	series	85678cf6-5977-45aa-b727-8d5c677f7e41	http://localhost:33556
7	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:48:57.999+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	4	http://localhost:33556
8	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:48:58.003+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_collections	photos	http://localhost:33556
9	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:10.379+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	5	http://localhost:33556
10	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:15.713+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	6	http://localhost:33556
11	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:20.742+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	7	http://localhost:33556
12	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:25.528+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	8	http://localhost:33556
13	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:30.057+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	9	http://localhost:33556
14	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:35.069+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	10	http://localhost:33556
15	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.711+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	55d1ecb2-82d9-445c-996b-68f7d1862432	http://localhost:33556
16	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.714+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	4d6c147e-2cdd-47a8-962a-5a8754f0a0fb	http://localhost:33556
17	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.715+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	93b2408f-eb3a-492f-98f1-fd71c7f702e1	http://localhost:33556
18	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.717+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	82fc87f1-453a-4e54-9e37-b216aeb1af9c	http://localhost:33556
19	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.719+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	6a6a491c-a6a7-4e76-b2f3-3e0f337a3fd3	http://localhost:33556
20	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.721+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	f13c4c48-503b-4131-9856-77137afab803	http://localhost:33556
21	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.723+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	969b7872-14f8-4f2a-8b13-4905d0dc088e	http://localhost:33556
22	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.725+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	ecc7ba07-95d1-4671-acd1-d975a676bed9	http://localhost:33556
23	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.727+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	cb8b71b4-7989-4b6c-a68d-182ec0475648	http://localhost:33556
24	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.728+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	d1ad5874-64df-40c8-8639-6728e614298d	http://localhost:33556
25	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.73+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	3f616107-69e6-4586-afc3-8a73c6b86891	http://localhost:33556
26	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.732+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	211f70c8-8e04-4b97-8f84-328e8b043344	http://localhost:33556
27	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.734+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	94d5df24-03eb-4e4d-87ca-a4fce91d8c34	http://localhost:33556
28	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.736+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	a74fb23e-1ba0-4ac0-8391-dad8b06b81d9	http://localhost:33556
29	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.738+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	2bf6df61-3bc2-4d0b-b5d9-5ebc094c04c3	http://localhost:33556
30	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.741+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	5c6dc88e-be57-4e8e-8789-fda2d396cec5	http://localhost:33556
31	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.743+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	00ed930e-e697-4b2a-96a4-92f84ed79aec	http://localhost:33556
32	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.745+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	a3e4f064-84f4-402f-a9e6-9b00ce361c50	http://localhost:33556
33	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.748+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	c05787a9-0e6f-4502-a932-ee5881addc7b	http://localhost:33556
34	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.75+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	41874312-d6a0-48e3-b16c-1be8e7cf9d44	http://localhost:33556
35	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.753+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	588f48b7-3d1e-4ceb-bdfe-bfb43e7d09ca	http://localhost:33556
36	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.755+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	bdf9f03d-962f-43c2-b89f-65e8e6cfbf41	http://localhost:33556
37	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.758+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	12b31bea-edd6-4174-8cd7-3bb38a0efbfe	http://localhost:33556
38	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.76+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	788af01e-36c3-4805-872c-c007c7758624	http://localhost:33556
39	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.762+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	c039aa00-88c2-4769-ad38-33df96fc64f3	http://localhost:33556
40	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.765+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	781d1eeb-b809-4186-bc0b-7b90127f9e68	http://localhost:33556
41	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.767+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	bcfbcf15-b835-4008-83d7-2ff935a6e918	http://localhost:33556
42	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.77+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	f4b0d799-e1ff-4506-a783-b6cab4ef0f06	http://localhost:33556
43	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.772+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	207178a9-c5ae-4808-bafa-8f608913b4dc	http://localhost:33556
44	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.775+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	0a5ad80f-6d33-435b-bb15-18fd65a39f68	http://localhost:33556
45	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.777+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	0a5ad80f-6d33-435b-bb15-18fd65a39f68	http://localhost:33556
46	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 17:49:42.781+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	9d062e03-eaff-4e35-b2e6-a483c5aa5ae1	http://localhost:33556
47	login	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 19:47:32.041+00	192.168.240.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	9d83a681-8388-4ff9-ae4b-7038fad0560a	http://localhost:33556
48	login	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 20:08:20.692+00	192.168.240.1	axios/1.7.2	directus_users	9d83a681-8388-4ff9-ae4b-7038fad0560a	\N
49	login	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 21:02:24.598+00	192.168.240.1	axios/1.7.2	directus_users	9d83a681-8388-4ff9-ae4b-7038fad0560a	\N
50	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 21:07:33.294+00	192.168.240.1	axios/1.7.2	directus_users	06e0a60d-1924-41e2-aef5-1c0526264f4c	\N
51	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 21:14:56.879+00	192.168.240.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_permissions	1	http://localhost:33556
52	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 21:14:56.884+00	192.168.240.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_permissions	2	http://localhost:33556
53	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-05 21:14:56.887+00	192.168.240.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:33556
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url, versioning) FROM stdin;
series	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
photos	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
\.


--
-- Data for Name: directus_comments; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_comments (id, collection, item, comment, date_created, date_updated, user_created, user_updated) FROM stdin;
\.


--
-- Data for Name: directus_dashboards; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_dashboards (id, name, icon, note, date_created, user_created, color) FROM stdin;
\.


--
-- Data for Name: directus_extensions; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_extensions (enabled, id, folder, source, bundle) FROM stdin;
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, translations, note, conditions, required, "group", validation, validation_message) FROM stdin;
1	series	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
2	series	name	\N	input	\N	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
3	series	description	\N	input	\N	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
4	photos	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
5	photos	serie_id	m2o	\N	\N	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
6	photos	name	\N	input	\N	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
7	photos	lat	\N	input	\N	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
8	photos	long	\N	input	\N	\N	\N	f	f	5	full	\N	\N	\N	f	\N	\N	\N
9	photos	url	\N	input	\N	\N	\N	f	f	6	full	\N	\N	\N	f	\N	\N	\N
10	photos	link	\N	input	\N	\N	\N	f	f	7	full	\N	\N	\N	f	\N	\N	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, created_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata, focal_point_x, focal_point_y, tus_id, tus_data, uploaded_on) FROM stdin;
\.


--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_flows (id, name, icon, color, description, status, trigger, accountability, options, operation, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_folders (id, name, parent) FROM stdin;
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2025-02-05 17:46:54.546996+00
20201029A	Remove System Relations	2025-02-05 17:46:54.550697+00
20201029B	Remove System Collections	2025-02-05 17:46:54.556891+00
20201029C	Remove System Fields	2025-02-05 17:46:54.56273+00
20201105A	Add Cascade System Relations	2025-02-05 17:46:54.583714+00
20201105B	Change Webhook URL Type	2025-02-05 17:46:54.58828+00
20210225A	Add Relations Sort Field	2025-02-05 17:46:54.591805+00
20210304A	Remove Locked Fields	2025-02-05 17:46:54.593743+00
20210312A	Webhooks Collections Text	2025-02-05 17:46:54.59737+00
20210331A	Add Refresh Interval	2025-02-05 17:46:54.599045+00
20210415A	Make Filesize Nullable	2025-02-05 17:46:54.602976+00
20210416A	Add Collections Accountability	2025-02-05 17:46:54.60548+00
20210422A	Remove Files Interface	2025-02-05 17:46:54.606881+00
20210506A	Rename Interfaces	2025-02-05 17:46:54.620941+00
20210510A	Restructure Relations	2025-02-05 17:46:54.630801+00
20210518A	Add Foreign Key Constraints	2025-02-05 17:46:54.635664+00
20210519A	Add System Fk Triggers	2025-02-05 17:46:54.651707+00
20210521A	Add Collections Icon Color	2025-02-05 17:46:54.654047+00
20210525A	Add Insights	2025-02-05 17:46:54.661192+00
20210608A	Add Deep Clone Config	2025-02-05 17:46:54.663199+00
20210626A	Change Filesize Bigint	2025-02-05 17:46:54.668996+00
20210716A	Add Conditions to Fields	2025-02-05 17:46:54.671044+00
20210721A	Add Default Folder	2025-02-05 17:46:54.674727+00
20210802A	Replace Groups	2025-02-05 17:46:54.677841+00
20210803A	Add Required to Fields	2025-02-05 17:46:54.679719+00
20210805A	Update Groups	2025-02-05 17:46:54.682412+00
20210805B	Change Image Metadata Structure	2025-02-05 17:46:54.685177+00
20210811A	Add Geometry Config	2025-02-05 17:46:54.68719+00
20210831A	Remove Limit Column	2025-02-05 17:46:54.688976+00
20210903A	Add Auth Provider	2025-02-05 17:46:54.69688+00
20210907A	Webhooks Collections Not Null	2025-02-05 17:46:54.701534+00
20210910A	Move Module Setup	2025-02-05 17:46:54.703904+00
20210920A	Webhooks URL Not Null	2025-02-05 17:46:54.708151+00
20210924A	Add Collection Organization	2025-02-05 17:46:54.710904+00
20210927A	Replace Fields Group	2025-02-05 17:46:54.715491+00
20210927B	Replace M2M Interface	2025-02-05 17:46:54.71736+00
20210929A	Rename Login Action	2025-02-05 17:46:54.718926+00
20211007A	Update Presets	2025-02-05 17:46:54.722971+00
20211009A	Add Auth Data	2025-02-05 17:46:54.724838+00
20211016A	Add Webhook Headers	2025-02-05 17:46:54.726497+00
20211103A	Set Unique to User Token	2025-02-05 17:46:54.728472+00
20211103B	Update Special Geometry	2025-02-05 17:46:54.730125+00
20211104A	Remove Collections Listing	2025-02-05 17:46:54.732246+00
20211118A	Add Notifications	2025-02-05 17:46:54.738348+00
20211211A	Add Shares	2025-02-05 17:46:54.74602+00
20211230A	Add Project Descriptor	2025-02-05 17:46:54.748333+00
20220303A	Remove Default Project Color	2025-02-05 17:46:54.753229+00
20220308A	Add Bookmark Icon and Color	2025-02-05 17:46:54.755315+00
20220314A	Add Translation Strings	2025-02-05 17:46:54.757311+00
20220322A	Rename Field Typecast Flags	2025-02-05 17:46:54.760249+00
20220323A	Add Field Validation	2025-02-05 17:46:54.762255+00
20220325A	Fix Typecast Flags	2025-02-05 17:46:54.765551+00
20220325B	Add Default Language	2025-02-05 17:46:54.770898+00
20220402A	Remove Default Value Panel Icon	2025-02-05 17:46:54.775268+00
20220429A	Add Flows	2025-02-05 17:46:54.788099+00
20220429B	Add Color to Insights Icon	2025-02-05 17:46:54.790137+00
20220429C	Drop Non Null From IP of Activity	2025-02-05 17:46:54.791771+00
20220429D	Drop Non Null From Sender of Notifications	2025-02-05 17:46:54.793301+00
20220614A	Rename Hook Trigger to Event	2025-02-05 17:46:54.794655+00
20220801A	Update Notifications Timestamp Column	2025-02-05 17:46:54.799222+00
20220802A	Add Custom Aspect Ratios	2025-02-05 17:46:54.801503+00
20220826A	Add Origin to Accountability	2025-02-05 17:46:54.804438+00
20230401A	Update Material Icons	2025-02-05 17:46:54.810022+00
20230525A	Add Preview Settings	2025-02-05 17:46:54.811915+00
20230526A	Migrate Translation Strings	2025-02-05 17:46:54.817309+00
20230721A	Require Shares Fields	2025-02-05 17:46:54.820929+00
20230823A	Add Content Versioning	2025-02-05 17:46:54.828579+00
20230927A	Themes	2025-02-05 17:46:54.838373+00
20231009A	Update CSV Fields to Text	2025-02-05 17:46:54.842075+00
20231009B	Update Panel Options	2025-02-05 17:46:54.843768+00
20231010A	Add Extensions	2025-02-05 17:46:54.845915+00
20231215A	Add Focalpoints	2025-02-05 17:46:54.848253+00
20240122A	Add Report URL Fields	2025-02-05 17:46:54.850316+00
20240204A	Marketplace	2025-02-05 17:46:54.860796+00
20240305A	Change Useragent Type	2025-02-05 17:46:54.867242+00
20240311A	Deprecate Webhooks	2025-02-05 17:46:54.874154+00
20240422A	Public Registration	2025-02-05 17:46:54.877357+00
20240515A	Add Session Window	2025-02-05 17:46:54.879373+00
20240701A	Add Tus Data	2025-02-05 17:46:54.881829+00
20240716A	Update Files Date Fields	2025-02-05 17:46:54.886433+00
20240806A	Permissions Policies	2025-02-05 17:46:54.908213+00
20240817A	Update Icon Fields Length	2025-02-05 17:46:54.921661+00
20240909A	Separate Comments	2025-02-05 17:46:54.926472+00
20240909B	Consolidate Content Versioning	2025-02-05 17:46:54.928241+00
20240924A	Migrate Legacy Comments	2025-02-05 17:46:54.931922+00
20240924B	Populate Versioning Deltas	2025-02-05 17:46:54.935279+00
\.


--
-- Data for Name: directus_notifications; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_notifications (id, "timestamp", status, recipient, sender, subject, message, collection, item) FROM stdin;
\.


--
-- Data for Name: directus_operations; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_operations (id, name, key, type, position_x, position_y, options, resolve, reject, flow, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_panels; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_panels (id, dashboard, name, icon, color, show_header, note, type, position_x, position_y, width, height, options, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_permissions (id, collection, action, permissions, validation, presets, fields, policy) FROM stdin;
1	photos	read	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
2	series	read	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
\.


--
-- Data for Name: directus_policies; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_policies (id, name, icon, description, ip_access, enforce_tfa, admin_access, app_access) FROM stdin;
abf8a154-5b1c-4a46-ac9c-7300570f4f17	$t:public_label	public	$t:public_description	\N	f	f	f
e36db6ca-f905-43df-bf77-de2846a7eb8a	Administrator	verified	$t:admin_description	\N	f	t	t
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, layout, layout_query, layout_options, refresh_interval, filter, icon, color) FROM stdin;
1	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	\N	series	\N	\N	{"tabular":{"fields":["description","name","id"]}}	\N	\N	\N	bookmark	\N
2	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	\N	directus_users	\N	cards	{"cards":{"sort":["email"],"page":1}}	{"cards":{"icon":"account_circle","title":"{{ first_name }} {{ last_name }}","subtitle":"{{ email }}","size":4}}	\N	\N	bookmark	\N
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
1	photos	serie_id	series	\N	\N	\N	\N	\N	nullify
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent, version) FROM stdin;
1	2	directus_fields	1	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"series"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"series"}	\N	\N
2	3	directus_collections	series	{"singleton":false,"collection":"series"}	{"singleton":false,"collection":"series"}	\N	\N
3	4	directus_fields	2	{"sort":2,"interface":"input","special":null,"collection":"series","field":"name"}	{"sort":2,"interface":"input","special":null,"collection":"series","field":"name"}	\N	\N
4	5	directus_fields	3	{"sort":3,"interface":"input","special":null,"collection":"series","field":"description"}	{"sort":3,"interface":"input","special":null,"collection":"series","field":"description"}	\N	\N
5	6	series	85678cf6-5977-45aa-b727-8d5c677f7e41	{"name":"Nancy","description":"Les lieux les plus mythiques de Nancy"}	{"name":"Nancy","description":"Les lieux les plus mythiques de Nancy"}	\N	\N
6	7	directus_fields	4	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"photos"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"photos"}	\N	\N
7	8	directus_collections	photos	{"singleton":false,"collection":"photos"}	{"singleton":false,"collection":"photos"}	\N	\N
8	9	directus_fields	5	{"sort":2,"special":["m2o"],"collection":"photos","field":"serie_id"}	{"sort":2,"special":["m2o"],"collection":"photos","field":"serie_id"}	\N	\N
9	10	directus_fields	6	{"sort":3,"interface":"input","special":null,"collection":"photos","field":"name"}	{"sort":3,"interface":"input","special":null,"collection":"photos","field":"name"}	\N	\N
10	11	directus_fields	7	{"sort":4,"interface":"input","special":null,"collection":"photos","field":"lat"}	{"sort":4,"interface":"input","special":null,"collection":"photos","field":"lat"}	\N	\N
11	12	directus_fields	8	{"sort":5,"interface":"input","special":null,"collection":"photos","field":"long"}	{"sort":5,"interface":"input","special":null,"collection":"photos","field":"long"}	\N	\N
12	13	directus_fields	9	{"sort":6,"interface":"input","special":null,"collection":"photos","field":"url"}	{"sort":6,"interface":"input","special":null,"collection":"photos","field":"url"}	\N	\N
13	14	directus_fields	10	{"sort":7,"interface":"input","special":null,"collection":"photos","field":"link"}	{"sort":7,"interface":"input","special":null,"collection":"photos","field":"link"}	\N	\N
14	15	photos	55d1ecb2-82d9-445c-996b-68f7d1862432	{"id":"55d1ecb2-82d9-445c-996b-68f7d1862432","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Institut Universitaire de Technologie Nancy-Charlemagne","lat":"48.6828323658981","long":"6.16091547406893","url":"images/01.jpg","link":"https://i.ytimg.com/vi/f3n6d4Ufk1U/maxresdefault_live.jpg"}	{"id":"55d1ecb2-82d9-445c-996b-68f7d1862432","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Institut Universitaire de Technologie Nancy-Charlemagne","lat":"48.6828323658981","long":"6.16091547406893","url":"images/01.jpg","link":"https://i.ytimg.com/vi/f3n6d4Ufk1U/maxresdefault_live.jpg"}	\N	\N
15	16	photos	4d6c147e-2cdd-47a8-962a-5a8754f0a0fb	{"id":"4d6c147e-2cdd-47a8-962a-5a8754f0a0fb","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Musée des Beaux-Arts de Nancy","lat":"48.6934244497898","long":"6.18235708015418","url":"images/02.jpg","link":"https://th.bing.com/th/id/R.ffa2da458031ec0d61c7aa59d49bb506?rik=73eXDK5WOPvL4A&pid=ImgRaw&r=0"}	{"id":"4d6c147e-2cdd-47a8-962a-5a8754f0a0fb","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Musée des Beaux-Arts de Nancy","lat":"48.6934244497898","long":"6.18235708015418","url":"images/02.jpg","link":"https://th.bing.com/th/id/R.ffa2da458031ec0d61c7aa59d49bb506?rik=73eXDK5WOPvL4A&pid=ImgRaw&r=0"}	\N	\N
16	17	photos	93b2408f-eb3a-492f-98f1-fd71c7f702e1	{"id":"93b2408f-eb3a-492f-98f1-fd71c7f702e1","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Place Stanislas","lat":"48.6935915205383","long":"6.18325640787205","url":"images/03.jpg","link":"https://i0.wp.com/viajealpatrimonio.com/wp-content/uploads/2020/05/0787-plaza-stanislas-plaza-de-la-carriere-y-plaza-de-la-alliance-en-nancy.jpg?ssl=1"}	{"id":"93b2408f-eb3a-492f-98f1-fd71c7f702e1","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Place Stanislas","lat":"48.6935915205383","long":"6.18325640787205","url":"images/03.jpg","link":"https://i0.wp.com/viajealpatrimonio.com/wp-content/uploads/2020/05/0787-plaza-stanislas-plaza-de-la-carriere-y-plaza-de-la-alliance-en-nancy.jpg?ssl=1"}	\N	\N
17	18	photos	82fc87f1-453a-4e54-9e37-b216aeb1af9c	{"id":"82fc87f1-453a-4e54-9e37-b216aeb1af9c","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Muséum-Aquarium de Nancy","lat":"48.6949427895482","long":"6.18820822723179","url":"images/04.jpg","link":"https://www.archi-wiki.org/images/thumb/9/91/34_rue_Sainte_Catherine_(entr%C3%A9e)_DSC04646.jpg/1200px-34_rue_Sainte_Catherine_(entr%C3%A9e)_DSC04646.jpg"}	{"id":"82fc87f1-453a-4e54-9e37-b216aeb1af9c","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Muséum-Aquarium de Nancy","lat":"48.6949427895482","long":"6.18820822723179","url":"images/04.jpg","link":"https://www.archi-wiki.org/images/thumb/9/91/34_rue_Sainte_Catherine_(entr%C3%A9e)_DSC04646.jpg/1200px-34_rue_Sainte_Catherine_(entr%C3%A9e)_DSC04646.jpg"}	\N	\N
18	19	photos	6a6a491c-a6a7-4e76-b2f3-3e0f337a3fd3	{"id":"6a6a491c-a6a7-4e76-b2f3-3e0f337a3fd3","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Porte Désilles","lat":"48.6979582620096","long":"6.174147932838","url":"images/05.jpg","link":"https://media-cdn.tripadvisor.com/media/photo-s/14/af/43/c3/porte-desilles.jpg"}	{"id":"6a6a491c-a6a7-4e76-b2f3-3e0f337a3fd3","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Porte Désilles","lat":"48.6979582620096","long":"6.174147932838","url":"images/05.jpg","link":"https://media-cdn.tripadvisor.com/media/photo-s/14/af/43/c3/porte-desilles.jpg"}	\N	\N
19	20	photos	f13c4c48-503b-4131-9856-77137afab803	{"id":"f13c4c48-503b-4131-9856-77137afab803","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Cathédrale Notre-Dame-de-l'Annonciation","lat":"48.6915229374518","long":"6.1858817407413","url":"images/06.jpg","link":"https://live.staticflickr.com/3164/3098725110_0f37479776_b.jpg"}	{"id":"f13c4c48-503b-4131-9856-77137afab803","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Cathédrale Notre-Dame-de-l'Annonciation","lat":"48.6915229374518","long":"6.1858817407413","url":"images/06.jpg","link":"https://live.staticflickr.com/3164/3098725110_0f37479776_b.jpg"}	\N	\N
20	21	photos	969b7872-14f8-4f2a-8b13-4905d0dc088e	{"id":"969b7872-14f8-4f2a-8b13-4905d0dc088e","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Place de la Carrière","lat":"48.6954725331034","long":"6.18193781254074","url":"images/07.jpg","link":"https://api.cloudly.space/resize/crop/1200/627/60/aHR0cHM6Ly93d3cuc2l0bG9yLmZyL3Bob3Rvcy83MzcvcGxhY2VfZGVfbGFfY2FycmllcmUuanBnPzIwMjEtMDYtMjJUMTU6NDI6MjJa/image.jpg"}	{"id":"969b7872-14f8-4f2a-8b13-4905d0dc088e","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Place de la Carrière","lat":"48.6954725331034","long":"6.18193781254074","url":"images/07.jpg","link":"https://api.cloudly.space/resize/crop/1200/627/60/aHR0cHM6Ly93d3cuc2l0bG9yLmZyL3Bob3Rvcy83MzcvcGxhY2VfZGVfbGFfY2FycmllcmUuanBnPzIwMjEtMDYtMjJUMTU6NDI6MjJa/image.jpg"}	\N	\N
21	22	photos	ecc7ba07-95d1-4671-acd1-d975a676bed9	{"id":"ecc7ba07-95d1-4671-acd1-d975a676bed9","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Basilique Saint-Epvre","lat":"48.695994903589","long":"6.17991735334421","url":"images/08.jpg","link":"https://th.bing.com/th/id/R.f3da826715a8428a23f9421319e04d3c?rik=yEjlpTxxd%2beorA&riu=http%3a%2f%2flusile17.l.u.pic.centerblog.net%2fo%2fc8b40538.jpg&ehk=FKlylTb%2ffOKWDvalqpX5FQN4vXQqlBR79zBcaLfSBqQ%3d&risl=&pid=ImgRaw&r=0"}	{"id":"ecc7ba07-95d1-4671-acd1-d975a676bed9","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Basilique Saint-Epvre","lat":"48.695994903589","long":"6.17991735334421","url":"images/08.jpg","link":"https://th.bing.com/th/id/R.f3da826715a8428a23f9421319e04d3c?rik=yEjlpTxxd%2beorA&riu=http%3a%2f%2flusile17.l.u.pic.centerblog.net%2fo%2fc8b40538.jpg&ehk=FKlylTb%2ffOKWDvalqpX5FQN4vXQqlBR79zBcaLfSBqQ%3d&risl=&pid=ImgRaw&r=0"}	\N	\N
22	23	photos	cb8b71b4-7989-4b6c-a68d-182ec0475648	{"id":"cb8b71b4-7989-4b6c-a68d-182ec0475648","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Villa Majorelle","lat":"48.6855117761987","long":"6.16386613003089","url":"images/09.jpg","link":"https://th.bing.com/th/id/OIP.8RzG0_gbx6N2P59VpOXSagHaEk?rs=1&pid=ImgDetMain"}	{"id":"cb8b71b4-7989-4b6c-a68d-182ec0475648","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Villa Majorelle","lat":"48.6855117761987","long":"6.16386613003089","url":"images/09.jpg","link":"https://th.bing.com/th/id/OIP.8RzG0_gbx6N2P59VpOXSagHaEk?rs=1&pid=ImgDetMain"}	\N	\N
23	24	photos	d1ad5874-64df-40c8-8639-6728e614298d	{"id":"d1ad5874-64df-40c8-8639-6728e614298d","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Parc de la Pépinière","lat":"48.6977712521057","long":"6.18460627665755","url":"images/10.jpg","link":"https://frenchmoments.eu/wp-content/uploads/2012/11/Parc-de-la-P%C3%A9pini%C3%A8re-04-Nancy-%C2%A9-French-Moments.jpg"}	{"id":"d1ad5874-64df-40c8-8639-6728e614298d","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Parc de la Pépinière","lat":"48.6977712521057","long":"6.18460627665755","url":"images/10.jpg","link":"https://frenchmoments.eu/wp-content/uploads/2012/11/Parc-de-la-P%C3%A9pini%C3%A8re-04-Nancy-%C2%A9-French-Moments.jpg"}	\N	\N
24	25	photos	3f616107-69e6-4586-afc3-8a73c6b86891	{"id":"3f616107-69e6-4586-afc3-8a73c6b86891","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Parc de la Cure d'Air","lat":"48.6933896583972","long":"6.15995144259252","url":"images/11.jpg","link":"https://api.cloudly.space/resize/crop/1200/627/60/aHR0cHM6Ly93d3cuc2l0bG9yLmZyL3Bob3Rvcy83MzcvNzM3MDAwMjcxXzQuanBnPzIwMjEtMTItMjFUMTE6Mzk6NDha/image.jpg"}	{"id":"3f616107-69e6-4586-afc3-8a73c6b86891","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Parc de la Cure d'Air","lat":"48.6933896583972","long":"6.15995144259252","url":"images/11.jpg","link":"https://api.cloudly.space/resize/crop/1200/627/60/aHR0cHM6Ly93d3cuc2l0bG9yLmZyL3Bob3Rvcy83MzcvNzM3MDAwMjcxXzQuanBnPzIwMjEtMTItMjFUMTE6Mzk6NDha/image.jpg"}	\N	\N
25	26	photos	211f70c8-8e04-4b97-8f84-328e8b043344	{"id":"211f70c8-8e04-4b97-8f84-328e8b043344","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Centre Commercial Saint Sébastien","lat":"48.6880087792139","long":"6.18067681830613","url":"images/12.jpg","link":"https://media-cdn.tripadvisor.com/media/photo-s/14/af/ea/6d/centre-commercial-saint.jpg"}	{"id":"211f70c8-8e04-4b97-8f84-328e8b043344","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Centre Commercial Saint Sébastien","lat":"48.6880087792139","long":"6.18067681830613","url":"images/12.jpg","link":"https://media-cdn.tripadvisor.com/media/photo-s/14/af/ea/6d/centre-commercial-saint.jpg"}	\N	\N
26	27	photos	94d5df24-03eb-4e4d-87ca-a4fce91d8c34	{"id":"94d5df24-03eb-4e4d-87ca-a4fce91d8c34","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Gare de Nancy","lat":"48.6897919909649","long":"6.17440457810537","url":"images/13.jpg","link":"https://s3-media4.fl.yelpcdn.com/bphoto/fXtPxdpgpHr9RHB-Je-L6Q/o.jpg"}	{"id":"94d5df24-03eb-4e4d-87ca-a4fce91d8c34","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Gare de Nancy","lat":"48.6897919909649","long":"6.17440457810537","url":"images/13.jpg","link":"https://s3-media4.fl.yelpcdn.com/bphoto/fXtPxdpgpHr9RHB-Je-L6Q/o.jpg"}	\N	\N
27	28	photos	a74fb23e-1ba0-4ac0-8391-dad8b06b81d9	{"id":"a74fb23e-1ba0-4ac0-8391-dad8b06b81d9","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Basilique du Sacré-Cœur de Nancy","lat":"48.6855496603864","long":"6.16246257435614","url":"images/14.jpg","link":"https://th.bing.com/th/id/R.5ff55d576be674cdbb45aecd98a3faed?rik=JlZd9fGH6KJUJA&riu=http%3a%2f%2fphotos.wikimapia.org%2fp%2f00%2f01%2f68%2f26%2f37_big.jpg&ehk=U7mJ1UYZw%2bsFL31cbbDb5PnjnqP8Ca%2b3kjaR8Tpx5Hg%3d&risl=&pid=ImgRaw&r=0"}	{"id":"a74fb23e-1ba0-4ac0-8391-dad8b06b81d9","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Basilique du Sacré-Cœur de Nancy","lat":"48.6855496603864","long":"6.16246257435614","url":"images/14.jpg","link":"https://th.bing.com/th/id/R.5ff55d576be674cdbb45aecd98a3faed?rik=JlZd9fGH6KJUJA&riu=http%3a%2f%2fphotos.wikimapia.org%2fp%2f00%2f01%2f68%2f26%2f37_big.jpg&ehk=U7mJ1UYZw%2bsFL31cbbDb5PnjnqP8Ca%2b3kjaR8Tpx5Hg%3d&risl=&pid=ImgRaw&r=0"}	\N	\N
28	29	photos	2bf6df61-3bc2-4d0b-b5d9-5ebc094c04c3	{"id":"2bf6df61-3bc2-4d0b-b5d9-5ebc094c04c3","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Église Saint-Léon de Nancy","lat":"48.6892766684842","long":"6.17207148496397","url":"images/15.jpg","link":"https://th.bing.com/th/id/OIP.-EvWoogHdOjjQTwMAaH8zwAAAA?w=384&h=547&rs=1&pid=ImgDetMain"}	{"id":"2bf6df61-3bc2-4d0b-b5d9-5ebc094c04c3","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Église Saint-Léon de Nancy","lat":"48.6892766684842","long":"6.17207148496397","url":"images/15.jpg","link":"https://th.bing.com/th/id/OIP.-EvWoogHdOjjQTwMAaH8zwAAAA?w=384&h=547&rs=1&pid=ImgDetMain"}	\N	\N
29	30	photos	5c6dc88e-be57-4e8e-8789-fda2d396cec5	{"id":"5c6dc88e-be57-4e8e-8789-fda2d396cec5","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Nancy Thermal","lat":"48.6791632317088","long":"6.16872369208436","url":"images/16.jpg","link":"https://th.bing.com/th/id/R.98072a4bf1a9d532bdb8f0081a6f6118?rik=uARF5UMHDtuiig&riu=http%3a%2f%2fdha.eu%2fwp-content%2fuploads%2f2018%2f10%2f05.106.38.jpg&ehk=F93hYCSX%2f%2fbwFxNS78lk5VvilbZluJcchdrp9C2szMU%3d&risl=&pid=ImgRaw&r=0"}	{"id":"5c6dc88e-be57-4e8e-8789-fda2d396cec5","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Nancy Thermal","lat":"48.6791632317088","long":"6.16872369208436","url":"images/16.jpg","link":"https://th.bing.com/th/id/R.98072a4bf1a9d532bdb8f0081a6f6118?rik=uARF5UMHDtuiig&riu=http%3a%2f%2fdha.eu%2fwp-content%2fuploads%2f2018%2f10%2f05.106.38.jpg&ehk=F93hYCSX%2f%2fbwFxNS78lk5VvilbZluJcchdrp9C2szMU%3d&risl=&pid=ImgRaw&r=0"}	\N	\N
30	31	photos	00ed930e-e697-4b2a-96a4-92f84ed79aec	{"id":"00ed930e-e697-4b2a-96a4-92f84ed79aec","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Jardin Botanique Jean-Marie Pelt","lat":"48.662758","long":"6.155456","url":"images/17.jpg","link":"https://fr.wikipedia.org/wiki/Jardin_botanique_Jean-Marie-Pelt#/media/Fichier:Jardin_botanique_Montet_1.jpg"}	{"id":"00ed930e-e697-4b2a-96a4-92f84ed79aec","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Jardin Botanique Jean-Marie Pelt","lat":"48.662758","long":"6.155456","url":"images/17.jpg","link":"https://fr.wikipedia.org/wiki/Jardin_botanique_Jean-Marie-Pelt#/media/Fichier:Jardin_botanique_Montet_1.jpg"}	\N	\N
31	32	photos	a3e4f064-84f4-402f-a9e6-9b00ce361c50	{"id":"a3e4f064-84f4-402f-a9e6-9b00ce361c50","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Plage de la Méchelle","lat":"48.6922610233877","long":"6.20239706106462","url":"images/18.jpg","link":"https://cdn-s-www.estrepublicain.fr/images/B641AA78-4B8E-4544-9AF6-196687C4E853/NW_raw/le-nouveau-site-de-la-mechelle-a-connu-une-frequentation-contrastee-entre-jours-pluvieux-et-temps-plus-estival-photo-er-cedric-jacquot-1629912614.jpg"}	{"id":"a3e4f064-84f4-402f-a9e6-9b00ce361c50","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Plage de la Méchelle","lat":"48.6922610233877","long":"6.20239706106462","url":"images/18.jpg","link":"https://cdn-s-www.estrepublicain.fr/images/B641AA78-4B8E-4544-9AF6-196687C4E853/NW_raw/le-nouveau-site-de-la-mechelle-a-connu-une-frequentation-contrastee-entre-jours-pluvieux-et-temps-plus-estival-photo-er-cedric-jacquot-1629912614.jpg"}	\N	\N
32	33	photos	c05787a9-0e6f-4502-a932-ee5881addc7b	{"id":"c05787a9-0e6f-4502-a932-ee5881addc7b","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Musée Lorrain","lat":"48.6973116730877","long":"6.17934775730296","url":"images/19.jpg","link":"https://media-cdn.tripadvisor.com/media/photo-s/1a/aa/52/81/portale.jpg"}	{"id":"c05787a9-0e6f-4502-a932-ee5881addc7b","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Musée Lorrain","lat":"48.6973116730877","long":"6.17934775730296","url":"images/19.jpg","link":"https://media-cdn.tripadvisor.com/media/photo-s/1a/aa/52/81/portale.jpg"}	\N	\N
33	34	photos	41874312-d6a0-48e3-b16c-1be8e7cf9d44	{"id":"41874312-d6a0-48e3-b16c-1be8e7cf9d44","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Porte de la Craffe","lat":"48.6988659264728","long":"6.17779765611324","url":"images/20.jpg","link":"https://i.pinimg.com/originals/ca/dd/5a/cadd5a34c4f64319dbb15b576d1e7369.jpg"}	{"id":"41874312-d6a0-48e3-b16c-1be8e7cf9d44","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Porte de la Craffe","lat":"48.6988659264728","long":"6.17779765611324","url":"images/20.jpg","link":"https://i.pinimg.com/originals/ca/dd/5a/cadd5a34c4f64319dbb15b576d1e7369.jpg"}	\N	\N
34	35	photos	588f48b7-3d1e-4ceb-bdfe-bfb43e7d09ca	{"id":"588f48b7-3d1e-4ceb-bdfe-bfb43e7d09ca","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Tour de la Commanderie Nazet-Moutaux","lat":"48.6865659854259","long":"6.16735481677689","url":"images/21.jpg","link":"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/24/1c/a5/8f/up-some-steps.jpg?w=1200&h=-1&s=1"}	{"id":"588f48b7-3d1e-4ceb-bdfe-bfb43e7d09ca","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Tour de la Commanderie Nazet-Moutaux","lat":"48.6865659854259","long":"6.16735481677689","url":"images/21.jpg","link":"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/24/1c/a5/8f/up-some-steps.jpg?w=1200&h=-1&s=1"}	\N	\N
35	36	photos	bdf9f03d-962f-43c2-b89f-65e8e6cfbf41	{"id":"bdf9f03d-962f-43c2-b89f-65e8e6cfbf41","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Campus Lettres et Sciences Humaines de Nancy - Université de Lorraine","lat":"48.6955810198057","long":"6.16599935776565","url":"images/22.jpg","link":"https://cdn-s-www.estrepublicain.fr/images/5ED2BEB3-6BEB-4C0B-8797-28AF345C4C4B/NW_raw/title-1607632070.jpg"}	{"id":"bdf9f03d-962f-43c2-b89f-65e8e6cfbf41","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Campus Lettres et Sciences Humaines de Nancy - Université de Lorraine","lat":"48.6955810198057","long":"6.16599935776565","url":"images/22.jpg","link":"https://cdn-s-www.estrepublicain.fr/images/5ED2BEB3-6BEB-4C0B-8797-28AF345C4C4B/NW_raw/title-1607632070.jpg"}	\N	\N
36	37	photos	12b31bea-edd6-4174-8cd7-3bb38a0efbfe	{"id":"12b31bea-edd6-4174-8cd7-3bb38a0efbfe","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Faculté de Droit, Sciences Économiques et Gestion","lat":"48.6931229890256","long":"6.1766413458741","url":"images/23.jpg","link":"https://live.staticflickr.com/65535/48864028882_580f6e3ff6_b.jpg"}	{"id":"12b31bea-edd6-4174-8cd7-3bb38a0efbfe","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Faculté de Droit, Sciences Économiques et Gestion","lat":"48.6931229890256","long":"6.1766413458741","url":"images/23.jpg","link":"https://live.staticflickr.com/65535/48864028882_580f6e3ff6_b.jpg"}	\N	\N
37	38	photos	788af01e-36c3-4805-872c-c007c7758624	{"id":"788af01e-36c3-4805-872c-c007c7758624","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Stade Marcel Picot","lat":"48.6954249246343","long":"6.21053652030365","url":"images/24.jpg","link":"https://th.bing.com/th/id/R.5228ad9f481c3985cc289b82e7ee9669?rik=AGJxuyX3ya272A&riu=http%3a%2f%2fwww.ostadium.com%2fgalleries%2fstade-marcel-picot-vue-aerienne-illus.jpg&ehk=s5JHg2RJq625D3pzyEzQoJquUrRUZ4HKasOuMOXKW%2f0%3d&risl=&pid=ImgRaw&r=0&sres=1&sres"}	{"id":"788af01e-36c3-4805-872c-c007c7758624","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Stade Marcel Picot","lat":"48.6954249246343","long":"6.21053652030365","url":"images/24.jpg","link":"https://th.bing.com/th/id/R.5228ad9f481c3985cc289b82e7ee9669?rik=AGJxuyX3ya272A&riu=http%3a%2f%2fwww.ostadium.com%2fgalleries%2fstade-marcel-picot-vue-aerienne-illus.jpg&ehk=s5JHg2RJq625D3pzyEzQoJquUrRUZ4HKasOuMOXKW%2f0%3d&risl=&pid=ImgRaw&r=0&sres=1&sres"}	\N	\N
38	39	photos	c039aa00-88c2-4769-ad38-33df96fc64f3	{"id":"c039aa00-88c2-4769-ad38-33df96fc64f3","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Château de Montaigu","lat":"48.6633822330804","long":"6.2158060491444","url":"images/25.jpg","link":"https://static.wixstatic.com/media/4d8fa8_49bbe10b1b374654a9304828fa4b9e21~mv2.jpg/v1/fill/w_2500,h_1830,al_c/4d8fa8_49bbe10b1b374654a9304828fa4b9e21~mv2.jpg"}	{"id":"c039aa00-88c2-4769-ad38-33df96fc64f3","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Château de Montaigu","lat":"48.6633822330804","long":"6.2158060491444","url":"images/25.jpg","link":"https://static.wixstatic.com/media/4d8fa8_49bbe10b1b374654a9304828fa4b9e21~mv2.jpg/v1/fill/w_2500,h_1830,al_c/4d8fa8_49bbe10b1b374654a9304828fa4b9e21~mv2.jpg"}	\N	\N
39	40	photos	781d1eeb-b809-4186-bc0b-7b90127f9e68	{"id":"781d1eeb-b809-4186-bc0b-7b90127f9e68","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"IUT Nancy-Brabois","lat":"48.6588705423001","long":"6.15140298760477","url":"images/26.jpg","link":"https://iut-nancy-brabois.univ-lorraine.fr/files/2023/09/iutnb-campus-luneville-1536x1024.jpg"}	{"id":"781d1eeb-b809-4186-bc0b-7b90127f9e68","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"IUT Nancy-Brabois","lat":"48.6588705423001","long":"6.15140298760477","url":"images/26.jpg","link":"https://iut-nancy-brabois.univ-lorraine.fr/files/2023/09/iutnb-campus-luneville-1536x1024.jpg"}	\N	\N
40	41	photos	bcfbcf15-b835-4008-83d7-2ff935a6e918	{"id":"bcfbcf15-b835-4008-83d7-2ff935a6e918","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Musée de l'École de Nancy","lat":"48.6805236575265","long":"6.16617418668594","url":"images/27.jpg","link":"https://fr.wikipedia.org/wiki/Mus%C3%A9e_de_l%27%C3%89cole_de_Nancy#/media/Fichier:Mus%C3%A9e_%C3%A9cole_Nancy.jpg"}	{"id":"bcfbcf15-b835-4008-83d7-2ff935a6e918","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Musée de l'École de Nancy","lat":"48.6805236575265","long":"6.16617418668594","url":"images/27.jpg","link":"https://fr.wikipedia.org/wiki/Mus%C3%A9e_de_l%27%C3%89cole_de_Nancy#/media/Fichier:Mus%C3%A9e_%C3%A9cole_Nancy.jpg"}	\N	\N
41	42	photos	f4b0d799-e1ff-4506-a783-b6cab4ef0f06	{"id":"f4b0d799-e1ff-4506-a783-b6cab4ef0f06","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Crous Resto U' Cours Léopold","lat":"48.6951174888681","long":"6.17719255321255","url":"images/28.jpg","link":"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/22/01/bb/3f/voici-la-facade-du-crous.jpg?w=1200&h=-1&s=1"}	{"id":"f4b0d799-e1ff-4506-a783-b6cab4ef0f06","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Crous Resto U' Cours Léopold","lat":"48.6951174888681","long":"6.17719255321255","url":"images/28.jpg","link":"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/22/01/bb/3f/voici-la-facade-du-crous.jpg?w=1200&h=-1&s=1"}	\N	\N
42	43	photos	207178a9-c5ae-4808-bafa-8f608913b4dc	{"id":"207178a9-c5ae-4808-bafa-8f608913b4dc","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Statue équestre de Jeanne d'Arc","lat":"48.6941403391368","long":"6.1803078374452","url":"images/29.jpg","link":"https://th.bing.com/th/id/OIP.EIh8ndJen8yux0fiwlJybwHaLH?w=1200&h=1800&rs=1&pid=ImgDetMain"}	{"id":"207178a9-c5ae-4808-bafa-8f608913b4dc","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Statue équestre de Jeanne d'Arc","lat":"48.6941403391368","long":"6.1803078374452","url":"images/29.jpg","link":"https://th.bing.com/th/id/OIP.EIh8ndJen8yux0fiwlJybwHaLH?w=1200&h=1800&rs=1&pid=ImgDetMain"}	\N	\N
43	44	photos	0a5ad80f-6d33-435b-bb15-18fd65a39f68	{"id":"0a5ad80f-6d33-435b-bb15-18fd65a39f68","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"ARTEM","lat":"48.6728663484446","long":"6.17165752016288","url":"images/30.jpg","link":"https://live.staticflickr.com/65535/51217348797_7c1eb78d1b_b.jpg"}	{"id":"0a5ad80f-6d33-435b-bb15-18fd65a39f68","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"ARTEM","lat":"48.6728663484446","long":"6.17165752016288","url":"images/30.jpg","link":"https://live.staticflickr.com/65535/51217348797_7c1eb78d1b_b.jpg"}	\N	\N
44	45	photos	0a5ad80f-6d33-435b-bb15-18fd65a39f68	{"id":"0a5ad80f-6d33-435b-bb15-18fd65a39f68","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Ensic","lat":"48.699603595116","long":"6.17990889333166","url":"images/31.jpg","link":"https://th.bing.com/th/id/R.084fa9f085165b0d47e0e309c358d4cc?rik=zgQMf1MoZM4%2bqg&pid=ImgRaw&r=0"}	{"serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Ensic","lat":"48.699603595116","long":"6.17990889333166","url":"images/31.jpg","link":"https://th.bing.com/th/id/R.084fa9f085165b0d47e0e309c358d4cc?rik=zgQMf1MoZM4%2bqg&pid=ImgRaw&r=0"}	\N	\N
45	46	photos	9d062e03-eaff-4e35-b2e6-a483c5aa5ae1	{"id":"9d062e03-eaff-4e35-b2e6-a483c5aa5ae1","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Faculté des Sciences et Technologies","lat":"48.6650952083834","long":"6.16053031759351","url":"Images/32.jpg","link":"https://www.pagesjaunes.fr/media/ugc/faculte_des_sciences_et_technologies_05454700_094219295"}	{"id":"9d062e03-eaff-4e35-b2e6-a483c5aa5ae1","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Faculté des Sciences et Technologies","lat":"48.6650952083834","long":"6.16053031759351","url":"Images/32.jpg","link":"https://www.pagesjaunes.fr/media/ugc/faculte_des_sciences_et_technologies_05454700_094219295"}	\N	\N
46	50	directus_users	06e0a60d-1924-41e2-aef5-1c0526264f4c	{"id":"06e0a60d-1924-41e2-aef5-1c0526264f4c","email":"user@example.com","password":"**********"}	{"id":"06e0a60d-1924-41e2-aef5-1c0526264f4c","email":"user@example.com","password":"**********"}	\N	\N
47	51	directus_permissions	1	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"photos","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"photos","action":"read"}	\N	\N
48	52	directus_permissions	2	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"series","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"series","action":"read"}	\N	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_roles (id, name, icon, description, parent) FROM stdin;
105cea0d-738a-437b-9183-a23a33deacde	Administrator	verified	$t:admin_description	\N
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent, share, origin, next_token) FROM stdin;
GmpeaqJORyLX37Rsgb3mOJ48eEWlQvEZwATPl-YU0yzyyaWnt0vPm4-dGsX2HAXb	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-12 17:47:20.785+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:33556	\N
BVmSQp0myG4umeQ0CYM6IHNFcMrYBawsxWpoEq1BhA6qbD_7-GI_Gx1yySq9KDSQ	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-12 19:47:32.027+00	192.168.240.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:33556	\N
xG-iWog1_zm8kvyGA4CLqC5jqHKLQNGhHjkhD9sObRRx53zzRUuZd8_sJDPugOJO	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-12 20:08:20.68+00	192.168.240.1	axios/1.7.2	\N	\N	\N
Muzq7j2MsEbTr9dGXO2Y2Zp14MPyjSnO_wBuIJDsgFy1_iD2K3qr3W3GP9VlJWqO	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-12 21:02:24.589+00	192.168.240.1	axios/1.7.2	\N	\N	\N
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar, project_descriptor, default_language, custom_aspect_ratios, public_favicon, default_appearance, default_theme_light, theme_light_overrides, default_theme_dark, theme_dark_overrides, report_error_url, report_bug_url, report_feature_url, public_registration, public_registration_verify_email, public_registration_role, public_registration_email_filter) FROM stdin;
\.


--
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_shares (id, name, collection, item, role, password, user_created, date_created, date_start, date_end, times_used, max_uses) FROM stdin;
\.


--
-- Data for Name: directus_translations; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_translations (id, language, key, value) FROM stdin;
\.


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, tfa_secret, status, role, token, last_access, last_page, provider, external_identifier, auth_data, email_notifications, appearance, theme_dark, theme_light, theme_light_overrides, theme_dark_overrides) FROM stdin;
9d83a681-8388-4ff9-ae4b-7038fad0560a	Admin	User	admin@admin.com	$argon2id$v=19$m=65536,t=3,p=4$ldbeGnw9Vpw7TVve1vm8FA$os+nxmcnwY1jmP9O9lWrbzK78x6zeFJ8dHE+BF3shQQ	\N	\N	\N	\N	\N	\N	\N	active	105cea0d-738a-437b-9183-a23a33deacde	\N	2025-02-05 21:02:24.6+00	/settings/policies/abf8a154-5b1c-4a46-ac9c-7300570f4f17	default	\N	\N	t	\N	\N	\N	\N	\N
06e0a60d-1924-41e2-aef5-1c0526264f4c	\N	\N	user@example.com	$argon2id$v=19$m=65536,t=3,p=4$BuslLM2v2MeDkYTPA6U89Q$9JljQbJim+5e4wzmnj31Nr/gEAsnX4KXRiUjtO+WCV0	\N	\N	\N	\N	\N	\N	\N	active	\N	\N	\N	\N	default	\N	\N	t	\N	\N	\N	\N	\N
\.


--
-- Data for Name: directus_versions; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_versions (id, key, name, collection, item, hash, date_created, date_updated, user_created, user_updated, delta) FROM stdin;
\.


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_webhooks (id, name, method, url, status, data, actions, collections, headers, was_active_before_deprecation, migrated_flow) FROM stdin;
\.


--
-- Data for Name: photos; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.photos (id, serie_id, name, lat, long, url, link) FROM stdin;
55d1ecb2-82d9-445c-996b-68f7d1862432	85678cf6-5977-45aa-b727-8d5c677f7e41	Institut Universitaire de Technologie Nancy-Charlemagne	48.6828323658981	6.16091547406893	images/01.jpg	https://i.ytimg.com/vi/f3n6d4Ufk1U/maxresdefault_live.jpg
4d6c147e-2cdd-47a8-962a-5a8754f0a0fb	85678cf6-5977-45aa-b727-8d5c677f7e41	Musée des Beaux-Arts de Nancy	48.6934244497898	6.18235708015418	images/02.jpg	https://th.bing.com/th/id/R.ffa2da458031ec0d61c7aa59d49bb506?rik=73eXDK5WOPvL4A&pid=ImgRaw&r=0
93b2408f-eb3a-492f-98f1-fd71c7f702e1	85678cf6-5977-45aa-b727-8d5c677f7e41	Place Stanislas	48.6935915205383	6.18325640787205	images/03.jpg	https://i0.wp.com/viajealpatrimonio.com/wp-content/uploads/2020/05/0787-plaza-stanislas-plaza-de-la-carriere-y-plaza-de-la-alliance-en-nancy.jpg?ssl=1
82fc87f1-453a-4e54-9e37-b216aeb1af9c	85678cf6-5977-45aa-b727-8d5c677f7e41	Muséum-Aquarium de Nancy	48.6949427895482	6.18820822723179	images/04.jpg	https://www.archi-wiki.org/images/thumb/9/91/34_rue_Sainte_Catherine_(entr%C3%A9e)_DSC04646.jpg/1200px-34_rue_Sainte_Catherine_(entr%C3%A9e)_DSC04646.jpg
6a6a491c-a6a7-4e76-b2f3-3e0f337a3fd3	85678cf6-5977-45aa-b727-8d5c677f7e41	Porte Désilles	48.6979582620096	6.174147932838	images/05.jpg	https://media-cdn.tripadvisor.com/media/photo-s/14/af/43/c3/porte-desilles.jpg
f13c4c48-503b-4131-9856-77137afab803	85678cf6-5977-45aa-b727-8d5c677f7e41	Cathédrale Notre-Dame-de-l'Annonciation	48.6915229374518	6.1858817407413	images/06.jpg	https://live.staticflickr.com/3164/3098725110_0f37479776_b.jpg
969b7872-14f8-4f2a-8b13-4905d0dc088e	85678cf6-5977-45aa-b727-8d5c677f7e41	Place de la Carrière	48.6954725331034	6.18193781254074	images/07.jpg	https://api.cloudly.space/resize/crop/1200/627/60/aHR0cHM6Ly93d3cuc2l0bG9yLmZyL3Bob3Rvcy83MzcvcGxhY2VfZGVfbGFfY2FycmllcmUuanBnPzIwMjEtMDYtMjJUMTU6NDI6MjJa/image.jpg
ecc7ba07-95d1-4671-acd1-d975a676bed9	85678cf6-5977-45aa-b727-8d5c677f7e41	Basilique Saint-Epvre	48.695994903589	6.17991735334421	images/08.jpg	https://th.bing.com/th/id/R.f3da826715a8428a23f9421319e04d3c?rik=yEjlpTxxd%2beorA&riu=http%3a%2f%2flusile17.l.u.pic.centerblog.net%2fo%2fc8b40538.jpg&ehk=FKlylTb%2ffOKWDvalqpX5FQN4vXQqlBR79zBcaLfSBqQ%3d&risl=&pid=ImgRaw&r=0
cb8b71b4-7989-4b6c-a68d-182ec0475648	85678cf6-5977-45aa-b727-8d5c677f7e41	Villa Majorelle	48.6855117761987	6.16386613003089	images/09.jpg	https://th.bing.com/th/id/OIP.8RzG0_gbx6N2P59VpOXSagHaEk?rs=1&pid=ImgDetMain
d1ad5874-64df-40c8-8639-6728e614298d	85678cf6-5977-45aa-b727-8d5c677f7e41	Parc de la Pépinière	48.6977712521057	6.18460627665755	images/10.jpg	https://frenchmoments.eu/wp-content/uploads/2012/11/Parc-de-la-P%C3%A9pini%C3%A8re-04-Nancy-%C2%A9-French-Moments.jpg
3f616107-69e6-4586-afc3-8a73c6b86891	85678cf6-5977-45aa-b727-8d5c677f7e41	Parc de la Cure d'Air	48.6933896583972	6.15995144259252	images/11.jpg	https://api.cloudly.space/resize/crop/1200/627/60/aHR0cHM6Ly93d3cuc2l0bG9yLmZyL3Bob3Rvcy83MzcvNzM3MDAwMjcxXzQuanBnPzIwMjEtMTItMjFUMTE6Mzk6NDha/image.jpg
211f70c8-8e04-4b97-8f84-328e8b043344	85678cf6-5977-45aa-b727-8d5c677f7e41	Centre Commercial Saint Sébastien	48.6880087792139	6.18067681830613	images/12.jpg	https://media-cdn.tripadvisor.com/media/photo-s/14/af/ea/6d/centre-commercial-saint.jpg
94d5df24-03eb-4e4d-87ca-a4fce91d8c34	85678cf6-5977-45aa-b727-8d5c677f7e41	Gare de Nancy	48.6897919909649	6.17440457810537	images/13.jpg	https://s3-media4.fl.yelpcdn.com/bphoto/fXtPxdpgpHr9RHB-Je-L6Q/o.jpg
a74fb23e-1ba0-4ac0-8391-dad8b06b81d9	85678cf6-5977-45aa-b727-8d5c677f7e41	Basilique du Sacré-Cœur de Nancy	48.6855496603864	6.16246257435614	images/14.jpg	https://th.bing.com/th/id/R.5ff55d576be674cdbb45aecd98a3faed?rik=JlZd9fGH6KJUJA&riu=http%3a%2f%2fphotos.wikimapia.org%2fp%2f00%2f01%2f68%2f26%2f37_big.jpg&ehk=U7mJ1UYZw%2bsFL31cbbDb5PnjnqP8Ca%2b3kjaR8Tpx5Hg%3d&risl=&pid=ImgRaw&r=0
2bf6df61-3bc2-4d0b-b5d9-5ebc094c04c3	85678cf6-5977-45aa-b727-8d5c677f7e41	Église Saint-Léon de Nancy	48.6892766684842	6.17207148496397	images/15.jpg	https://th.bing.com/th/id/OIP.-EvWoogHdOjjQTwMAaH8zwAAAA?w=384&h=547&rs=1&pid=ImgDetMain
5c6dc88e-be57-4e8e-8789-fda2d396cec5	85678cf6-5977-45aa-b727-8d5c677f7e41	Nancy Thermal	48.6791632317088	6.16872369208436	images/16.jpg	https://th.bing.com/th/id/R.98072a4bf1a9d532bdb8f0081a6f6118?rik=uARF5UMHDtuiig&riu=http%3a%2f%2fdha.eu%2fwp-content%2fuploads%2f2018%2f10%2f05.106.38.jpg&ehk=F93hYCSX%2f%2fbwFxNS78lk5VvilbZluJcchdrp9C2szMU%3d&risl=&pid=ImgRaw&r=0
00ed930e-e697-4b2a-96a4-92f84ed79aec	85678cf6-5977-45aa-b727-8d5c677f7e41	Jardin Botanique Jean-Marie Pelt	48.662758	6.155456	images/17.jpg	https://fr.wikipedia.org/wiki/Jardin_botanique_Jean-Marie-Pelt#/media/Fichier:Jardin_botanique_Montet_1.jpg
a3e4f064-84f4-402f-a9e6-9b00ce361c50	85678cf6-5977-45aa-b727-8d5c677f7e41	Plage de la Méchelle	48.6922610233877	6.20239706106462	images/18.jpg	https://cdn-s-www.estrepublicain.fr/images/B641AA78-4B8E-4544-9AF6-196687C4E853/NW_raw/le-nouveau-site-de-la-mechelle-a-connu-une-frequentation-contrastee-entre-jours-pluvieux-et-temps-plus-estival-photo-er-cedric-jacquot-1629912614.jpg
c05787a9-0e6f-4502-a932-ee5881addc7b	85678cf6-5977-45aa-b727-8d5c677f7e41	Musée Lorrain	48.6973116730877	6.17934775730296	images/19.jpg	https://media-cdn.tripadvisor.com/media/photo-s/1a/aa/52/81/portale.jpg
41874312-d6a0-48e3-b16c-1be8e7cf9d44	85678cf6-5977-45aa-b727-8d5c677f7e41	Porte de la Craffe	48.6988659264728	6.17779765611324	images/20.jpg	https://i.pinimg.com/originals/ca/dd/5a/cadd5a34c4f64319dbb15b576d1e7369.jpg
588f48b7-3d1e-4ceb-bdfe-bfb43e7d09ca	85678cf6-5977-45aa-b727-8d5c677f7e41	Tour de la Commanderie Nazet-Moutaux	48.6865659854259	6.16735481677689	images/21.jpg	https://dynamic-media-cdn.tripadvisor.com/media/photo-o/24/1c/a5/8f/up-some-steps.jpg?w=1200&h=-1&s=1
bdf9f03d-962f-43c2-b89f-65e8e6cfbf41	85678cf6-5977-45aa-b727-8d5c677f7e41	Campus Lettres et Sciences Humaines de Nancy - Université de Lorraine	48.6955810198057	6.16599935776565	images/22.jpg	https://cdn-s-www.estrepublicain.fr/images/5ED2BEB3-6BEB-4C0B-8797-28AF345C4C4B/NW_raw/title-1607632070.jpg
12b31bea-edd6-4174-8cd7-3bb38a0efbfe	85678cf6-5977-45aa-b727-8d5c677f7e41	Faculté de Droit, Sciences Économiques et Gestion	48.6931229890256	6.1766413458741	images/23.jpg	https://live.staticflickr.com/65535/48864028882_580f6e3ff6_b.jpg
788af01e-36c3-4805-872c-c007c7758624	85678cf6-5977-45aa-b727-8d5c677f7e41	Stade Marcel Picot	48.6954249246343	6.21053652030365	images/24.jpg	https://th.bing.com/th/id/R.5228ad9f481c3985cc289b82e7ee9669?rik=AGJxuyX3ya272A&riu=http%3a%2f%2fwww.ostadium.com%2fgalleries%2fstade-marcel-picot-vue-aerienne-illus.jpg&ehk=s5JHg2RJq625D3pzyEzQoJquUrRUZ4HKasOuMOXKW%2f0%3d&risl=&pid=ImgRaw&r=0&sres=1&sres
c039aa00-88c2-4769-ad38-33df96fc64f3	85678cf6-5977-45aa-b727-8d5c677f7e41	Château de Montaigu	48.6633822330804	6.2158060491444	images/25.jpg	https://static.wixstatic.com/media/4d8fa8_49bbe10b1b374654a9304828fa4b9e21~mv2.jpg/v1/fill/w_2500,h_1830,al_c/4d8fa8_49bbe10b1b374654a9304828fa4b9e21~mv2.jpg
781d1eeb-b809-4186-bc0b-7b90127f9e68	85678cf6-5977-45aa-b727-8d5c677f7e41	IUT Nancy-Brabois	48.6588705423001	6.15140298760477	images/26.jpg	https://iut-nancy-brabois.univ-lorraine.fr/files/2023/09/iutnb-campus-luneville-1536x1024.jpg
bcfbcf15-b835-4008-83d7-2ff935a6e918	85678cf6-5977-45aa-b727-8d5c677f7e41	Musée de l'École de Nancy	48.6805236575265	6.16617418668594	images/27.jpg	https://fr.wikipedia.org/wiki/Mus%C3%A9e_de_l%27%C3%89cole_de_Nancy#/media/Fichier:Mus%C3%A9e_%C3%A9cole_Nancy.jpg
f4b0d799-e1ff-4506-a783-b6cab4ef0f06	85678cf6-5977-45aa-b727-8d5c677f7e41	Crous Resto U' Cours Léopold	48.6951174888681	6.17719255321255	images/28.jpg	https://dynamic-media-cdn.tripadvisor.com/media/photo-o/22/01/bb/3f/voici-la-facade-du-crous.jpg?w=1200&h=-1&s=1
207178a9-c5ae-4808-bafa-8f608913b4dc	85678cf6-5977-45aa-b727-8d5c677f7e41	Statue équestre de Jeanne d'Arc	48.6941403391368	6.1803078374452	images/29.jpg	https://th.bing.com/th/id/OIP.EIh8ndJen8yux0fiwlJybwHaLH?w=1200&h=1800&rs=1&pid=ImgDetMain
0a5ad80f-6d33-435b-bb15-18fd65a39f68	85678cf6-5977-45aa-b727-8d5c677f7e41	Ensic	48.699603595116	6.17990889333166	images/31.jpg	https://th.bing.com/th/id/R.084fa9f085165b0d47e0e309c358d4cc?rik=zgQMf1MoZM4%2bqg&pid=ImgRaw&r=0
9d062e03-eaff-4e35-b2e6-a483c5aa5ae1	85678cf6-5977-45aa-b727-8d5c677f7e41	Faculté des Sciences et Technologies	48.6650952083834	6.16053031759351	Images/32.jpg	https://www.pagesjaunes.fr/media/ugc/faculte_des_sciences_et_technologies_05454700_094219295
\.


--
-- Data for Name: series; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.series (id, name, description) FROM stdin;
85678cf6-5977-45aa-b727-8d5c677f7e41	Nancy	Les lieux les plus mythiques de Nancy
\.


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 53, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 10, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 2, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 2, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 1, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 48, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, false);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: directus_access directus_access_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_pkey PRIMARY KEY (id);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_comments directus_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_pkey PRIMARY KEY (id);


--
-- Name: directus_dashboards directus_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_pkey PRIMARY KEY (id);


--
-- Name: directus_extensions directus_extensions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_extensions
    ADD CONSTRAINT directus_extensions_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_flows directus_flows_operation_unique; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_operation_unique UNIQUE (operation);


--
-- Name: directus_flows directus_flows_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_notifications directus_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_reject_unique; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_unique UNIQUE (reject);


--
-- Name: directus_operations directus_operations_resolve_unique; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_unique UNIQUE (resolve);


--
-- Name: directus_panels directus_panels_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_pkey PRIMARY KEY (id);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_policies directus_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_policies
    ADD CONSTRAINT directus_policies_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_shares directus_shares_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_pkey PRIMARY KEY (id);


--
-- Name: directus_translations directus_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_translations
    ADD CONSTRAINT directus_translations_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_external_identifier_unique; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_external_identifier_unique UNIQUE (external_identifier);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_token_unique; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_token_unique UNIQUE (token);


--
-- Name: directus_versions directus_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_pkey PRIMARY KEY (id);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: photos photos_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_pkey PRIMARY KEY (id);


--
-- Name: series series_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.series
    ADD CONSTRAINT series_pkey PRIMARY KEY (id);


--
-- Name: directus_access directus_access_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_collections directus_collections_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_collections(collection);


--
-- Name: directus_comments directus_comments_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_comments directus_comments_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_dashboards directus_dashboards_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_flows directus_flows_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_notifications directus_notifications_recipient_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_recipient_foreign FOREIGN KEY (recipient) REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_notifications directus_notifications_sender_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_sender_foreign FOREIGN KEY (sender) REFERENCES public.directus_users(id);


--
-- Name: directus_operations directus_operations_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_flow_foreign FOREIGN KEY (flow) REFERENCES public.directus_flows(id) ON DELETE CASCADE;


--
-- Name: directus_operations directus_operations_reject_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_foreign FOREIGN KEY (reject) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_resolve_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_foreign FOREIGN KEY (resolve) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_panels directus_panels_dashboard_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_dashboard_foreign FOREIGN KEY (dashboard) REFERENCES public.directus_dashboards(id) ON DELETE CASCADE;


--
-- Name: directus_panels directus_panels_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_permissions directus_permissions_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_revisions directus_revisions_version_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_version_foreign FOREIGN KEY (version) REFERENCES public.directus_versions(id) ON DELETE CASCADE;


--
-- Name: directus_roles directus_roles_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_roles(id);


--
-- Name: directus_sessions directus_sessions_share_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_share_foreign FOREIGN KEY (share) REFERENCES public.directus_shares(id) ON DELETE CASCADE;


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_favicon_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_favicon_foreign FOREIGN KEY (public_favicon) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_registration_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_registration_role_foreign FOREIGN KEY (public_registration_role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_settings directus_settings_storage_default_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_storage_default_folder_foreign FOREIGN KEY (storage_default_folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_shares directus_shares_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_versions directus_versions_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_webhooks directus_webhooks_migrated_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_migrated_flow_foreign FOREIGN KEY (migrated_flow) REFERENCES public.directus_flows(id) ON DELETE SET NULL;


--
-- Name: photos photos_serie_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_serie_id_foreign FOREIGN KEY (serie_id) REFERENCES public.series(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

