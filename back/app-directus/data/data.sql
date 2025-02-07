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
    link character varying(255),
    file uuid
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
54	login	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:30:21.768+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	9d83a681-8388-4ff9-ae4b-7038fad0560a	http://localhost:33556
55	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:18.904+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	b2f5899f-e1c5-4982-8af0-729a5c74444c	http://localhost:33556
56	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:18.923+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	73b2e5d2-a82f-4ede-b6de-f0ef222c2d54	http://localhost:33556
57	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:18.951+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	62b172d1-ec04-40fe-a3a8-7fc6f17eaabf	http://localhost:33556
58	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:18.967+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	19c92283-f83d-48f2-87d6-e89742de1f8c	http://localhost:33556
59	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:18.972+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	fa3728ba-aa35-4216-a451-3017436df012	http://localhost:33556
60	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:18.986+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	c7e68c19-ed8c-4f0f-8706-68eac916cd76	http://localhost:33556
61	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.039+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	1ec9db0f-922f-4d4a-ae23-8586bc2e01f6	http://localhost:33556
62	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.044+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	c701ce16-8da2-4605-a7aa-b0143bdc3256	http://localhost:33556
63	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.097+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	ae8b37b2-f83e-466f-b823-dff1c55176fa	http://localhost:33556
64	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.114+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	fbb8eda1-5a1c-4001-b68c-63ea505c8cd7	http://localhost:33556
65	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.121+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	3b25d8cc-c200-4033-bd59-9dae81d9b54c	http://localhost:33556
66	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.164+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	ecee2f07-bf16-46a4-ba2b-c4bd3b564cc6	http://localhost:33556
67	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.183+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	5445a86e-1904-40bd-911f-06b82ed41b59	http://localhost:33556
68	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.196+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	8e5cc9e6-6761-47e8-af88-a64a083dd899	http://localhost:33556
69	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.2+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	ce53eb86-ee14-4587-bbd3-0b149b70108f	http://localhost:33556
70	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.237+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	e405cdda-0a5e-4b68-b112-893e9ce5d0e7	http://localhost:33556
71	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.26+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	dafee953-9363-4f62-881d-b9c2dbc9d191	http://localhost:33556
72	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.272+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	da5a49a5-5171-488d-9af5-c124b5ee5444	http://localhost:33556
73	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.297+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	76df5f29-1826-48bd-ab36-eaf23cd03cc9	http://localhost:33556
74	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.319+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	6915b663-fb80-40a3-9481-a7032603a171	http://localhost:33556
75	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.327+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	bd5a6ebb-0f09-4771-9f8f-c3f58e549aca	http://localhost:33556
76	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.384+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	7d63f98c-76ad-4755-938b-fe88b0030bc5	http://localhost:33556
77	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.412+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	06447e4a-ca12-422b-989f-b9d791ac3554	http://localhost:33556
78	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.415+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	ca4dd00c-1ac1-4917-b8bc-b82e280888e6	http://localhost:33556
84	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.53+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	a5a34488-797f-4f54-a54e-4b767e95fd39	http://localhost:33556
79	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.43+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	f5df93ea-7ba4-4f06-9242-8166091b4819	http://localhost:33556
83	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.526+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	0c1b8d40-0e84-49c4-a7f7-439e87c5df1f	http://localhost:33556
80	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.431+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	58cfdd05-2848-4fa3-a117-08002848576a	http://localhost:33556
82	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.515+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	0af0db58-edf1-4032-acfb-c45451930bde	http://localhost:33556
81	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.454+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	c024b671-6386-4743-9384-cb3662fb11e4	http://localhost:33556
85	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.531+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	48490935-f8aa-4e9d-a448-15ea8e162419	http://localhost:33556
86	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.573+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	bc0aa97d-6864-4b2d-b95d-d00f16cf2acc	http://localhost:33556
87	delete	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:32:57.11+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	9	http://localhost:33556
88	create	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:33:28.232+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	11	http://localhost:33556
89	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:33:38.023+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	4	http://localhost:33556
90	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:33:38.044+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	5	http://localhost:33556
91	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:33:38.059+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	6	http://localhost:33556
92	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:33:38.072+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	7	http://localhost:33556
93	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:33:38.089+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	8	http://localhost:33556
94	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:33:38.101+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	11	http://localhost:33556
95	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:33:38.111+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	10	http://localhost:33556
96	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:34:31.214+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	55d1ecb2-82d9-445c-996b-68f7d1862432	http://localhost:33556
97	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:37:56.181+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	00ed930e-e697-4b2a-96a4-92f84ed79aec	http://localhost:33556
98	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:38:10.052+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	0a5ad80f-6d33-435b-bb15-18fd65a39f68	http://localhost:33556
99	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:38:29.858+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	12b31bea-edd6-4174-8cd7-3bb38a0efbfe	http://localhost:33556
100	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:38:46.688+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	207178a9-c5ae-4808-bafa-8f608913b4dc	http://localhost:33556
101	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:39:00.337+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	211f70c8-8e04-4b97-8f84-328e8b043344	http://localhost:33556
102	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:39:18.878+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	2bf6df61-3bc2-4d0b-b5d9-5ebc094c04c3	http://localhost:33556
103	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:39:37.92+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	3f616107-69e6-4586-afc3-8a73c6b86891	http://localhost:33556
104	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:39:55.839+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	41874312-d6a0-48e3-b16c-1be8e7cf9d44	http://localhost:33556
105	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:40:17.013+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	4d6c147e-2cdd-47a8-962a-5a8754f0a0fb	http://localhost:33556
106	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:40:32.049+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	588f48b7-3d1e-4ceb-bdfe-bfb43e7d09ca	http://localhost:33556
107	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:40:58.13+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	5c6dc88e-be57-4e8e-8789-fda2d396cec5	http://localhost:33556
108	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:41:20.707+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	6a6a491c-a6a7-4e76-b2f3-3e0f337a3fd3	http://localhost:33556
109	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:41:34.765+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	781d1eeb-b809-4186-bc0b-7b90127f9e68	http://localhost:33556
110	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:41:43.234+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	788af01e-36c3-4805-872c-c007c7758624	http://localhost:33556
111	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:41:55.436+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	82fc87f1-453a-4e54-9e37-b216aeb1af9c	http://localhost:33556
112	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:42:09.046+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	93b2408f-eb3a-492f-98f1-fd71c7f702e1	http://localhost:33556
113	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:42:18.43+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	94d5df24-03eb-4e4d-87ca-a4fce91d8c34	http://localhost:33556
114	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:42:37.434+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	969b7872-14f8-4f2a-8b13-4905d0dc088e	http://localhost:33556
115	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:42:46.064+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	9d062e03-eaff-4e35-b2e6-a483c5aa5ae1	http://localhost:33556
116	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:43:04.741+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	a3e4f064-84f4-402f-a9e6-9b00ce361c50	http://localhost:33556
117	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:43:22.277+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	a74fb23e-1ba0-4ac0-8391-dad8b06b81d9	http://localhost:33556
118	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:43:39.033+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	bcfbcf15-b835-4008-83d7-2ff935a6e918	http://localhost:33556
119	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:43:51.552+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	bdf9f03d-962f-43c2-b89f-65e8e6cfbf41	http://localhost:33556
120	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:44:06.417+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	c05787a9-0e6f-4502-a932-ee5881addc7b	http://localhost:33556
121	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:44:19.842+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	cb8b71b4-7989-4b6c-a68d-182ec0475648	http://localhost:33556
122	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:44:29.612+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	d1ad5874-64df-40c8-8639-6728e614298d	http://localhost:33556
123	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:44:45.481+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	ecc7ba07-95d1-4671-acd1-d975a676bed9	http://localhost:33556
124	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:45:07.096+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	f13c4c48-503b-4131-9856-77137afab803	http://localhost:33556
125	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:45:16.177+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	f4b0d799-e1ff-4506-a783-b6cab4ef0f06	http://localhost:33556
126	login	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:22:00.873+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	9d83a681-8388-4ff9-ae4b-7038fad0560a	http://localhost:33556
127	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:25:47.027+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	58cfdd05-2848-4fa3-a117-08002848576a	http://localhost:33556
128	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:25:47.049+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	58cfdd05-2848-4fa3-a117-08002848576a	http://localhost:33556
129	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:26:05.472+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	48490935-f8aa-4e9d-a448-15ea8e162419	http://localhost:33556
130	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:26:05.491+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	48490935-f8aa-4e9d-a448-15ea8e162419	http://localhost:33556
131	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:26:15.392+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	c024b671-6386-4743-9384-cb3662fb11e4	http://localhost:33556
132	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:26:15.409+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	c024b671-6386-4743-9384-cb3662fb11e4	http://localhost:33556
133	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:26:22.785+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	a5a34488-797f-4f54-a54e-4b767e95fd39	http://localhost:33556
134	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:26:22.801+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	a5a34488-797f-4f54-a54e-4b767e95fd39	http://localhost:33556
135	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:26:31.741+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	0c1b8d40-0e84-49c4-a7f7-439e87c5df1f	http://localhost:33556
136	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:26:31.76+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	0c1b8d40-0e84-49c4-a7f7-439e87c5df1f	http://localhost:33556
137	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:26:39.477+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	0af0db58-edf1-4032-acfb-c45451930bde	http://localhost:33556
138	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:26:39.491+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	0af0db58-edf1-4032-acfb-c45451930bde	http://localhost:33556
139	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:28:52.541+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	f5df93ea-7ba4-4f06-9242-8166091b4819	http://localhost:33556
140	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:28:52.556+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	f5df93ea-7ba4-4f06-9242-8166091b4819	http://localhost:33556
141	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:02.799+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	7d63f98c-76ad-4755-938b-fe88b0030bc5	http://localhost:33556
142	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:02.814+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	7d63f98c-76ad-4755-938b-fe88b0030bc5	http://localhost:33556
143	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:10.488+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	06447e4a-ca12-422b-989f-b9d791ac3554	http://localhost:33556
144	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:10.505+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	06447e4a-ca12-422b-989f-b9d791ac3554	http://localhost:33556
145	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:17.497+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	ca4dd00c-1ac1-4917-b8bc-b82e280888e6	http://localhost:33556
146	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:17.513+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	ca4dd00c-1ac1-4917-b8bc-b82e280888e6	http://localhost:33556
147	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:24.193+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	bd5a6ebb-0f09-4771-9f8f-c3f58e549aca	http://localhost:33556
148	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:24.208+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	bd5a6ebb-0f09-4771-9f8f-c3f58e549aca	http://localhost:33556
149	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:31.764+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	da5a49a5-5171-488d-9af5-c124b5ee5444	http://localhost:33556
150	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:31.782+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	da5a49a5-5171-488d-9af5-c124b5ee5444	http://localhost:33556
155	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:53.881+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	dafee953-9363-4f62-881d-b9c2dbc9d191	http://localhost:33556
156	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:53.896+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	dafee953-9363-4f62-881d-b9c2dbc9d191	http://localhost:33556
167	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:33:24.123+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	fbb8eda1-5a1c-4001-b68c-63ea505c8cd7	http://localhost:33556
168	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:33:24.137+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	fbb8eda1-5a1c-4001-b68c-63ea505c8cd7	http://localhost:33556
169	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:33:40.546+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	3b25d8cc-c200-4033-bd59-9dae81d9b54c	http://localhost:33556
170	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:33:40.56+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	3b25d8cc-c200-4033-bd59-9dae81d9b54c	http://localhost:33556
171	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:33:47.523+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	73b2e5d2-a82f-4ede-b6de-f0ef222c2d54	http://localhost:33556
172	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:33:47.543+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	73b2e5d2-a82f-4ede-b6de-f0ef222c2d54	http://localhost:33556
151	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:38.651+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	6915b663-fb80-40a3-9481-a7032603a171	http://localhost:33556
152	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:38.667+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	6915b663-fb80-40a3-9481-a7032603a171	http://localhost:33556
159	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:30:09.341+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	ce53eb86-ee14-4587-bbd3-0b149b70108f	http://localhost:33556
160	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:30:09.351+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	ce53eb86-ee14-4587-bbd3-0b149b70108f	http://localhost:33556
153	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:46.677+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	e405cdda-0a5e-4b68-b112-893e9ce5d0e7	http://localhost:33556
154	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:46.692+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	e405cdda-0a5e-4b68-b112-893e9ce5d0e7	http://localhost:33556
157	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:30:01.411+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	76df5f29-1826-48bd-ab36-eaf23cd03cc9	http://localhost:33556
158	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:30:01.426+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	76df5f29-1826-48bd-ab36-eaf23cd03cc9	http://localhost:33556
161	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:30:16.014+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	8e5cc9e6-6761-47e8-af88-a64a083dd899	http://localhost:33556
162	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:30:16.028+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	8e5cc9e6-6761-47e8-af88-a64a083dd899	http://localhost:33556
163	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:33:09.513+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	5445a86e-1904-40bd-911f-06b82ed41b59	http://localhost:33556
164	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:33:09.528+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	5445a86e-1904-40bd-911f-06b82ed41b59	http://localhost:33556
165	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:33:16.27+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	ecee2f07-bf16-46a4-ba2b-c4bd3b564cc6	http://localhost:33556
166	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:33:16.285+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	ecee2f07-bf16-46a4-ba2b-c4bd3b564cc6	http://localhost:33556
173	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:33:54.393+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	ae8b37b2-f83e-466f-b823-dff1c55176fa	http://localhost:33556
174	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:33:54.408+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	ae8b37b2-f83e-466f-b823-dff1c55176fa	http://localhost:33556
175	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:36:37.492+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	c701ce16-8da2-4605-a7aa-b0143bdc3256	http://localhost:33556
176	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:36:37.508+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	c701ce16-8da2-4605-a7aa-b0143bdc3256	http://localhost:33556
177	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:36:44.312+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	1ec9db0f-922f-4d4a-ae23-8586bc2e01f6	http://localhost:33556
178	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:36:44.326+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	1ec9db0f-922f-4d4a-ae23-8586bc2e01f6	http://localhost:33556
179	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:36:51.551+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	c7e68c19-ed8c-4f0f-8706-68eac916cd76	http://localhost:33556
180	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:36:51.56+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	c7e68c19-ed8c-4f0f-8706-68eac916cd76	http://localhost:33556
181	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:36:58.077+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	62b172d1-ec04-40fe-a3a8-7fc6f17eaabf	http://localhost:33556
182	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:36:58.092+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	62b172d1-ec04-40fe-a3a8-7fc6f17eaabf	http://localhost:33556
183	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:37:05.119+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	fa3728ba-aa35-4216-a451-3017436df012	http://localhost:33556
184	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:37:05.134+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	fa3728ba-aa35-4216-a451-3017436df012	http://localhost:33556
185	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:37:12.692+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	19c92283-f83d-48f2-87d6-e89742de1f8c	http://localhost:33556
186	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:37:12.699+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	19c92283-f83d-48f2-87d6-e89742de1f8c	http://localhost:33556
187	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:37:20.162+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	b2f5899f-e1c5-4982-8af0-729a5c74444c	http://localhost:33556
188	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:37:20.176+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_files	b2f5899f-e1c5-4982-8af0-729a5c74444c	http://localhost:33556
189	update	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:40:52.844+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	photos	c039aa00-88c2-4769-ad38-33df96fc64f3	http://localhost:33556
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
11	photos	file	file	file	\N	\N	\N	f	f	6	full	\N	\N	\N	f	\N	\N	\N
10	photos	link	\N	input	\N	\N	\N	f	f	7	full	\N	\N	\N	f	\N	\N	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, created_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata, focal_point_x, focal_point_y, tus_id, tus_data, uploaded_on) FROM stdin;
bc0aa97d-6864-4b2d-b95d-d00f16cf2acc	local	bc0aa97d-6864-4b2d-b95d-d00f16cf2acc.jpg	32.jpg	32	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.568+00	\N	2025-02-07 12:31:19.582+00	\N	116193	1024	680	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 12:31:19.581+00
a5a34488-797f-4f54-a54e-4b767e95fd39	local	a5a34488-797f-4f54-a54e-4b767e95fd39.jpg	31.jpg	31	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.527+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:26:22.8+00	\N	152692	600	400	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:26:22.797+00
0af0db58-edf1-4032-acfb-c45451930bde	local	0af0db58-edf1-4032-acfb-c45451930bde.jpg	28.jpg	28	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.498+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:26:39.491+00	\N	134793	1200	526	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:26:39.488+00
58cfdd05-2848-4fa3-a117-08002848576a	local	58cfdd05-2848-4fa3-a117-08002848576a.jpg	25.jpg	25	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.424+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:25:47.048+00	\N	1401633	2500	1830	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:25:47.045+00
c024b671-6386-4743-9384-cb3662fb11e4	local	c024b671-6386-4743-9384-cb3662fb11e4.jpg	27.jpg	27	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.452+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:26:15.408+00	\N	899393	1920	1280	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:26:15.406+00
06447e4a-ca12-422b-989f-b9d791ac3554	local	06447e4a-ca12-422b-989f-b9d791ac3554.jpg	23.jpg	23	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.409+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:10.504+00	\N	199023	1024	683	\N	\N	\N	\N	\N	{"ifd0":{"Make":"NIKON CORPORATION","Model":"NIKON D750"},"exif":{"ExposureTime":0.0025,"FocalLength":24,"ISOSpeedRatings":250}}	\N	\N	\N	\N	2025-02-07 13:29:10.501+00
48490935-f8aa-4e9d-a448-15ea8e162419	local	48490935-f8aa-4e9d-a448-15ea8e162419.jpg	30.jpg	30	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.528+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:26:05.49+00	\N	320698	1024	682	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:26:05.487+00
0c1b8d40-0e84-49c4-a7f7-439e87c5df1f	local	0c1b8d40-0e84-49c4-a7f7-439e87c5df1f.jpg	29.jpg	29	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.524+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:26:31.758+00	\N	294973	1200	1800	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:26:31.755+00
7d63f98c-76ad-4755-938b-fe88b0030bc5	local	7d63f98c-76ad-4755-938b-fe88b0030bc5.jpg	22.jpg	22	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.379+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:02.813+00	\N	344500	1600	1065	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:29:02.81+00
f5df93ea-7ba4-4f06-9242-8166091b4819	local	f5df93ea-7ba4-4f06-9242-8166091b4819.jpg	26.jpg	26	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.428+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:28:52.555+00	\N	196572	1536	1024	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:28:52.552+00
6915b663-fb80-40a3-9481-a7032603a171	local	6915b663-fb80-40a3-9481-a7032603a171.jpg	20.jpg	20	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.303+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:38.666+00	\N	167399	680	1024	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:29:38.663+00
da5a49a5-5171-488d-9af5-c124b5ee5444	local	da5a49a5-5171-488d-9af5-c124b5ee5444.jpg	18.jpg	18	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.268+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:31.781+00	\N	574786	1600	1065	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:29:31.778+00
ae8b37b2-f83e-466f-b823-dff1c55176fa	local	ae8b37b2-f83e-466f-b823-dff1c55176fa.jpg	09.jpg	09	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.082+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:33:54.408+00	\N	27341	474	292	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:33:54.405+00
ca4dd00c-1ac1-4917-b8bc-b82e280888e6	local	ca4dd00c-1ac1-4917-b8bc-b82e280888e6.jpg	24.jpg	24	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.413+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:17.512+00	\N	109119	750	386	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:29:17.51+00
bd5a6ebb-0f09-4771-9f8f-c3f58e549aca	local	bd5a6ebb-0f09-4771-9f8f-c3f58e549aca.jpg	21.jpg	21	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.322+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:24.207+00	\N	338311	1200	1498	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:29:24.205+00
dafee953-9363-4f62-881d-b9c2dbc9d191	local	dafee953-9363-4f62-881d-b9c2dbc9d191.jpg	17.jpg	17	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.258+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:53.895+00	\N	514335	1920	1301	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:29:53.893+00
ce53eb86-ee14-4587-bbd3-0b149b70108f	local	ce53eb86-ee14-4587-bbd3-0b149b70108f.jpg	15.jpg	15	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.198+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:30:09.35+00	\N	32909	384	547	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:30:09.347+00
e405cdda-0a5e-4b68-b112-893e9ce5d0e7	local	e405cdda-0a5e-4b68-b112-893e9ce5d0e7.jpg	16.jpg	16	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.233+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:29:46.691+00	\N	651015	2000	1128	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:29:46.688+00
76df5f29-1826-48bd-ab36-eaf23cd03cc9	local	76df5f29-1826-48bd-ab36-eaf23cd03cc9.jpg	19.jpg	19	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.288+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:30:01.425+00	\N	31073	253	450	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:30:01.422+00
8e5cc9e6-6761-47e8-af88-a64a083dd899	local	8e5cc9e6-6761-47e8-af88-a64a083dd899.jpg	14.jpg	14	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.186+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:30:16.027+00	\N	48274	422	600	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:30:16.025+00
5445a86e-1904-40bd-911f-06b82ed41b59	local	5445a86e-1904-40bd-911f-06b82ed41b59.jpg	13.jpg	13	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.18+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:33:09.527+00	\N	150173	1000	750	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:33:09.525+00
ecee2f07-bf16-46a4-ba2b-c4bd3b564cc6	local	ecee2f07-bf16-46a4-ba2b-c4bd3b564cc6.jpg	12.jpg	12	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.154+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:33:16.284+00	\N	50963	550	342	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:33:16.282+00
fbb8eda1-5a1c-4001-b68c-63ea505c8cd7	local	fbb8eda1-5a1c-4001-b68c-63ea505c8cd7.jpg	10.jpg	10	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.105+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:33:24.136+00	\N	517573	1200	900	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:33:24.133+00
3b25d8cc-c200-4033-bd59-9dae81d9b54c	local	3b25d8cc-c200-4033-bd59-9dae81d9b54c.jpg	11.jpg	11	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.118+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:33:40.559+00	\N	135699	1200	627	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:33:40.557+00
73b2e5d2-a82f-4ede-b6de-f0ef222c2d54	local	73b2e5d2-a82f-4ede-b6de-f0ef222c2d54.jpg	02.jpg	02	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:18.918+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:33:47.541+00	\N	1324547	1600	1068	\N	\N	\N	\N	\N	{"ifd0":{"Make":"Canon","Model":"Canon EOS-1D"},"exif":{"FNumber":5,"ExposureTime":0.004,"FocalLength":80,"ISOSpeedRatings":200}}	\N	\N	\N	\N	2025-02-07 13:33:47.536+00
1ec9db0f-922f-4d4a-ae23-8586bc2e01f6	local	1ec9db0f-922f-4d4a-ae23-8586bc2e01f6.jpg	07.jpg	07	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.027+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:36:44.326+00	\N	122227	1200	627	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:36:44.323+00
c7e68c19-ed8c-4f0f-8706-68eac916cd76	local	c7e68c19-ed8c-4f0f-8706-68eac916cd76.jpg	04.jpg	04	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:18.984+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:36:51.559+00	\N	172649	1200	900	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:36:51.557+00
62b172d1-ec04-40fe-a3a8-7fc6f17eaabf	local	62b172d1-ec04-40fe-a3a8-7fc6f17eaabf.jpg	06.jpg	06	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:18.937+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:36:58.091+00	\N	216528	681	1024	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:36:58.088+00
c701ce16-8da2-4605-a7aa-b0143bdc3256	local	c701ce16-8da2-4605-a7aa-b0143bdc3256.jpg	08.jpg	08	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:19.042+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:36:37.508+00	\N	159477	738	962	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:36:37.505+00
fa3728ba-aa35-4216-a451-3017436df012	local	fa3728ba-aa35-4216-a451-3017436df012.jpg	03.jpg	03	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:18.968+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:37:05.133+00	\N	176024	1024	683	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:37:05.131+00
19c92283-f83d-48f2-87d6-e89742de1f8c	local	19c92283-f83d-48f2-87d6-e89742de1f8c.jpg	05.jpg	05	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:18.963+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:37:12.699+00	\N	52806	550	342	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:37:12.696+00
b2f5899f-e1c5-4982-8af0-729a5c74444c	local	b2f5899f-e1c5-4982-8af0-729a5c74444c.jpg	01.jpg	01	image/jpeg	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 12:31:18.9+00	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-07 13:37:20.175+00	\N	172425	1280	720	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-02-07 13:37:20.172+00
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
3	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	\N	photos	\N	\N	{"tabular":{"fields":["lat","long","name","serie_id","file"],"page":1}}	{"tabular":{"widths":{"name":446,"file":427}}}	\N	\N	bookmark	\N
4	\N	9d83a681-8388-4ff9-ae4b-7038fad0560a	\N	directus_files	\N	cards	{"cards":{"sort":["-uploaded_on"],"page":2}}	{"cards":{"icon":"insert_drive_file","title":"{{ title }}","subtitle":"{{ type }} • {{ filesize }}","size":4,"imageFit":"crop"}}	\N	\N	bookmark	\N
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
1	photos	serie_id	series	\N	\N	\N	\N	\N	nullify
2	photos	file	directus_files	\N	\N	\N	\N	\N	nullify
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
63	69	directus_files	ce53eb86-ee14-4587-bbd3-0b149b70108f	{"title":"15","filename_download":"15.jpg","type":"image/jpeg","storage":"local"}	{"title":"15","filename_download":"15.jpg","type":"image/jpeg","storage":"local"}	\N	\N
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
64	70	directus_files	e405cdda-0a5e-4b68-b112-893e9ce5d0e7	{"title":"16","filename_download":"16.jpg","type":"image/jpeg","storage":"local"}	{"title":"16","filename_download":"16.jpg","type":"image/jpeg","storage":"local"}	\N	\N
41	42	photos	f4b0d799-e1ff-4506-a783-b6cab4ef0f06	{"id":"f4b0d799-e1ff-4506-a783-b6cab4ef0f06","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Crous Resto U' Cours Léopold","lat":"48.6951174888681","long":"6.17719255321255","url":"images/28.jpg","link":"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/22/01/bb/3f/voici-la-facade-du-crous.jpg?w=1200&h=-1&s=1"}	{"id":"f4b0d799-e1ff-4506-a783-b6cab4ef0f06","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Crous Resto U' Cours Léopold","lat":"48.6951174888681","long":"6.17719255321255","url":"images/28.jpg","link":"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/22/01/bb/3f/voici-la-facade-du-crous.jpg?w=1200&h=-1&s=1"}	\N	\N
42	43	photos	207178a9-c5ae-4808-bafa-8f608913b4dc	{"id":"207178a9-c5ae-4808-bafa-8f608913b4dc","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Statue équestre de Jeanne d'Arc","lat":"48.6941403391368","long":"6.1803078374452","url":"images/29.jpg","link":"https://th.bing.com/th/id/OIP.EIh8ndJen8yux0fiwlJybwHaLH?w=1200&h=1800&rs=1&pid=ImgDetMain"}	{"id":"207178a9-c5ae-4808-bafa-8f608913b4dc","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Statue équestre de Jeanne d'Arc","lat":"48.6941403391368","long":"6.1803078374452","url":"images/29.jpg","link":"https://th.bing.com/th/id/OIP.EIh8ndJen8yux0fiwlJybwHaLH?w=1200&h=1800&rs=1&pid=ImgDetMain"}	\N	\N
43	44	photos	0a5ad80f-6d33-435b-bb15-18fd65a39f68	{"id":"0a5ad80f-6d33-435b-bb15-18fd65a39f68","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"ARTEM","lat":"48.6728663484446","long":"6.17165752016288","url":"images/30.jpg","link":"https://live.staticflickr.com/65535/51217348797_7c1eb78d1b_b.jpg"}	{"id":"0a5ad80f-6d33-435b-bb15-18fd65a39f68","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"ARTEM","lat":"48.6728663484446","long":"6.17165752016288","url":"images/30.jpg","link":"https://live.staticflickr.com/65535/51217348797_7c1eb78d1b_b.jpg"}	\N	\N
44	45	photos	0a5ad80f-6d33-435b-bb15-18fd65a39f68	{"id":"0a5ad80f-6d33-435b-bb15-18fd65a39f68","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Ensic","lat":"48.699603595116","long":"6.17990889333166","url":"images/31.jpg","link":"https://th.bing.com/th/id/R.084fa9f085165b0d47e0e309c358d4cc?rik=zgQMf1MoZM4%2bqg&pid=ImgRaw&r=0"}	{"serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Ensic","lat":"48.699603595116","long":"6.17990889333166","url":"images/31.jpg","link":"https://th.bing.com/th/id/R.084fa9f085165b0d47e0e309c358d4cc?rik=zgQMf1MoZM4%2bqg&pid=ImgRaw&r=0"}	\N	\N
45	46	photos	9d062e03-eaff-4e35-b2e6-a483c5aa5ae1	{"id":"9d062e03-eaff-4e35-b2e6-a483c5aa5ae1","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Faculté des Sciences et Technologies","lat":"48.6650952083834","long":"6.16053031759351","url":"Images/32.jpg","link":"https://www.pagesjaunes.fr/media/ugc/faculte_des_sciences_et_technologies_05454700_094219295"}	{"id":"9d062e03-eaff-4e35-b2e6-a483c5aa5ae1","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Faculté des Sciences et Technologies","lat":"48.6650952083834","long":"6.16053031759351","url":"Images/32.jpg","link":"https://www.pagesjaunes.fr/media/ugc/faculte_des_sciences_et_technologies_05454700_094219295"}	\N	\N
46	50	directus_users	06e0a60d-1924-41e2-aef5-1c0526264f4c	{"id":"06e0a60d-1924-41e2-aef5-1c0526264f4c","email":"user@example.com","password":"**********"}	{"id":"06e0a60d-1924-41e2-aef5-1c0526264f4c","email":"user@example.com","password":"**********"}	\N	\N
47	51	directus_permissions	1	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"photos","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"photos","action":"read"}	\N	\N
48	52	directus_permissions	2	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"series","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"series","action":"read"}	\N	\N
49	55	directus_files	b2f5899f-e1c5-4982-8af0-729a5c74444c	{"title":"01","filename_download":"01.jpg","type":"image/jpeg","storage":"local"}	{"title":"01","filename_download":"01.jpg","type":"image/jpeg","storage":"local"}	\N	\N
50	56	directus_files	73b2e5d2-a82f-4ede-b6de-f0ef222c2d54	{"title":"02","filename_download":"02.jpg","type":"image/jpeg","storage":"local"}	{"title":"02","filename_download":"02.jpg","type":"image/jpeg","storage":"local"}	\N	\N
51	57	directus_files	62b172d1-ec04-40fe-a3a8-7fc6f17eaabf	{"title":"06","filename_download":"06.jpg","type":"image/jpeg","storage":"local"}	{"title":"06","filename_download":"06.jpg","type":"image/jpeg","storage":"local"}	\N	\N
52	58	directus_files	19c92283-f83d-48f2-87d6-e89742de1f8c	{"title":"05","filename_download":"05.jpg","type":"image/jpeg","storage":"local"}	{"title":"05","filename_download":"05.jpg","type":"image/jpeg","storage":"local"}	\N	\N
53	59	directus_files	fa3728ba-aa35-4216-a451-3017436df012	{"title":"03","filename_download":"03.jpg","type":"image/jpeg","storage":"local"}	{"title":"03","filename_download":"03.jpg","type":"image/jpeg","storage":"local"}	\N	\N
54	60	directus_files	c7e68c19-ed8c-4f0f-8706-68eac916cd76	{"title":"04","filename_download":"04.jpg","type":"image/jpeg","storage":"local"}	{"title":"04","filename_download":"04.jpg","type":"image/jpeg","storage":"local"}	\N	\N
55	61	directus_files	1ec9db0f-922f-4d4a-ae23-8586bc2e01f6	{"title":"07","filename_download":"07.jpg","type":"image/jpeg","storage":"local"}	{"title":"07","filename_download":"07.jpg","type":"image/jpeg","storage":"local"}	\N	\N
56	62	directus_files	c701ce16-8da2-4605-a7aa-b0143bdc3256	{"title":"08","filename_download":"08.jpg","type":"image/jpeg","storage":"local"}	{"title":"08","filename_download":"08.jpg","type":"image/jpeg","storage":"local"}	\N	\N
57	63	directus_files	ae8b37b2-f83e-466f-b823-dff1c55176fa	{"title":"09","filename_download":"09.jpg","type":"image/jpeg","storage":"local"}	{"title":"09","filename_download":"09.jpg","type":"image/jpeg","storage":"local"}	\N	\N
58	64	directus_files	fbb8eda1-5a1c-4001-b68c-63ea505c8cd7	{"title":"10","filename_download":"10.jpg","type":"image/jpeg","storage":"local"}	{"title":"10","filename_download":"10.jpg","type":"image/jpeg","storage":"local"}	\N	\N
59	65	directus_files	3b25d8cc-c200-4033-bd59-9dae81d9b54c	{"title":"11","filename_download":"11.jpg","type":"image/jpeg","storage":"local"}	{"title":"11","filename_download":"11.jpg","type":"image/jpeg","storage":"local"}	\N	\N
60	66	directus_files	ecee2f07-bf16-46a4-ba2b-c4bd3b564cc6	{"title":"12","filename_download":"12.jpg","type":"image/jpeg","storage":"local"}	{"title":"12","filename_download":"12.jpg","type":"image/jpeg","storage":"local"}	\N	\N
61	67	directus_files	5445a86e-1904-40bd-911f-06b82ed41b59	{"title":"13","filename_download":"13.jpg","type":"image/jpeg","storage":"local"}	{"title":"13","filename_download":"13.jpg","type":"image/jpeg","storage":"local"}	\N	\N
62	68	directus_files	8e5cc9e6-6761-47e8-af88-a64a083dd899	{"title":"14","filename_download":"14.jpg","type":"image/jpeg","storage":"local"}	{"title":"14","filename_download":"14.jpg","type":"image/jpeg","storage":"local"}	\N	\N
65	71	directus_files	dafee953-9363-4f62-881d-b9c2dbc9d191	{"title":"17","filename_download":"17.jpg","type":"image/jpeg","storage":"local"}	{"title":"17","filename_download":"17.jpg","type":"image/jpeg","storage":"local"}	\N	\N
73	79	directus_files	f5df93ea-7ba4-4f06-9242-8166091b4819	{"title":"26","filename_download":"26.jpg","type":"image/jpeg","storage":"local"}	{"title":"26","filename_download":"26.jpg","type":"image/jpeg","storage":"local"}	\N	\N
77	83	directus_files	0c1b8d40-0e84-49c4-a7f7-439e87c5df1f	{"title":"29","filename_download":"29.jpg","type":"image/jpeg","storage":"local"}	{"title":"29","filename_download":"29.jpg","type":"image/jpeg","storage":"local"}	\N	\N
66	72	directus_files	da5a49a5-5171-488d-9af5-c124b5ee5444	{"title":"18","filename_download":"18.jpg","type":"image/jpeg","storage":"local"}	{"title":"18","filename_download":"18.jpg","type":"image/jpeg","storage":"local"}	\N	\N
69	75	directus_files	bd5a6ebb-0f09-4771-9f8f-c3f58e549aca	{"title":"21","filename_download":"21.jpg","type":"image/jpeg","storage":"local"}	{"title":"21","filename_download":"21.jpg","type":"image/jpeg","storage":"local"}	\N	\N
71	77	directus_files	06447e4a-ca12-422b-989f-b9d791ac3554	{"title":"23","filename_download":"23.jpg","type":"image/jpeg","storage":"local"}	{"title":"23","filename_download":"23.jpg","type":"image/jpeg","storage":"local"}	\N	\N
67	73	directus_files	76df5f29-1826-48bd-ab36-eaf23cd03cc9	{"title":"19","filename_download":"19.jpg","type":"image/jpeg","storage":"local"}	{"title":"19","filename_download":"19.jpg","type":"image/jpeg","storage":"local"}	\N	\N
72	78	directus_files	ca4dd00c-1ac1-4917-b8bc-b82e280888e6	{"title":"24","filename_download":"24.jpg","type":"image/jpeg","storage":"local"}	{"title":"24","filename_download":"24.jpg","type":"image/jpeg","storage":"local"}	\N	\N
78	84	directus_files	a5a34488-797f-4f54-a54e-4b767e95fd39	{"title":"31","filename_download":"31.jpg","type":"image/jpeg","storage":"local"}	{"title":"31","filename_download":"31.jpg","type":"image/jpeg","storage":"local"}	\N	\N
68	74	directus_files	6915b663-fb80-40a3-9481-a7032603a171	{"title":"20","filename_download":"20.jpg","type":"image/jpeg","storage":"local"}	{"title":"20","filename_download":"20.jpg","type":"image/jpeg","storage":"local"}	\N	\N
74	80	directus_files	58cfdd05-2848-4fa3-a117-08002848576a	{"title":"25","filename_download":"25.jpg","type":"image/jpeg","storage":"local"}	{"title":"25","filename_download":"25.jpg","type":"image/jpeg","storage":"local"}	\N	\N
76	82	directus_files	0af0db58-edf1-4032-acfb-c45451930bde	{"title":"28","filename_download":"28.jpg","type":"image/jpeg","storage":"local"}	{"title":"28","filename_download":"28.jpg","type":"image/jpeg","storage":"local"}	\N	\N
70	76	directus_files	7d63f98c-76ad-4755-938b-fe88b0030bc5	{"title":"22","filename_download":"22.jpg","type":"image/jpeg","storage":"local"}	{"title":"22","filename_download":"22.jpg","type":"image/jpeg","storage":"local"}	\N	\N
75	81	directus_files	c024b671-6386-4743-9384-cb3662fb11e4	{"title":"27","filename_download":"27.jpg","type":"image/jpeg","storage":"local"}	{"title":"27","filename_download":"27.jpg","type":"image/jpeg","storage":"local"}	\N	\N
79	85	directus_files	48490935-f8aa-4e9d-a448-15ea8e162419	{"title":"30","filename_download":"30.jpg","type":"image/jpeg","storage":"local"}	{"title":"30","filename_download":"30.jpg","type":"image/jpeg","storage":"local"}	\N	\N
80	86	directus_files	bc0aa97d-6864-4b2d-b95d-d00f16cf2acc	{"title":"32","filename_download":"32.jpg","type":"image/jpeg","storage":"local"}	{"title":"32","filename_download":"32.jpg","type":"image/jpeg","storage":"local"}	\N	\N
81	88	directus_fields	11	{"sort":8,"interface":"file","special":["file"],"collection":"photos","field":"file"}	{"sort":8,"interface":"file","special":["file"],"collection":"photos","field":"file"}	\N	\N
82	89	directus_fields	4	{"id":4,"collection":"photos","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"photos","field":"id","sort":1,"group":null}	\N	\N
83	90	directus_fields	5	{"id":5,"collection":"photos","field":"serie_id","special":["m2o"],"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"photos","field":"serie_id","sort":2,"group":null}	\N	\N
84	91	directus_fields	6	{"id":6,"collection":"photos","field":"name","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"photos","field":"name","sort":3,"group":null}	\N	\N
85	92	directus_fields	7	{"id":7,"collection":"photos","field":"lat","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"photos","field":"lat","sort":4,"group":null}	\N	\N
86	93	directus_fields	8	{"id":8,"collection":"photos","field":"long","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"photos","field":"long","sort":5,"group":null}	\N	\N
87	94	directus_fields	11	{"id":11,"collection":"photos","field":"file","special":["file"],"interface":"file","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"photos","field":"file","sort":6,"group":null}	\N	\N
88	95	directus_fields	10	{"id":10,"collection":"photos","field":"link","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"photos","field":"link","sort":7,"group":null}	\N	\N
89	96	photos	55d1ecb2-82d9-445c-996b-68f7d1862432	{"id":"55d1ecb2-82d9-445c-996b-68f7d1862432","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Institut Universitaire de Technologie Nancy-Charlemagne","lat":"48.6828323658981","long":"6.16091547406893","link":"https://i.ytimg.com/vi/f3n6d4Ufk1U/maxresdefault_live.jpg","file":"b2f5899f-e1c5-4982-8af0-729a5c74444c"}	{"file":"b2f5899f-e1c5-4982-8af0-729a5c74444c"}	\N	\N
90	97	photos	00ed930e-e697-4b2a-96a4-92f84ed79aec	{"id":"00ed930e-e697-4b2a-96a4-92f84ed79aec","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Jardin Botanique Jean-Marie Pelt","lat":"48.662758","long":"6.155456","link":"https://fr.wikipedia.org/wiki/Jardin_botanique_Jean-Marie-Pelt#/media/Fichier:Jardin_botanique_Montet_1.jpg","file":"dafee953-9363-4f62-881d-b9c2dbc9d191"}	{"file":"dafee953-9363-4f62-881d-b9c2dbc9d191"}	\N	\N
91	98	photos	0a5ad80f-6d33-435b-bb15-18fd65a39f68	{"id":"0a5ad80f-6d33-435b-bb15-18fd65a39f68","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Ensic","lat":"48.699603595116","long":"6.17990889333166","link":"https://th.bing.com/th/id/R.084fa9f085165b0d47e0e309c358d4cc?rik=zgQMf1MoZM4%2bqg&pid=ImgRaw&r=0","file":"a5a34488-797f-4f54-a54e-4b767e95fd39"}	{"file":"a5a34488-797f-4f54-a54e-4b767e95fd39"}	\N	\N
92	99	photos	12b31bea-edd6-4174-8cd7-3bb38a0efbfe	{"id":"12b31bea-edd6-4174-8cd7-3bb38a0efbfe","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Faculté de Droit, Sciences Économiques et Gestion","lat":"48.6931229890256","long":"6.1766413458741","link":"https://live.staticflickr.com/65535/48864028882_580f6e3ff6_b.jpg","file":"06447e4a-ca12-422b-989f-b9d791ac3554"}	{"file":"06447e4a-ca12-422b-989f-b9d791ac3554"}	\N	\N
93	100	photos	207178a9-c5ae-4808-bafa-8f608913b4dc	{"id":"207178a9-c5ae-4808-bafa-8f608913b4dc","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Statue équestre de Jeanne d'Arc","lat":"48.6941403391368","long":"6.1803078374452","link":"https://th.bing.com/th/id/OIP.EIh8ndJen8yux0fiwlJybwHaLH?w=1200&h=1800&rs=1&pid=ImgDetMain","file":"0c1b8d40-0e84-49c4-a7f7-439e87c5df1f"}	{"file":"0c1b8d40-0e84-49c4-a7f7-439e87c5df1f"}	\N	\N
94	101	photos	211f70c8-8e04-4b97-8f84-328e8b043344	{"id":"211f70c8-8e04-4b97-8f84-328e8b043344","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Centre Commercial Saint Sébastien","lat":"48.6880087792139","long":"6.18067681830613","link":"https://media-cdn.tripadvisor.com/media/photo-s/14/af/ea/6d/centre-commercial-saint.jpg","file":"ecee2f07-bf16-46a4-ba2b-c4bd3b564cc6"}	{"file":"ecee2f07-bf16-46a4-ba2b-c4bd3b564cc6"}	\N	\N
95	102	photos	2bf6df61-3bc2-4d0b-b5d9-5ebc094c04c3	{"id":"2bf6df61-3bc2-4d0b-b5d9-5ebc094c04c3","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Église Saint-Léon de Nancy","lat":"48.6892766684842","long":"6.17207148496397","link":"https://th.bing.com/th/id/OIP.-EvWoogHdOjjQTwMAaH8zwAAAA?w=384&h=547&rs=1&pid=ImgDetMain","file":"ce53eb86-ee14-4587-bbd3-0b149b70108f"}	{"file":"ce53eb86-ee14-4587-bbd3-0b149b70108f"}	\N	\N
96	103	photos	3f616107-69e6-4586-afc3-8a73c6b86891	{"id":"3f616107-69e6-4586-afc3-8a73c6b86891","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Parc de la Cure d'Air","lat":"48.6933896583972","long":"6.15995144259252","link":"https://api.cloudly.space/resize/crop/1200/627/60/aHR0cHM6Ly93d3cuc2l0bG9yLmZyL3Bob3Rvcy83MzcvNzM3MDAwMjcxXzQuanBnPzIwMjEtMTItMjFUMTE6Mzk6NDha/image.jpg","file":"3b25d8cc-c200-4033-bd59-9dae81d9b54c"}	{"file":"3b25d8cc-c200-4033-bd59-9dae81d9b54c"}	\N	\N
97	104	photos	41874312-d6a0-48e3-b16c-1be8e7cf9d44	{"id":"41874312-d6a0-48e3-b16c-1be8e7cf9d44","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Porte de la Craffe","lat":"48.6988659264728","long":"6.17779765611324","link":"https://i.pinimg.com/originals/ca/dd/5a/cadd5a34c4f64319dbb15b576d1e7369.jpg","file":"6915b663-fb80-40a3-9481-a7032603a171"}	{"file":"6915b663-fb80-40a3-9481-a7032603a171"}	\N	\N
98	105	photos	4d6c147e-2cdd-47a8-962a-5a8754f0a0fb	{"id":"4d6c147e-2cdd-47a8-962a-5a8754f0a0fb","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Musée des Beaux-Arts de Nancy","lat":"48.6934244497898","long":"6.18235708015418","link":"https://th.bing.com/th/id/R.ffa2da458031ec0d61c7aa59d49bb506?rik=73eXDK5WOPvL4A&pid=ImgRaw&r=0","file":"73b2e5d2-a82f-4ede-b6de-f0ef222c2d54"}	{"file":"73b2e5d2-a82f-4ede-b6de-f0ef222c2d54"}	\N	\N
99	106	photos	588f48b7-3d1e-4ceb-bdfe-bfb43e7d09ca	{"id":"588f48b7-3d1e-4ceb-bdfe-bfb43e7d09ca","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Tour de la Commanderie Nazet-Moutaux","lat":"48.6865659854259","long":"6.16735481677689","link":"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/24/1c/a5/8f/up-some-steps.jpg?w=1200&h=-1&s=1","file":"bd5a6ebb-0f09-4771-9f8f-c3f58e549aca"}	{"file":"bd5a6ebb-0f09-4771-9f8f-c3f58e549aca"}	\N	\N
100	107	photos	5c6dc88e-be57-4e8e-8789-fda2d396cec5	{"id":"5c6dc88e-be57-4e8e-8789-fda2d396cec5","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Nancy Thermal","lat":"48.6791632317088","long":"6.16872369208436","link":"https://th.bing.com/th/id/R.98072a4bf1a9d532bdb8f0081a6f6118?rik=uARF5UMHDtuiig&riu=http%3a%2f%2fdha.eu%2fwp-content%2fuploads%2f2018%2f10%2f05.106.38.jpg&ehk=F93hYCSX%2f%2fbwFxNS78lk5VvilbZluJcchdrp9C2szMU%3d&risl=&pid=ImgRaw&r=0","file":"e405cdda-0a5e-4b68-b112-893e9ce5d0e7"}	{"file":"e405cdda-0a5e-4b68-b112-893e9ce5d0e7"}	\N	\N
101	108	photos	6a6a491c-a6a7-4e76-b2f3-3e0f337a3fd3	{"id":"6a6a491c-a6a7-4e76-b2f3-3e0f337a3fd3","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Porte Désilles","lat":"48.6979582620096","long":"6.174147932838","link":"https://media-cdn.tripadvisor.com/media/photo-s/14/af/43/c3/porte-desilles.jpg","file":"19c92283-f83d-48f2-87d6-e89742de1f8c"}	{"file":"19c92283-f83d-48f2-87d6-e89742de1f8c"}	\N	\N
102	109	photos	781d1eeb-b809-4186-bc0b-7b90127f9e68	{"id":"781d1eeb-b809-4186-bc0b-7b90127f9e68","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"IUT Nancy-Brabois","lat":"48.6588705423001","long":"6.15140298760477","link":"https://iut-nancy-brabois.univ-lorraine.fr/files/2023/09/iutnb-campus-luneville-1536x1024.jpg","file":"f5df93ea-7ba4-4f06-9242-8166091b4819"}	{"file":"f5df93ea-7ba4-4f06-9242-8166091b4819"}	\N	\N
103	110	photos	788af01e-36c3-4805-872c-c007c7758624	{"id":"788af01e-36c3-4805-872c-c007c7758624","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Stade Marcel Picot","lat":"48.6954249246343","long":"6.21053652030365","link":"https://th.bing.com/th/id/R.5228ad9f481c3985cc289b82e7ee9669?rik=AGJxuyX3ya272A&riu=http%3a%2f%2fwww.ostadium.com%2fgalleries%2fstade-marcel-picot-vue-aerienne-illus.jpg&ehk=s5JHg2RJq625D3pzyEzQoJquUrRUZ4HKasOuMOXKW%2f0%3d&risl=&pid=ImgRaw&r=0&sres=1&sres","file":"ca4dd00c-1ac1-4917-b8bc-b82e280888e6"}	{"file":"ca4dd00c-1ac1-4917-b8bc-b82e280888e6"}	\N	\N
104	111	photos	82fc87f1-453a-4e54-9e37-b216aeb1af9c	{"id":"82fc87f1-453a-4e54-9e37-b216aeb1af9c","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Muséum-Aquarium de Nancy","lat":"48.6949427895482","long":"6.18820822723179","link":"https://www.archi-wiki.org/images/thumb/9/91/34_rue_Sainte_Catherine_(entr%C3%A9e)_DSC04646.jpg/1200px-34_rue_Sainte_Catherine_(entr%C3%A9e)_DSC04646.jpg","file":"c7e68c19-ed8c-4f0f-8706-68eac916cd76"}	{"file":"c7e68c19-ed8c-4f0f-8706-68eac916cd76"}	\N	\N
105	112	photos	93b2408f-eb3a-492f-98f1-fd71c7f702e1	{"id":"93b2408f-eb3a-492f-98f1-fd71c7f702e1","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Place Stanislas","lat":"48.6935915205383","long":"6.18325640787205","link":"https://i0.wp.com/viajealpatrimonio.com/wp-content/uploads/2020/05/0787-plaza-stanislas-plaza-de-la-carriere-y-plaza-de-la-alliance-en-nancy.jpg?ssl=1","file":"fa3728ba-aa35-4216-a451-3017436df012"}	{"file":"fa3728ba-aa35-4216-a451-3017436df012"}	\N	\N
106	113	photos	94d5df24-03eb-4e4d-87ca-a4fce91d8c34	{"id":"94d5df24-03eb-4e4d-87ca-a4fce91d8c34","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Gare de Nancy","lat":"48.6897919909649","long":"6.17440457810537","link":"https://s3-media4.fl.yelpcdn.com/bphoto/fXtPxdpgpHr9RHB-Je-L6Q/o.jpg","file":"5445a86e-1904-40bd-911f-06b82ed41b59"}	{"file":"5445a86e-1904-40bd-911f-06b82ed41b59"}	\N	\N
107	114	photos	969b7872-14f8-4f2a-8b13-4905d0dc088e	{"id":"969b7872-14f8-4f2a-8b13-4905d0dc088e","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Place de la Carrière","lat":"48.6954725331034","long":"6.18193781254074","link":"https://api.cloudly.space/resize/crop/1200/627/60/aHR0cHM6Ly93d3cuc2l0bG9yLmZyL3Bob3Rvcy83MzcvcGxhY2VfZGVfbGFfY2FycmllcmUuanBnPzIwMjEtMDYtMjJUMTU6NDI6MjJa/image.jpg","file":"1ec9db0f-922f-4d4a-ae23-8586bc2e01f6"}	{"file":"1ec9db0f-922f-4d4a-ae23-8586bc2e01f6"}	\N	\N
108	115	photos	9d062e03-eaff-4e35-b2e6-a483c5aa5ae1	{"id":"9d062e03-eaff-4e35-b2e6-a483c5aa5ae1","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Faculté des Sciences et Technologies","lat":"48.6650952083834","long":"6.16053031759351","link":"https://www.pagesjaunes.fr/media/ugc/faculte_des_sciences_et_technologies_05454700_094219295","file":"bc0aa97d-6864-4b2d-b95d-d00f16cf2acc"}	{"file":"bc0aa97d-6864-4b2d-b95d-d00f16cf2acc"}	\N	\N
109	116	photos	a3e4f064-84f4-402f-a9e6-9b00ce361c50	{"id":"a3e4f064-84f4-402f-a9e6-9b00ce361c50","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Plage de la Méchelle","lat":"48.6922610233877","long":"6.20239706106462","link":"https://cdn-s-www.estrepublicain.fr/images/B641AA78-4B8E-4544-9AF6-196687C4E853/NW_raw/le-nouveau-site-de-la-mechelle-a-connu-une-frequentation-contrastee-entre-jours-pluvieux-et-temps-plus-estival-photo-er-cedric-jacquot-1629912614.jpg","file":"da5a49a5-5171-488d-9af5-c124b5ee5444"}	{"file":"da5a49a5-5171-488d-9af5-c124b5ee5444"}	\N	\N
110	117	photos	a74fb23e-1ba0-4ac0-8391-dad8b06b81d9	{"id":"a74fb23e-1ba0-4ac0-8391-dad8b06b81d9","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Basilique du Sacré-Cœur de Nancy","lat":"48.6855496603864","long":"6.16246257435614","link":"https://th.bing.com/th/id/R.5ff55d576be674cdbb45aecd98a3faed?rik=JlZd9fGH6KJUJA&riu=http%3a%2f%2fphotos.wikimapia.org%2fp%2f00%2f01%2f68%2f26%2f37_big.jpg&ehk=U7mJ1UYZw%2bsFL31cbbDb5PnjnqP8Ca%2b3kjaR8Tpx5Hg%3d&risl=&pid=ImgRaw&r=0","file":"8e5cc9e6-6761-47e8-af88-a64a083dd899"}	{"file":"8e5cc9e6-6761-47e8-af88-a64a083dd899"}	\N	\N
111	118	photos	bcfbcf15-b835-4008-83d7-2ff935a6e918	{"id":"bcfbcf15-b835-4008-83d7-2ff935a6e918","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Musée de l'École de Nancy","lat":"48.6805236575265","long":"6.16617418668594","link":"https://fr.wikipedia.org/wiki/Mus%C3%A9e_de_l%27%C3%89cole_de_Nancy#/media/Fichier:Mus%C3%A9e_%C3%A9cole_Nancy.jpg","file":"c024b671-6386-4743-9384-cb3662fb11e4"}	{"file":"c024b671-6386-4743-9384-cb3662fb11e4"}	\N	\N
112	119	photos	bdf9f03d-962f-43c2-b89f-65e8e6cfbf41	{"id":"bdf9f03d-962f-43c2-b89f-65e8e6cfbf41","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Campus Lettres et Sciences Humaines de Nancy - Université de Lorraine","lat":"48.6955810198057","long":"6.16599935776565","link":"https://cdn-s-www.estrepublicain.fr/images/5ED2BEB3-6BEB-4C0B-8797-28AF345C4C4B/NW_raw/title-1607632070.jpg","file":"7d63f98c-76ad-4755-938b-fe88b0030bc5"}	{"file":"7d63f98c-76ad-4755-938b-fe88b0030bc5"}	\N	\N
113	120	photos	c05787a9-0e6f-4502-a932-ee5881addc7b	{"id":"c05787a9-0e6f-4502-a932-ee5881addc7b","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Musée Lorrain","lat":"48.6973116730877","long":"6.17934775730296","link":"https://media-cdn.tripadvisor.com/media/photo-s/1a/aa/52/81/portale.jpg","file":"76df5f29-1826-48bd-ab36-eaf23cd03cc9"}	{"file":"76df5f29-1826-48bd-ab36-eaf23cd03cc9"}	\N	\N
114	121	photos	cb8b71b4-7989-4b6c-a68d-182ec0475648	{"id":"cb8b71b4-7989-4b6c-a68d-182ec0475648","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Villa Majorelle","lat":"48.6855117761987","long":"6.16386613003089","link":"https://th.bing.com/th/id/OIP.8RzG0_gbx6N2P59VpOXSagHaEk?rs=1&pid=ImgDetMain","file":"ae8b37b2-f83e-466f-b823-dff1c55176fa"}	{"file":"ae8b37b2-f83e-466f-b823-dff1c55176fa"}	\N	\N
115	122	photos	d1ad5874-64df-40c8-8639-6728e614298d	{"id":"d1ad5874-64df-40c8-8639-6728e614298d","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Parc de la Pépinière","lat":"48.6977712521057","long":"6.18460627665755","link":"https://frenchmoments.eu/wp-content/uploads/2012/11/Parc-de-la-P%C3%A9pini%C3%A8re-04-Nancy-%C2%A9-French-Moments.jpg","file":"fbb8eda1-5a1c-4001-b68c-63ea505c8cd7"}	{"file":"fbb8eda1-5a1c-4001-b68c-63ea505c8cd7"}	\N	\N
116	123	photos	ecc7ba07-95d1-4671-acd1-d975a676bed9	{"id":"ecc7ba07-95d1-4671-acd1-d975a676bed9","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Basilique Saint-Epvre","lat":"48.695994903589","long":"6.17991735334421","link":"https://th.bing.com/th/id/R.f3da826715a8428a23f9421319e04d3c?rik=yEjlpTxxd%2beorA&riu=http%3a%2f%2flusile17.l.u.pic.centerblog.net%2fo%2fc8b40538.jpg&ehk=FKlylTb%2ffOKWDvalqpX5FQN4vXQqlBR79zBcaLfSBqQ%3d&risl=&pid=ImgRaw&r=0","file":"c701ce16-8da2-4605-a7aa-b0143bdc3256"}	{"file":"c701ce16-8da2-4605-a7aa-b0143bdc3256"}	\N	\N
117	124	photos	f13c4c48-503b-4131-9856-77137afab803	{"id":"f13c4c48-503b-4131-9856-77137afab803","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Cathédrale Notre-Dame-de-l'Annonciation","lat":"48.6915229374518","long":"6.1858817407413","link":"https://live.staticflickr.com/3164/3098725110_0f37479776_b.jpg","file":"62b172d1-ec04-40fe-a3a8-7fc6f17eaabf"}	{"file":"62b172d1-ec04-40fe-a3a8-7fc6f17eaabf"}	\N	\N
118	125	photos	f4b0d799-e1ff-4506-a783-b6cab4ef0f06	{"id":"f4b0d799-e1ff-4506-a783-b6cab4ef0f06","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Crous Resto U' Cours Léopold","lat":"48.6951174888681","long":"6.17719255321255","link":"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/22/01/bb/3f/voici-la-facade-du-crous.jpg?w=1200&h=-1&s=1","file":"0af0db58-edf1-4032-acfb-c45451930bde"}	{"file":"0af0db58-edf1-4032-acfb-c45451930bde"}	\N	\N
119	127	directus_files	58cfdd05-2848-4fa3-a117-08002848576a	{"id":"58cfdd05-2848-4fa3-a117-08002848576a","storage":"local","filename_disk":"58cfdd05-2848-4fa3-a117-08002848576a.jpg","filename_download":"25.jpg","title":"25","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.424Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:25:47.024Z","charset":null,"filesize":"1401633","width":2500,"height":1830,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.572Z"}	{"storage":"local","filename_disk":"58cfdd05-2848-4fa3-a117-08002848576a.jpg","filename_download":"25.jpg","title":"25","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:25:47.024Z"}	\N	\N
120	128	directus_files	58cfdd05-2848-4fa3-a117-08002848576a	{"id":"58cfdd05-2848-4fa3-a117-08002848576a","storage":"local","filename_disk":"58cfdd05-2848-4fa3-a117-08002848576a.jpg","filename_download":"25.jpg","title":"25","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.424Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:25:47.048Z","charset":null,"filesize":"1401633","width":2500,"height":1830,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:25:47.045Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:25:47.048Z"}	\N	\N
121	129	directus_files	48490935-f8aa-4e9d-a448-15ea8e162419	{"id":"48490935-f8aa-4e9d-a448-15ea8e162419","storage":"local","filename_disk":"48490935-f8aa-4e9d-a448-15ea8e162419.jpg","filename_download":"30.jpg","title":"30","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.528Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:26:05.470Z","charset":null,"filesize":"320698","width":1024,"height":682,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.554Z"}	{"storage":"local","filename_disk":"48490935-f8aa-4e9d-a448-15ea8e162419.jpg","filename_download":"30.jpg","title":"30","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:26:05.470Z"}	\N	\N
122	130	directus_files	48490935-f8aa-4e9d-a448-15ea8e162419	{"id":"48490935-f8aa-4e9d-a448-15ea8e162419","storage":"local","filename_disk":"48490935-f8aa-4e9d-a448-15ea8e162419.jpg","filename_download":"30.jpg","title":"30","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.528Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:26:05.490Z","charset":null,"filesize":"320698","width":1024,"height":682,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:26:05.487Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:26:05.490Z"}	\N	\N
123	131	directus_files	c024b671-6386-4743-9384-cb3662fb11e4	{"id":"c024b671-6386-4743-9384-cb3662fb11e4","storage":"local","filename_disk":"c024b671-6386-4743-9384-cb3662fb11e4.jpg","filename_download":"27.jpg","title":"27","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.452Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:26:15.391Z","charset":null,"filesize":"899393","width":1920,"height":1280,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.554Z"}	{"storage":"local","filename_disk":"c024b671-6386-4743-9384-cb3662fb11e4.jpg","filename_download":"27.jpg","title":"27","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:26:15.391Z"}	\N	\N
124	132	directus_files	c024b671-6386-4743-9384-cb3662fb11e4	{"id":"c024b671-6386-4743-9384-cb3662fb11e4","storage":"local","filename_disk":"c024b671-6386-4743-9384-cb3662fb11e4.jpg","filename_download":"27.jpg","title":"27","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.452Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:26:15.408Z","charset":null,"filesize":"899393","width":1920,"height":1280,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:26:15.406Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:26:15.408Z"}	\N	\N
125	133	directus_files	a5a34488-797f-4f54-a54e-4b767e95fd39	{"id":"a5a34488-797f-4f54-a54e-4b767e95fd39","storage":"local","filename_disk":"a5a34488-797f-4f54-a54e-4b767e95fd39.jpg","filename_download":"31.jpg","title":"31","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.527Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:26:22.784Z","charset":null,"filesize":"152692","width":600,"height":400,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.547Z"}	{"storage":"local","filename_disk":"a5a34488-797f-4f54-a54e-4b767e95fd39.jpg","filename_download":"31.jpg","title":"31","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:26:22.784Z"}	\N	\N
126	134	directus_files	a5a34488-797f-4f54-a54e-4b767e95fd39	{"id":"a5a34488-797f-4f54-a54e-4b767e95fd39","storage":"local","filename_disk":"a5a34488-797f-4f54-a54e-4b767e95fd39.jpg","filename_download":"31.jpg","title":"31","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.527Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:26:22.800Z","charset":null,"filesize":"152692","width":600,"height":400,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:26:22.797Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:26:22.800Z"}	\N	\N
127	135	directus_files	0c1b8d40-0e84-49c4-a7f7-439e87c5df1f	{"id":"0c1b8d40-0e84-49c4-a7f7-439e87c5df1f","storage":"local","filename_disk":"0c1b8d40-0e84-49c4-a7f7-439e87c5df1f.jpg","filename_download":"29.jpg","title":"29","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.524Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:26:31.740Z","charset":null,"filesize":"294973","width":1200,"height":1800,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.547Z"}	{"storage":"local","filename_disk":"0c1b8d40-0e84-49c4-a7f7-439e87c5df1f.jpg","filename_download":"29.jpg","title":"29","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:26:31.740Z"}	\N	\N
128	136	directus_files	0c1b8d40-0e84-49c4-a7f7-439e87c5df1f	{"id":"0c1b8d40-0e84-49c4-a7f7-439e87c5df1f","storage":"local","filename_disk":"0c1b8d40-0e84-49c4-a7f7-439e87c5df1f.jpg","filename_download":"29.jpg","title":"29","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.524Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:26:31.758Z","charset":null,"filesize":"294973","width":1200,"height":1800,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:26:31.755Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:26:31.758Z"}	\N	\N
129	137	directus_files	0af0db58-edf1-4032-acfb-c45451930bde	{"id":"0af0db58-edf1-4032-acfb-c45451930bde","storage":"local","filename_disk":"0af0db58-edf1-4032-acfb-c45451930bde.jpg","filename_download":"28.jpg","title":"28","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.498Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:26:39.476Z","charset":null,"filesize":"134793","width":1200,"height":526,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.541Z"}	{"storage":"local","filename_disk":"0af0db58-edf1-4032-acfb-c45451930bde.jpg","filename_download":"28.jpg","title":"28","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:26:39.476Z"}	\N	\N
130	138	directus_files	0af0db58-edf1-4032-acfb-c45451930bde	{"id":"0af0db58-edf1-4032-acfb-c45451930bde","storage":"local","filename_disk":"0af0db58-edf1-4032-acfb-c45451930bde.jpg","filename_download":"28.jpg","title":"28","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.498Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:26:39.491Z","charset":null,"filesize":"134793","width":1200,"height":526,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:26:39.488Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:26:39.491Z"}	\N	\N
131	139	directus_files	f5df93ea-7ba4-4f06-9242-8166091b4819	{"id":"f5df93ea-7ba4-4f06-9242-8166091b4819","storage":"local","filename_disk":"f5df93ea-7ba4-4f06-9242-8166091b4819.jpg","filename_download":"26.jpg","title":"26","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.428Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:28:52.539Z","charset":null,"filesize":"196572","width":1536,"height":1024,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.463Z"}	{"storage":"local","filename_disk":"f5df93ea-7ba4-4f06-9242-8166091b4819.jpg","filename_download":"26.jpg","title":"26","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:28:52.539Z"}	\N	\N
132	140	directus_files	f5df93ea-7ba4-4f06-9242-8166091b4819	{"id":"f5df93ea-7ba4-4f06-9242-8166091b4819","storage":"local","filename_disk":"f5df93ea-7ba4-4f06-9242-8166091b4819.jpg","filename_download":"26.jpg","title":"26","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.428Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:28:52.555Z","charset":null,"filesize":"196572","width":1536,"height":1024,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:28:52.552Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:28:52.555Z"}	\N	\N
133	141	directus_files	7d63f98c-76ad-4755-938b-fe88b0030bc5	{"id":"7d63f98c-76ad-4755-938b-fe88b0030bc5","storage":"local","filename_disk":"7d63f98c-76ad-4755-938b-fe88b0030bc5.jpg","filename_download":"22.jpg","title":"22","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.379Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:02.798Z","charset":null,"filesize":"344500","width":1600,"height":1065,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.459Z"}	{"storage":"local","filename_disk":"7d63f98c-76ad-4755-938b-fe88b0030bc5.jpg","filename_download":"22.jpg","title":"22","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:02.798Z"}	\N	\N
134	142	directus_files	7d63f98c-76ad-4755-938b-fe88b0030bc5	{"id":"7d63f98c-76ad-4755-938b-fe88b0030bc5","storage":"local","filename_disk":"7d63f98c-76ad-4755-938b-fe88b0030bc5.jpg","filename_download":"22.jpg","title":"22","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.379Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:02.813Z","charset":null,"filesize":"344500","width":1600,"height":1065,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:29:02.810Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:02.813Z"}	\N	\N
135	143	directus_files	06447e4a-ca12-422b-989f-b9d791ac3554	{"id":"06447e4a-ca12-422b-989f-b9d791ac3554","storage":"local","filename_disk":"06447e4a-ca12-422b-989f-b9d791ac3554.jpg","filename_download":"23.jpg","title":"23","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.409Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:10.487Z","charset":null,"filesize":"199023","width":1024,"height":683,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{"ifd0":{"Make":"NIKON CORPORATION","Model":"NIKON D750"},"exif":{"ExposureTime":0.0025,"FocalLength":24,"ISOSpeedRatings":250}},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.458Z"}	{"storage":"local","filename_disk":"06447e4a-ca12-422b-989f-b9d791ac3554.jpg","filename_download":"23.jpg","title":"23","type":"image/jpeg","folder":null,"description":null,"metadata":{"ifd0":{"Make":"NIKON CORPORATION","Model":"NIKON D750"},"exif":{"ExposureTime":0.0025,"FocalLength":24,"ISOSpeedRatings":250}},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:10.487Z"}	\N	\N
136	144	directus_files	06447e4a-ca12-422b-989f-b9d791ac3554	{"id":"06447e4a-ca12-422b-989f-b9d791ac3554","storage":"local","filename_disk":"06447e4a-ca12-422b-989f-b9d791ac3554.jpg","filename_download":"23.jpg","title":"23","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.409Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:10.504Z","charset":null,"filesize":"199023","width":1024,"height":683,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{"ifd0":{"Make":"NIKON CORPORATION","Model":"NIKON D750"},"exif":{"ExposureTime":0.0025,"FocalLength":24,"ISOSpeedRatings":250}},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:29:10.501Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:10.504Z"}	\N	\N
137	145	directus_files	ca4dd00c-1ac1-4917-b8bc-b82e280888e6	{"id":"ca4dd00c-1ac1-4917-b8bc-b82e280888e6","storage":"local","filename_disk":"ca4dd00c-1ac1-4917-b8bc-b82e280888e6.jpg","filename_download":"24.jpg","title":"24","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.413Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:17.496Z","charset":null,"filesize":"109119","width":750,"height":386,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.453Z"}	{"storage":"local","filename_disk":"ca4dd00c-1ac1-4917-b8bc-b82e280888e6.jpg","filename_download":"24.jpg","title":"24","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:17.496Z"}	\N	\N
138	146	directus_files	ca4dd00c-1ac1-4917-b8bc-b82e280888e6	{"id":"ca4dd00c-1ac1-4917-b8bc-b82e280888e6","storage":"local","filename_disk":"ca4dd00c-1ac1-4917-b8bc-b82e280888e6.jpg","filename_download":"24.jpg","title":"24","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.413Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:17.512Z","charset":null,"filesize":"109119","width":750,"height":386,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:29:17.510Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:17.512Z"}	\N	\N
139	147	directus_files	bd5a6ebb-0f09-4771-9f8f-c3f58e549aca	{"id":"bd5a6ebb-0f09-4771-9f8f-c3f58e549aca","storage":"local","filename_disk":"bd5a6ebb-0f09-4771-9f8f-c3f58e549aca.jpg","filename_download":"21.jpg","title":"21","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.322Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:24.192Z","charset":null,"filesize":"338311","width":1200,"height":1498,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.412Z"}	{"storage":"local","filename_disk":"bd5a6ebb-0f09-4771-9f8f-c3f58e549aca.jpg","filename_download":"21.jpg","title":"21","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:24.192Z"}	\N	\N
140	148	directus_files	bd5a6ebb-0f09-4771-9f8f-c3f58e549aca	{"id":"bd5a6ebb-0f09-4771-9f8f-c3f58e549aca","storage":"local","filename_disk":"bd5a6ebb-0f09-4771-9f8f-c3f58e549aca.jpg","filename_download":"21.jpg","title":"21","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.322Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:24.207Z","charset":null,"filesize":"338311","width":1200,"height":1498,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:29:24.205Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:24.207Z"}	\N	\N
141	149	directus_files	da5a49a5-5171-488d-9af5-c124b5ee5444	{"id":"da5a49a5-5171-488d-9af5-c124b5ee5444","storage":"local","filename_disk":"da5a49a5-5171-488d-9af5-c124b5ee5444.jpg","filename_download":"18.jpg","title":"18","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.268Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:31.763Z","charset":null,"filesize":"574786","width":1600,"height":1065,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.359Z"}	{"storage":"local","filename_disk":"da5a49a5-5171-488d-9af5-c124b5ee5444.jpg","filename_download":"18.jpg","title":"18","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:31.763Z"}	\N	\N
142	150	directus_files	da5a49a5-5171-488d-9af5-c124b5ee5444	{"id":"da5a49a5-5171-488d-9af5-c124b5ee5444","storage":"local","filename_disk":"da5a49a5-5171-488d-9af5-c124b5ee5444.jpg","filename_download":"18.jpg","title":"18","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.268Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:31.781Z","charset":null,"filesize":"574786","width":1600,"height":1065,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:29:31.778Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:31.781Z"}	\N	\N
143	151	directus_files	6915b663-fb80-40a3-9481-a7032603a171	{"id":"6915b663-fb80-40a3-9481-a7032603a171","storage":"local","filename_disk":"6915b663-fb80-40a3-9481-a7032603a171.jpg","filename_download":"20.jpg","title":"20","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.303Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:38.650Z","charset":null,"filesize":"167399","width":680,"height":1024,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.352Z"}	{"storage":"local","filename_disk":"6915b663-fb80-40a3-9481-a7032603a171.jpg","filename_download":"20.jpg","title":"20","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:38.650Z"}	\N	\N
144	152	directus_files	6915b663-fb80-40a3-9481-a7032603a171	{"id":"6915b663-fb80-40a3-9481-a7032603a171","storage":"local","filename_disk":"6915b663-fb80-40a3-9481-a7032603a171.jpg","filename_download":"20.jpg","title":"20","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.303Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:38.666Z","charset":null,"filesize":"167399","width":680,"height":1024,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:29:38.663Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:38.666Z"}	\N	\N
151	159	directus_files	ce53eb86-ee14-4587-bbd3-0b149b70108f	{"id":"ce53eb86-ee14-4587-bbd3-0b149b70108f","storage":"local","filename_disk":"ce53eb86-ee14-4587-bbd3-0b149b70108f.jpg","filename_download":"15.jpg","title":"15","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.198Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:30:09.340Z","charset":null,"filesize":"32909","width":384,"height":547,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.247Z"}	{"storage":"local","filename_disk":"ce53eb86-ee14-4587-bbd3-0b149b70108f.jpg","filename_download":"15.jpg","title":"15","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:30:09.340Z"}	\N	\N
152	160	directus_files	ce53eb86-ee14-4587-bbd3-0b149b70108f	{"id":"ce53eb86-ee14-4587-bbd3-0b149b70108f","storage":"local","filename_disk":"ce53eb86-ee14-4587-bbd3-0b149b70108f.jpg","filename_download":"15.jpg","title":"15","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.198Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:30:09.350Z","charset":null,"filesize":"32909","width":384,"height":547,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:30:09.347Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:30:09.350Z"}	\N	\N
145	153	directus_files	e405cdda-0a5e-4b68-b112-893e9ce5d0e7	{"id":"e405cdda-0a5e-4b68-b112-893e9ce5d0e7","storage":"local","filename_disk":"e405cdda-0a5e-4b68-b112-893e9ce5d0e7.jpg","filename_download":"16.jpg","title":"16","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.233Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:46.676Z","charset":null,"filesize":"651015","width":2000,"height":1128,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.350Z"}	{"storage":"local","filename_disk":"e405cdda-0a5e-4b68-b112-893e9ce5d0e7.jpg","filename_download":"16.jpg","title":"16","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:46.676Z"}	\N	\N
146	154	directus_files	e405cdda-0a5e-4b68-b112-893e9ce5d0e7	{"id":"e405cdda-0a5e-4b68-b112-893e9ce5d0e7","storage":"local","filename_disk":"e405cdda-0a5e-4b68-b112-893e9ce5d0e7.jpg","filename_download":"16.jpg","title":"16","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.233Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:46.691Z","charset":null,"filesize":"651015","width":2000,"height":1128,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:29:46.688Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:46.691Z"}	\N	\N
149	157	directus_files	76df5f29-1826-48bd-ab36-eaf23cd03cc9	{"id":"76df5f29-1826-48bd-ab36-eaf23cd03cc9","storage":"local","filename_disk":"76df5f29-1826-48bd-ab36-eaf23cd03cc9.jpg","filename_download":"19.jpg","title":"19","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.288Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:30:01.410Z","charset":null,"filesize":"31073","width":253,"height":450,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.337Z"}	{"storage":"local","filename_disk":"76df5f29-1826-48bd-ab36-eaf23cd03cc9.jpg","filename_download":"19.jpg","title":"19","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:30:01.410Z"}	\N	\N
150	158	directus_files	76df5f29-1826-48bd-ab36-eaf23cd03cc9	{"id":"76df5f29-1826-48bd-ab36-eaf23cd03cc9","storage":"local","filename_disk":"76df5f29-1826-48bd-ab36-eaf23cd03cc9.jpg","filename_download":"19.jpg","title":"19","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.288Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:30:01.425Z","charset":null,"filesize":"31073","width":253,"height":450,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:30:01.422Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:30:01.425Z"}	\N	\N
153	161	directus_files	8e5cc9e6-6761-47e8-af88-a64a083dd899	{"id":"8e5cc9e6-6761-47e8-af88-a64a083dd899","storage":"local","filename_disk":"8e5cc9e6-6761-47e8-af88-a64a083dd899.jpg","filename_download":"14.jpg","title":"14","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.186Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:30:16.013Z","charset":null,"filesize":"48274","width":422,"height":600,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.247Z"}	{"storage":"local","filename_disk":"8e5cc9e6-6761-47e8-af88-a64a083dd899.jpg","filename_download":"14.jpg","title":"14","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:30:16.013Z"}	\N	\N
154	162	directus_files	8e5cc9e6-6761-47e8-af88-a64a083dd899	{"id":"8e5cc9e6-6761-47e8-af88-a64a083dd899","storage":"local","filename_disk":"8e5cc9e6-6761-47e8-af88-a64a083dd899.jpg","filename_download":"14.jpg","title":"14","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.186Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:30:16.027Z","charset":null,"filesize":"48274","width":422,"height":600,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:30:16.025Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:30:16.027Z"}	\N	\N
147	155	directus_files	dafee953-9363-4f62-881d-b9c2dbc9d191	{"id":"dafee953-9363-4f62-881d-b9c2dbc9d191","storage":"local","filename_disk":"dafee953-9363-4f62-881d-b9c2dbc9d191.jpg","filename_download":"17.jpg","title":"17","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.258Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:53.880Z","charset":null,"filesize":"514335","width":1920,"height":1301,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.347Z"}	{"storage":"local","filename_disk":"dafee953-9363-4f62-881d-b9c2dbc9d191.jpg","filename_download":"17.jpg","title":"17","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:53.880Z"}	\N	\N
148	156	directus_files	dafee953-9363-4f62-881d-b9c2dbc9d191	{"id":"dafee953-9363-4f62-881d-b9c2dbc9d191","storage":"local","filename_disk":"dafee953-9363-4f62-881d-b9c2dbc9d191.jpg","filename_download":"17.jpg","title":"17","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.258Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:53.895Z","charset":null,"filesize":"514335","width":1920,"height":1301,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:29:53.893Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:29:53.895Z"}	\N	\N
155	163	directus_files	5445a86e-1904-40bd-911f-06b82ed41b59	{"id":"5445a86e-1904-40bd-911f-06b82ed41b59","storage":"local","filename_disk":"5445a86e-1904-40bd-911f-06b82ed41b59.jpg","filename_download":"13.jpg","title":"13","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.180Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:09.511Z","charset":null,"filesize":"150173","width":1000,"height":750,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.231Z"}	{"storage":"local","filename_disk":"5445a86e-1904-40bd-911f-06b82ed41b59.jpg","filename_download":"13.jpg","title":"13","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:09.511Z"}	\N	\N
156	164	directus_files	5445a86e-1904-40bd-911f-06b82ed41b59	{"id":"5445a86e-1904-40bd-911f-06b82ed41b59","storage":"local","filename_disk":"5445a86e-1904-40bd-911f-06b82ed41b59.jpg","filename_download":"13.jpg","title":"13","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.180Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:09.527Z","charset":null,"filesize":"150173","width":1000,"height":750,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:33:09.525Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:09.527Z"}	\N	\N
157	165	directus_files	ecee2f07-bf16-46a4-ba2b-c4bd3b564cc6	{"id":"ecee2f07-bf16-46a4-ba2b-c4bd3b564cc6","storage":"local","filename_disk":"ecee2f07-bf16-46a4-ba2b-c4bd3b564cc6.jpg","filename_download":"12.jpg","title":"12","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.154Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:16.269Z","charset":null,"filesize":"50963","width":550,"height":342,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.206Z"}	{"storage":"local","filename_disk":"ecee2f07-bf16-46a4-ba2b-c4bd3b564cc6.jpg","filename_download":"12.jpg","title":"12","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:16.269Z"}	\N	\N
158	166	directus_files	ecee2f07-bf16-46a4-ba2b-c4bd3b564cc6	{"id":"ecee2f07-bf16-46a4-ba2b-c4bd3b564cc6","storage":"local","filename_disk":"ecee2f07-bf16-46a4-ba2b-c4bd3b564cc6.jpg","filename_download":"12.jpg","title":"12","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.154Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:16.284Z","charset":null,"filesize":"50963","width":550,"height":342,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:33:16.282Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:16.284Z"}	\N	\N
159	167	directus_files	fbb8eda1-5a1c-4001-b68c-63ea505c8cd7	{"id":"fbb8eda1-5a1c-4001-b68c-63ea505c8cd7","storage":"local","filename_disk":"fbb8eda1-5a1c-4001-b68c-63ea505c8cd7.jpg","filename_download":"10.jpg","title":"10","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.105Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:24.122Z","charset":null,"filesize":"517573","width":1200,"height":900,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.205Z"}	{"storage":"local","filename_disk":"fbb8eda1-5a1c-4001-b68c-63ea505c8cd7.jpg","filename_download":"10.jpg","title":"10","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:24.122Z"}	\N	\N
160	168	directus_files	fbb8eda1-5a1c-4001-b68c-63ea505c8cd7	{"id":"fbb8eda1-5a1c-4001-b68c-63ea505c8cd7","storage":"local","filename_disk":"fbb8eda1-5a1c-4001-b68c-63ea505c8cd7.jpg","filename_download":"10.jpg","title":"10","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.105Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:24.136Z","charset":null,"filesize":"517573","width":1200,"height":900,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:33:24.133Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:24.136Z"}	\N	\N
161	169	directus_files	3b25d8cc-c200-4033-bd59-9dae81d9b54c	{"id":"3b25d8cc-c200-4033-bd59-9dae81d9b54c","storage":"local","filename_disk":"3b25d8cc-c200-4033-bd59-9dae81d9b54c.jpg","filename_download":"11.jpg","title":"11","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.118Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:40.546Z","charset":null,"filesize":"135699","width":1200,"height":627,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.194Z"}	{"storage":"local","filename_disk":"3b25d8cc-c200-4033-bd59-9dae81d9b54c.jpg","filename_download":"11.jpg","title":"11","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:40.546Z"}	\N	\N
162	170	directus_files	3b25d8cc-c200-4033-bd59-9dae81d9b54c	{"id":"3b25d8cc-c200-4033-bd59-9dae81d9b54c","storage":"local","filename_disk":"3b25d8cc-c200-4033-bd59-9dae81d9b54c.jpg","filename_download":"11.jpg","title":"11","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.118Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:40.559Z","charset":null,"filesize":"135699","width":1200,"height":627,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:33:40.557Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:40.559Z"}	\N	\N
163	171	directus_files	73b2e5d2-a82f-4ede-b6de-f0ef222c2d54	{"id":"73b2e5d2-a82f-4ede-b6de-f0ef222c2d54","storage":"local","filename_disk":"73b2e5d2-a82f-4ede-b6de-f0ef222c2d54.jpg","filename_download":"02.jpg","title":"02","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:18.918Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:47.522Z","charset":null,"filesize":"1324547","width":1600,"height":1068,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{"ifd0":{"Make":"Canon","Model":"Canon EOS-1D"},"exif":{"FNumber":5,"ExposureTime":0.004,"FocalLength":80,"ISOSpeedRatings":200}},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.141Z"}	{"storage":"local","filename_disk":"73b2e5d2-a82f-4ede-b6de-f0ef222c2d54.jpg","filename_download":"02.jpg","title":"02","type":"image/jpeg","folder":null,"description":null,"metadata":{"ifd0":{"Make":"Canon","Model":"Canon EOS-1D"},"exif":{"FNumber":5,"ExposureTime":0.004,"FocalLength":80,"ISOSpeedRatings":200}},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:47.522Z"}	\N	\N
164	172	directus_files	73b2e5d2-a82f-4ede-b6de-f0ef222c2d54	{"id":"73b2e5d2-a82f-4ede-b6de-f0ef222c2d54","storage":"local","filename_disk":"73b2e5d2-a82f-4ede-b6de-f0ef222c2d54.jpg","filename_download":"02.jpg","title":"02","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:18.918Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:47.541Z","charset":null,"filesize":"1324547","width":1600,"height":1068,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{"ifd0":{"Make":"Canon","Model":"Canon EOS-1D"},"exif":{"FNumber":5,"ExposureTime":0.004,"FocalLength":80,"ISOSpeedRatings":200}},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:33:47.536Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:47.541Z"}	\N	\N
165	173	directus_files	ae8b37b2-f83e-466f-b823-dff1c55176fa	{"id":"ae8b37b2-f83e-466f-b823-dff1c55176fa","storage":"local","filename_disk":"ae8b37b2-f83e-466f-b823-dff1c55176fa.jpg","filename_download":"09.jpg","title":"09","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.082Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:54.392Z","charset":null,"filesize":"27341","width":474,"height":292,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.129Z"}	{"storage":"local","filename_disk":"ae8b37b2-f83e-466f-b823-dff1c55176fa.jpg","filename_download":"09.jpg","title":"09","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:54.392Z"}	\N	\N
166	174	directus_files	ae8b37b2-f83e-466f-b823-dff1c55176fa	{"id":"ae8b37b2-f83e-466f-b823-dff1c55176fa","storage":"local","filename_disk":"ae8b37b2-f83e-466f-b823-dff1c55176fa.jpg","filename_download":"09.jpg","title":"09","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.082Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:54.408Z","charset":null,"filesize":"27341","width":474,"height":292,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:33:54.405Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:33:54.408Z"}	\N	\N
167	175	directus_files	c701ce16-8da2-4605-a7aa-b0143bdc3256	{"id":"c701ce16-8da2-4605-a7aa-b0143bdc3256","storage":"local","filename_disk":"c701ce16-8da2-4605-a7aa-b0143bdc3256.jpg","filename_download":"08.jpg","title":"08","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.042Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:36:37.491Z","charset":null,"filesize":"159477","width":738,"height":962,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.123Z"}	{"storage":"local","filename_disk":"c701ce16-8da2-4605-a7aa-b0143bdc3256.jpg","filename_download":"08.jpg","title":"08","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:36:37.491Z"}	\N	\N
168	176	directus_files	c701ce16-8da2-4605-a7aa-b0143bdc3256	{"id":"c701ce16-8da2-4605-a7aa-b0143bdc3256","storage":"local","filename_disk":"c701ce16-8da2-4605-a7aa-b0143bdc3256.jpg","filename_download":"08.jpg","title":"08","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.042Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:36:37.508Z","charset":null,"filesize":"159477","width":738,"height":962,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:36:37.505Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:36:37.508Z"}	\N	\N
169	177	directus_files	1ec9db0f-922f-4d4a-ae23-8586bc2e01f6	{"id":"1ec9db0f-922f-4d4a-ae23-8586bc2e01f6","storage":"local","filename_disk":"1ec9db0f-922f-4d4a-ae23-8586bc2e01f6.jpg","filename_download":"07.jpg","title":"07","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.027Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:36:44.310Z","charset":null,"filesize":"122227","width":1200,"height":627,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.117Z"}	{"storage":"local","filename_disk":"1ec9db0f-922f-4d4a-ae23-8586bc2e01f6.jpg","filename_download":"07.jpg","title":"07","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:36:44.310Z"}	\N	\N
170	178	directus_files	1ec9db0f-922f-4d4a-ae23-8586bc2e01f6	{"id":"1ec9db0f-922f-4d4a-ae23-8586bc2e01f6","storage":"local","filename_disk":"1ec9db0f-922f-4d4a-ae23-8586bc2e01f6.jpg","filename_download":"07.jpg","title":"07","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:19.027Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:36:44.326Z","charset":null,"filesize":"122227","width":1200,"height":627,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:36:44.323Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:36:44.326Z"}	\N	\N
171	179	directus_files	c7e68c19-ed8c-4f0f-8706-68eac916cd76	{"id":"c7e68c19-ed8c-4f0f-8706-68eac916cd76","storage":"local","filename_disk":"c7e68c19-ed8c-4f0f-8706-68eac916cd76.jpg","filename_download":"04.jpg","title":"04","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:18.984Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:36:51.550Z","charset":null,"filesize":"172649","width":1200,"height":900,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.040Z"}	{"storage":"local","filename_disk":"c7e68c19-ed8c-4f0f-8706-68eac916cd76.jpg","filename_download":"04.jpg","title":"04","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:36:51.550Z"}	\N	\N
172	180	directus_files	c7e68c19-ed8c-4f0f-8706-68eac916cd76	{"id":"c7e68c19-ed8c-4f0f-8706-68eac916cd76","storage":"local","filename_disk":"c7e68c19-ed8c-4f0f-8706-68eac916cd76.jpg","filename_download":"04.jpg","title":"04","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:18.984Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:36:51.559Z","charset":null,"filesize":"172649","width":1200,"height":900,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:36:51.557Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:36:51.559Z"}	\N	\N
173	181	directus_files	62b172d1-ec04-40fe-a3a8-7fc6f17eaabf	{"id":"62b172d1-ec04-40fe-a3a8-7fc6f17eaabf","storage":"local","filename_disk":"62b172d1-ec04-40fe-a3a8-7fc6f17eaabf.jpg","filename_download":"06.jpg","title":"06","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:18.937Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:36:58.076Z","charset":null,"filesize":"216528","width":681,"height":1024,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.026Z"}	{"storage":"local","filename_disk":"62b172d1-ec04-40fe-a3a8-7fc6f17eaabf.jpg","filename_download":"06.jpg","title":"06","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:36:58.076Z"}	\N	\N
174	182	directus_files	62b172d1-ec04-40fe-a3a8-7fc6f17eaabf	{"id":"62b172d1-ec04-40fe-a3a8-7fc6f17eaabf","storage":"local","filename_disk":"62b172d1-ec04-40fe-a3a8-7fc6f17eaabf.jpg","filename_download":"06.jpg","title":"06","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:18.937Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:36:58.091Z","charset":null,"filesize":"216528","width":681,"height":1024,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:36:58.088Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:36:58.091Z"}	\N	\N
177	185	directus_files	19c92283-f83d-48f2-87d6-e89742de1f8c	{"id":"19c92283-f83d-48f2-87d6-e89742de1f8c","storage":"local","filename_disk":"19c92283-f83d-48f2-87d6-e89742de1f8c.jpg","filename_download":"05.jpg","title":"05","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:18.963Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:37:12.691Z","charset":null,"filesize":"52806","width":550,"height":342,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.003Z"}	{"storage":"local","filename_disk":"19c92283-f83d-48f2-87d6-e89742de1f8c.jpg","filename_download":"05.jpg","title":"05","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:37:12.691Z"}	\N	\N
178	186	directus_files	19c92283-f83d-48f2-87d6-e89742de1f8c	{"id":"19c92283-f83d-48f2-87d6-e89742de1f8c","storage":"local","filename_disk":"19c92283-f83d-48f2-87d6-e89742de1f8c.jpg","filename_download":"05.jpg","title":"05","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:18.963Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:37:12.699Z","charset":null,"filesize":"52806","width":550,"height":342,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:37:12.696Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:37:12.699Z"}	\N	\N
175	183	directus_files	fa3728ba-aa35-4216-a451-3017436df012	{"id":"fa3728ba-aa35-4216-a451-3017436df012","storage":"local","filename_disk":"fa3728ba-aa35-4216-a451-3017436df012.jpg","filename_download":"03.jpg","title":"03","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:18.968Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:37:05.118Z","charset":null,"filesize":"176024","width":1024,"height":683,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:19.025Z"}	{"storage":"local","filename_disk":"fa3728ba-aa35-4216-a451-3017436df012.jpg","filename_download":"03.jpg","title":"03","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:37:05.118Z"}	\N	\N
176	184	directus_files	fa3728ba-aa35-4216-a451-3017436df012	{"id":"fa3728ba-aa35-4216-a451-3017436df012","storage":"local","filename_disk":"fa3728ba-aa35-4216-a451-3017436df012.jpg","filename_download":"03.jpg","title":"03","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:18.968Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:37:05.133Z","charset":null,"filesize":"176024","width":1024,"height":683,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:37:05.131Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:37:05.133Z"}	\N	\N
179	187	directus_files	b2f5899f-e1c5-4982-8af0-729a5c74444c	{"id":"b2f5899f-e1c5-4982-8af0-729a5c74444c","storage":"local","filename_disk":"b2f5899f-e1c5-4982-8af0-729a5c74444c.jpg","filename_download":"01.jpg","title":"01","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:18.900Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:37:20.161Z","charset":null,"filesize":"172425","width":1280,"height":720,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T12:31:18.993Z"}	{"storage":"local","filename_disk":"b2f5899f-e1c5-4982-8af0-729a5c74444c.jpg","filename_download":"01.jpg","title":"01","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:37:20.161Z"}	\N	\N
180	188	directus_files	b2f5899f-e1c5-4982-8af0-729a5c74444c	{"id":"b2f5899f-e1c5-4982-8af0-729a5c74444c","storage":"local","filename_disk":"b2f5899f-e1c5-4982-8af0-729a5c74444c.jpg","filename_download":"01.jpg","title":"01","type":"image/jpeg","folder":null,"uploaded_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","created_on":"2025-02-07T12:31:18.900Z","modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:37:20.175Z","charset":null,"filesize":"172425","width":1280,"height":720,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{},"focal_point_x":null,"focal_point_y":null,"tus_id":null,"tus_data":null,"uploaded_on":"2025-02-07T13:37:20.172Z"}	{"modified_by":"9d83a681-8388-4ff9-ae4b-7038fad0560a","modified_on":"2025-02-07T13:37:20.175Z"}	\N	\N
181	189	photos	c039aa00-88c2-4769-ad38-33df96fc64f3	{"id":"c039aa00-88c2-4769-ad38-33df96fc64f3","serie_id":"85678cf6-5977-45aa-b727-8d5c677f7e41","name":"Château de Montaigu","lat":"48.6633822330804","long":"6.2158060491444","link":"https://static.wixstatic.com/media/4d8fa8_49bbe10b1b374654a9304828fa4b9e21~mv2.jpg/v1/fill/w_2500,h_1830,al_c/4d8fa8_49bbe10b1b374654a9304828fa4b9e21~mv2.jpg","file":"58cfdd05-2848-4fa3-a117-08002848576a"}	{"file":"58cfdd05-2848-4fa3-a117-08002848576a"}	\N	\N
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
X3QPnywpRmGnwxLA95SZqF5Ebwql7KgHe7589SEtfcZH6hUG77tOj413GuKaZzda	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-14 12:30:21.74+00	172.26.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:33556	\N
mthGf16vDBdwRX0RGns5A5V_9Ixt_KDuHrPOtl2mA5bBFDwHRTH8brNd4TB_JG5-	9d83a681-8388-4ff9-ae4b-7038fad0560a	2025-02-14 13:22:00.86+00	192.168.64.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:33556	\N
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
06e0a60d-1924-41e2-aef5-1c0526264f4c	\N	\N	user@example.com	$argon2id$v=19$m=65536,t=3,p=4$BuslLM2v2MeDkYTPA6U89Q$9JljQbJim+5e4wzmnj31Nr/gEAsnX4KXRiUjtO+WCV0	\N	\N	\N	\N	\N	\N	\N	active	\N	\N	\N	\N	default	\N	\N	t	\N	\N	\N	\N	\N
9d83a681-8388-4ff9-ae4b-7038fad0560a	Admin	User	admin@admin.com	$argon2id$v=19$m=65536,t=3,p=4$ldbeGnw9Vpw7TVve1vm8FA$os+nxmcnwY1jmP9O9lWrbzK78x6zeFJ8dHE+BF3shQQ	\N	\N	\N	\N	\N	\N	\N	active	105cea0d-738a-437b-9183-a23a33deacde	\N	2025-02-07 13:22:00.876+00	/files	default	\N	\N	t	\N	\N	\N	\N	\N
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

COPY public.photos (id, serie_id, name, lat, long, link, file) FROM stdin;
00ed930e-e697-4b2a-96a4-92f84ed79aec	85678cf6-5977-45aa-b727-8d5c677f7e41	Jardin Botanique Jean-Marie Pelt	48.662758	6.155456	https://fr.wikipedia.org/wiki/Jardin_botanique_Jean-Marie-Pelt#/media/Fichier:Jardin_botanique_Montet_1.jpg	dafee953-9363-4f62-881d-b9c2dbc9d191
0a5ad80f-6d33-435b-bb15-18fd65a39f68	85678cf6-5977-45aa-b727-8d5c677f7e41	Ensic	48.699603595116	6.17990889333166	https://th.bing.com/th/id/R.084fa9f085165b0d47e0e309c358d4cc?rik=zgQMf1MoZM4%2bqg&pid=ImgRaw&r=0	a5a34488-797f-4f54-a54e-4b767e95fd39
12b31bea-edd6-4174-8cd7-3bb38a0efbfe	85678cf6-5977-45aa-b727-8d5c677f7e41	Faculté de Droit, Sciences Économiques et Gestion	48.6931229890256	6.1766413458741	https://live.staticflickr.com/65535/48864028882_580f6e3ff6_b.jpg	06447e4a-ca12-422b-989f-b9d791ac3554
211f70c8-8e04-4b97-8f84-328e8b043344	85678cf6-5977-45aa-b727-8d5c677f7e41	Centre Commercial Saint Sébastien	48.6880087792139	6.18067681830613	https://media-cdn.tripadvisor.com/media/photo-s/14/af/ea/6d/centre-commercial-saint.jpg	ecee2f07-bf16-46a4-ba2b-c4bd3b564cc6
2bf6df61-3bc2-4d0b-b5d9-5ebc094c04c3	85678cf6-5977-45aa-b727-8d5c677f7e41	Église Saint-Léon de Nancy	48.6892766684842	6.17207148496397	https://th.bing.com/th/id/OIP.-EvWoogHdOjjQTwMAaH8zwAAAA?w=384&h=547&rs=1&pid=ImgDetMain	ce53eb86-ee14-4587-bbd3-0b149b70108f
3f616107-69e6-4586-afc3-8a73c6b86891	85678cf6-5977-45aa-b727-8d5c677f7e41	Parc de la Cure d'Air	48.6933896583972	6.15995144259252	https://api.cloudly.space/resize/crop/1200/627/60/aHR0cHM6Ly93d3cuc2l0bG9yLmZyL3Bob3Rvcy83MzcvNzM3MDAwMjcxXzQuanBnPzIwMjEtMTItMjFUMTE6Mzk6NDha/image.jpg	3b25d8cc-c200-4033-bd59-9dae81d9b54c
41874312-d6a0-48e3-b16c-1be8e7cf9d44	85678cf6-5977-45aa-b727-8d5c677f7e41	Porte de la Craffe	48.6988659264728	6.17779765611324	https://i.pinimg.com/originals/ca/dd/5a/cadd5a34c4f64319dbb15b576d1e7369.jpg	6915b663-fb80-40a3-9481-a7032603a171
4d6c147e-2cdd-47a8-962a-5a8754f0a0fb	85678cf6-5977-45aa-b727-8d5c677f7e41	Musée des Beaux-Arts de Nancy	48.6934244497898	6.18235708015418	https://th.bing.com/th/id/R.ffa2da458031ec0d61c7aa59d49bb506?rik=73eXDK5WOPvL4A&pid=ImgRaw&r=0	73b2e5d2-a82f-4ede-b6de-f0ef222c2d54
588f48b7-3d1e-4ceb-bdfe-bfb43e7d09ca	85678cf6-5977-45aa-b727-8d5c677f7e41	Tour de la Commanderie Nazet-Moutaux	48.6865659854259	6.16735481677689	https://dynamic-media-cdn.tripadvisor.com/media/photo-o/24/1c/a5/8f/up-some-steps.jpg?w=1200&h=-1&s=1	bd5a6ebb-0f09-4771-9f8f-c3f58e549aca
5c6dc88e-be57-4e8e-8789-fda2d396cec5	85678cf6-5977-45aa-b727-8d5c677f7e41	Nancy Thermal	48.6791632317088	6.16872369208436	https://th.bing.com/th/id/R.98072a4bf1a9d532bdb8f0081a6f6118?rik=uARF5UMHDtuiig&riu=http%3a%2f%2fdha.eu%2fwp-content%2fuploads%2f2018%2f10%2f05.106.38.jpg&ehk=F93hYCSX%2f%2fbwFxNS78lk5VvilbZluJcchdrp9C2szMU%3d&risl=&pid=ImgRaw&r=0	e405cdda-0a5e-4b68-b112-893e9ce5d0e7
6a6a491c-a6a7-4e76-b2f3-3e0f337a3fd3	85678cf6-5977-45aa-b727-8d5c677f7e41	Porte Désilles	48.6979582620096	6.174147932838	https://media-cdn.tripadvisor.com/media/photo-s/14/af/43/c3/porte-desilles.jpg	19c92283-f83d-48f2-87d6-e89742de1f8c
781d1eeb-b809-4186-bc0b-7b90127f9e68	85678cf6-5977-45aa-b727-8d5c677f7e41	IUT Nancy-Brabois	48.6588705423001	6.15140298760477	https://iut-nancy-brabois.univ-lorraine.fr/files/2023/09/iutnb-campus-luneville-1536x1024.jpg	f5df93ea-7ba4-4f06-9242-8166091b4819
788af01e-36c3-4805-872c-c007c7758624	85678cf6-5977-45aa-b727-8d5c677f7e41	Stade Marcel Picot	48.6954249246343	6.21053652030365	https://th.bing.com/th/id/R.5228ad9f481c3985cc289b82e7ee9669?rik=AGJxuyX3ya272A&riu=http%3a%2f%2fwww.ostadium.com%2fgalleries%2fstade-marcel-picot-vue-aerienne-illus.jpg&ehk=s5JHg2RJq625D3pzyEzQoJquUrRUZ4HKasOuMOXKW%2f0%3d&risl=&pid=ImgRaw&r=0&sres=1&sres	ca4dd00c-1ac1-4917-b8bc-b82e280888e6
82fc87f1-453a-4e54-9e37-b216aeb1af9c	85678cf6-5977-45aa-b727-8d5c677f7e41	Muséum-Aquarium de Nancy	48.6949427895482	6.18820822723179	https://www.archi-wiki.org/images/thumb/9/91/34_rue_Sainte_Catherine_(entr%C3%A9e)_DSC04646.jpg/1200px-34_rue_Sainte_Catherine_(entr%C3%A9e)_DSC04646.jpg	c7e68c19-ed8c-4f0f-8706-68eac916cd76
93b2408f-eb3a-492f-98f1-fd71c7f702e1	85678cf6-5977-45aa-b727-8d5c677f7e41	Place Stanislas	48.6935915205383	6.18325640787205	https://i0.wp.com/viajealpatrimonio.com/wp-content/uploads/2020/05/0787-plaza-stanislas-plaza-de-la-carriere-y-plaza-de-la-alliance-en-nancy.jpg?ssl=1	fa3728ba-aa35-4216-a451-3017436df012
94d5df24-03eb-4e4d-87ca-a4fce91d8c34	85678cf6-5977-45aa-b727-8d5c677f7e41	Gare de Nancy	48.6897919909649	6.17440457810537	https://s3-media4.fl.yelpcdn.com/bphoto/fXtPxdpgpHr9RHB-Je-L6Q/o.jpg	5445a86e-1904-40bd-911f-06b82ed41b59
969b7872-14f8-4f2a-8b13-4905d0dc088e	85678cf6-5977-45aa-b727-8d5c677f7e41	Place de la Carrière	48.6954725331034	6.18193781254074	https://api.cloudly.space/resize/crop/1200/627/60/aHR0cHM6Ly93d3cuc2l0bG9yLmZyL3Bob3Rvcy83MzcvcGxhY2VfZGVfbGFfY2FycmllcmUuanBnPzIwMjEtMDYtMjJUMTU6NDI6MjJa/image.jpg	1ec9db0f-922f-4d4a-ae23-8586bc2e01f6
9d062e03-eaff-4e35-b2e6-a483c5aa5ae1	85678cf6-5977-45aa-b727-8d5c677f7e41	Faculté des Sciences et Technologies	48.6650952083834	6.16053031759351	https://www.pagesjaunes.fr/media/ugc/faculte_des_sciences_et_technologies_05454700_094219295	bc0aa97d-6864-4b2d-b95d-d00f16cf2acc
a3e4f064-84f4-402f-a9e6-9b00ce361c50	85678cf6-5977-45aa-b727-8d5c677f7e41	Plage de la Méchelle	48.6922610233877	6.20239706106462	https://cdn-s-www.estrepublicain.fr/images/B641AA78-4B8E-4544-9AF6-196687C4E853/NW_raw/le-nouveau-site-de-la-mechelle-a-connu-une-frequentation-contrastee-entre-jours-pluvieux-et-temps-plus-estival-photo-er-cedric-jacquot-1629912614.jpg	da5a49a5-5171-488d-9af5-c124b5ee5444
bcfbcf15-b835-4008-83d7-2ff935a6e918	85678cf6-5977-45aa-b727-8d5c677f7e41	Musée de l'École de Nancy	48.6805236575265	6.16617418668594	https://fr.wikipedia.org/wiki/Mus%C3%A9e_de_l%27%C3%89cole_de_Nancy#/media/Fichier:Mus%C3%A9e_%C3%A9cole_Nancy.jpg	c024b671-6386-4743-9384-cb3662fb11e4
bdf9f03d-962f-43c2-b89f-65e8e6cfbf41	85678cf6-5977-45aa-b727-8d5c677f7e41	Campus Lettres et Sciences Humaines de Nancy - Université de Lorraine	48.6955810198057	6.16599935776565	https://cdn-s-www.estrepublicain.fr/images/5ED2BEB3-6BEB-4C0B-8797-28AF345C4C4B/NW_raw/title-1607632070.jpg	7d63f98c-76ad-4755-938b-fe88b0030bc5
c05787a9-0e6f-4502-a932-ee5881addc7b	85678cf6-5977-45aa-b727-8d5c677f7e41	Musée Lorrain	48.6973116730877	6.17934775730296	https://media-cdn.tripadvisor.com/media/photo-s/1a/aa/52/81/portale.jpg	76df5f29-1826-48bd-ab36-eaf23cd03cc9
cb8b71b4-7989-4b6c-a68d-182ec0475648	85678cf6-5977-45aa-b727-8d5c677f7e41	Villa Majorelle	48.6855117761987	6.16386613003089	https://th.bing.com/th/id/OIP.8RzG0_gbx6N2P59VpOXSagHaEk?rs=1&pid=ImgDetMain	ae8b37b2-f83e-466f-b823-dff1c55176fa
d1ad5874-64df-40c8-8639-6728e614298d	85678cf6-5977-45aa-b727-8d5c677f7e41	Parc de la Pépinière	48.6977712521057	6.18460627665755	https://frenchmoments.eu/wp-content/uploads/2012/11/Parc-de-la-P%C3%A9pini%C3%A8re-04-Nancy-%C2%A9-French-Moments.jpg	fbb8eda1-5a1c-4001-b68c-63ea505c8cd7
ecc7ba07-95d1-4671-acd1-d975a676bed9	85678cf6-5977-45aa-b727-8d5c677f7e41	Basilique Saint-Epvre	48.695994903589	6.17991735334421	https://th.bing.com/th/id/R.f3da826715a8428a23f9421319e04d3c?rik=yEjlpTxxd%2beorA&riu=http%3a%2f%2flusile17.l.u.pic.centerblog.net%2fo%2fc8b40538.jpg&ehk=FKlylTb%2ffOKWDvalqpX5FQN4vXQqlBR79zBcaLfSBqQ%3d&risl=&pid=ImgRaw&r=0	c701ce16-8da2-4605-a7aa-b0143bdc3256
f13c4c48-503b-4131-9856-77137afab803	85678cf6-5977-45aa-b727-8d5c677f7e41	Cathédrale Notre-Dame-de-l'Annonciation	48.6915229374518	6.1858817407413	https://live.staticflickr.com/3164/3098725110_0f37479776_b.jpg	62b172d1-ec04-40fe-a3a8-7fc6f17eaabf
f4b0d799-e1ff-4506-a783-b6cab4ef0f06	85678cf6-5977-45aa-b727-8d5c677f7e41	Crous Resto U' Cours Léopold	48.6951174888681	6.17719255321255	https://dynamic-media-cdn.tripadvisor.com/media/photo-o/22/01/bb/3f/voici-la-facade-du-crous.jpg?w=1200&h=-1&s=1	0af0db58-edf1-4032-acfb-c45451930bde
55d1ecb2-82d9-445c-996b-68f7d1862432	85678cf6-5977-45aa-b727-8d5c677f7e41	Institut Universitaire de Technologie Nancy-Charlemagne	48.6828323658981	6.16091547406893	https://i.ytimg.com/vi/f3n6d4Ufk1U/maxresdefault_live.jpg	b2f5899f-e1c5-4982-8af0-729a5c74444c
207178a9-c5ae-4808-bafa-8f608913b4dc	85678cf6-5977-45aa-b727-8d5c677f7e41	Statue équestre de Jeanne d'Arc	48.6941403391368	6.1803078374452	https://th.bing.com/th/id/OIP.EIh8ndJen8yux0fiwlJybwHaLH?w=1200&h=1800&rs=1&pid=ImgDetMain	0c1b8d40-0e84-49c4-a7f7-439e87c5df1f
c039aa00-88c2-4769-ad38-33df96fc64f3	85678cf6-5977-45aa-b727-8d5c677f7e41	Château de Montaigu	48.6633822330804	6.2158060491444	https://static.wixstatic.com/media/4d8fa8_49bbe10b1b374654a9304828fa4b9e21~mv2.jpg/v1/fill/w_2500,h_1830,al_c/4d8fa8_49bbe10b1b374654a9304828fa4b9e21~mv2.jpg	58cfdd05-2848-4fa3-a117-08002848576a
a74fb23e-1ba0-4ac0-8391-dad8b06b81d9	85678cf6-5977-45aa-b727-8d5c677f7e41	Basilique du Sacré-Cœur de Nancy	48.6855496603864	6.16246257435614	https://th.bing.com/th/id/R.5ff55d576be674cdbb45aecd98a3faed?rik=JlZd9fGH6KJUJA&riu=http%3a%2f%2fphotos.wikimapia.org%2fp%2f00%2f01%2f68%2f26%2f37_big.jpg&ehk=U7mJ1UYZw%2bsFL31cbbDb5PnjnqP8Ca%2b3kjaR8Tpx5Hg%3d&risl=&pid=ImgRaw&r=0	8e5cc9e6-6761-47e8-af88-a64a083dd899
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

SELECT pg_catalog.setval('public.directus_activity_id_seq', 189, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 11, true);


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

SELECT pg_catalog.setval('public.directus_presets_id_seq', 4, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 2, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 181, true);


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
-- Name: photos photos_file_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_file_foreign FOREIGN KEY (file) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: photos photos_serie_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_serie_id_foreign FOREIGN KEY (serie_id) REFERENCES public.series(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

