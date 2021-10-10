--
-- PostgreSQL database dump
--

-- Dumped from database version 11.13
-- Dumped by pg_dump version 11.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO postgres;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO postgres;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO postgres;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO postgres;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO postgres;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO postgres;

--
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO postgres;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO postgres;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO postgres;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO postgres;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO postgres;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO postgres;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
862e372b-4d23-4953-b600-2da30dd6d601	\N	auth-cookie	master	5465cf33-5404-489f-982f-3b1fe80176c9	2	10	f	\N	\N
3bdceccd-24d2-45a0-9917-f29279010b3a	\N	auth-spnego	master	5465cf33-5404-489f-982f-3b1fe80176c9	3	20	f	\N	\N
22dcc702-f523-4289-8b36-fd8cae31ff46	\N	identity-provider-redirector	master	5465cf33-5404-489f-982f-3b1fe80176c9	2	25	f	\N	\N
b126042a-6730-4ae9-8e7b-326646675cbd	\N	\N	master	5465cf33-5404-489f-982f-3b1fe80176c9	2	30	t	813d2c93-2efe-4226-b3fb-11a6d5887854	\N
77c2d49e-0724-4cc3-9e9b-1c90210f6fbc	\N	auth-username-password-form	master	813d2c93-2efe-4226-b3fb-11a6d5887854	0	10	f	\N	\N
bac079a8-1588-4520-8fc6-f8a57afe3206	\N	\N	master	813d2c93-2efe-4226-b3fb-11a6d5887854	1	20	t	d8f3d123-837e-4973-ae5e-811b6a254759	\N
7d5b95a2-9df3-4743-9a08-6d98241d02d0	\N	conditional-user-configured	master	d8f3d123-837e-4973-ae5e-811b6a254759	0	10	f	\N	\N
8ab4eee8-a2ad-462d-9163-5f951de171bd	\N	auth-otp-form	master	d8f3d123-837e-4973-ae5e-811b6a254759	0	20	f	\N	\N
a86a50e2-2e31-4f95-88b5-97d8041e74ef	\N	direct-grant-validate-username	master	ee04db18-2a1e-4c00-bcd2-f4cb7115ce2a	0	10	f	\N	\N
f4eb86aa-5899-4511-8d89-044df39aff1c	\N	direct-grant-validate-password	master	ee04db18-2a1e-4c00-bcd2-f4cb7115ce2a	0	20	f	\N	\N
b66ed313-603f-46ea-9357-f753dd2eccfc	\N	\N	master	ee04db18-2a1e-4c00-bcd2-f4cb7115ce2a	1	30	t	405ba3d1-ae84-4978-8506-00085fc643ae	\N
dba8d90f-ff48-4ad3-9dea-12e099673cd6	\N	conditional-user-configured	master	405ba3d1-ae84-4978-8506-00085fc643ae	0	10	f	\N	\N
d1491b89-1032-446d-8f36-496d4a784e3a	\N	direct-grant-validate-otp	master	405ba3d1-ae84-4978-8506-00085fc643ae	0	20	f	\N	\N
7eb08b0b-3f16-46a7-860e-8fe42c382c26	\N	registration-page-form	master	d781011c-4d89-4bf7-a217-1126cbc4ad5a	0	10	t	675045d7-6500-45a0-ac0f-6d9b6e64fb2f	\N
76eb8eaf-57f9-4302-92a7-f287fd68ddb5	\N	registration-user-creation	master	675045d7-6500-45a0-ac0f-6d9b6e64fb2f	0	20	f	\N	\N
212187f6-9524-4314-8caf-b48f9a693ee1	\N	registration-profile-action	master	675045d7-6500-45a0-ac0f-6d9b6e64fb2f	0	40	f	\N	\N
72de2636-1d78-4959-92b2-1d15da79cedd	\N	registration-password-action	master	675045d7-6500-45a0-ac0f-6d9b6e64fb2f	0	50	f	\N	\N
b3956d5c-d4b6-49a5-a2d4-07b5ca0ce8d6	\N	registration-recaptcha-action	master	675045d7-6500-45a0-ac0f-6d9b6e64fb2f	3	60	f	\N	\N
40544af1-38bd-442d-ad3a-c54f05a95d24	\N	reset-credentials-choose-user	master	406c89e1-cbca-4401-b571-8f1c950cb53d	0	10	f	\N	\N
b4b91d27-7504-447a-abfa-543aa71742d0	\N	reset-credential-email	master	406c89e1-cbca-4401-b571-8f1c950cb53d	0	20	f	\N	\N
5688cba2-a734-488c-8081-985eae927734	\N	reset-password	master	406c89e1-cbca-4401-b571-8f1c950cb53d	0	30	f	\N	\N
7a5ab039-92c3-4792-9356-8bf6170c134f	\N	\N	master	406c89e1-cbca-4401-b571-8f1c950cb53d	1	40	t	de159db8-cb2b-4d5c-8e01-657ca6fff1dc	\N
f51fe175-8afc-4ea8-b803-0afae5b68c31	\N	conditional-user-configured	master	de159db8-cb2b-4d5c-8e01-657ca6fff1dc	0	10	f	\N	\N
65635f85-8b2d-4129-aa76-9943323ab396	\N	reset-otp	master	de159db8-cb2b-4d5c-8e01-657ca6fff1dc	0	20	f	\N	\N
9ecde58b-a336-40e6-aac5-174d7dfd6655	\N	client-secret	master	79a2a2ff-66b7-478a-9081-6fa9a2f4fa07	2	10	f	\N	\N
b7e907cc-26a0-4af4-b3e8-5da99187deac	\N	client-jwt	master	79a2a2ff-66b7-478a-9081-6fa9a2f4fa07	2	20	f	\N	\N
4c6bae5e-03b9-41af-b14b-3f5acaa71118	\N	client-secret-jwt	master	79a2a2ff-66b7-478a-9081-6fa9a2f4fa07	2	30	f	\N	\N
85db76ed-ae54-4943-a499-24008aebf1dd	\N	client-x509	master	79a2a2ff-66b7-478a-9081-6fa9a2f4fa07	2	40	f	\N	\N
641c5fc9-21ac-4a3e-8186-36fa13218b13	\N	idp-review-profile	master	8d96c3b0-d51a-4f91-8a93-57e53efad3b0	0	10	f	\N	42521a3e-c251-477c-b5c4-edd36f7dff15
4203c29a-ccc7-4506-ac59-689a9cb4a214	\N	\N	master	8d96c3b0-d51a-4f91-8a93-57e53efad3b0	0	20	t	e93f1f7d-b304-4746-818e-94ba2bd7aa26	\N
587b7b83-ea16-49e9-a3e5-13e472a3f2b9	\N	idp-create-user-if-unique	master	e93f1f7d-b304-4746-818e-94ba2bd7aa26	2	10	f	\N	2a7cafcb-4565-41ff-9c31-3ac84c6ec73a
cfbecd21-5d05-4ac4-abe7-aad5c1bae933	\N	\N	master	e93f1f7d-b304-4746-818e-94ba2bd7aa26	2	20	t	c7838201-aad2-434c-81e6-7b9d7ceee46a	\N
129a3d21-a7ae-438e-8c09-7c16020c3008	\N	idp-confirm-link	master	c7838201-aad2-434c-81e6-7b9d7ceee46a	0	10	f	\N	\N
6746aa80-38ca-4502-af71-8d43fb33de19	\N	\N	master	c7838201-aad2-434c-81e6-7b9d7ceee46a	0	20	t	8ddbc7ff-adb2-4951-9c3e-fd311886152f	\N
d997f074-ff3f-409d-899e-d41d076c3d81	\N	idp-email-verification	master	8ddbc7ff-adb2-4951-9c3e-fd311886152f	2	10	f	\N	\N
3499a832-4c06-425a-993c-7aad3981ba46	\N	\N	master	8ddbc7ff-adb2-4951-9c3e-fd311886152f	2	20	t	fa79fc61-8335-4abb-96c4-f59d5e06dcbf	\N
6110b7ac-b384-4f90-a35e-20dd392c1b49	\N	idp-username-password-form	master	fa79fc61-8335-4abb-96c4-f59d5e06dcbf	0	10	f	\N	\N
81f7730b-44a6-4941-82e6-d428b65305d3	\N	\N	master	fa79fc61-8335-4abb-96c4-f59d5e06dcbf	1	20	t	ef62dcc0-d7ea-41c5-95c6-b2c8c6c87c67	\N
b0d87ef6-c2b2-4d03-8287-6255a1d47f35	\N	conditional-user-configured	master	ef62dcc0-d7ea-41c5-95c6-b2c8c6c87c67	0	10	f	\N	\N
459e86ea-e9e6-48fd-809b-574f03a37592	\N	auth-otp-form	master	ef62dcc0-d7ea-41c5-95c6-b2c8c6c87c67	0	20	f	\N	\N
4e886c76-aa43-4142-a8f6-4bd9b921a345	\N	http-basic-authenticator	master	c65a4479-9f98-487a-a0aa-0249c9b3d59f	0	10	f	\N	\N
65810a1d-aada-4c48-8ca6-04826d40fbde	\N	docker-http-basic-authenticator	master	1b8aeab0-2c57-48d4-9b4b-eff647333da6	0	10	f	\N	\N
521593d3-ffb8-4de1-abd4-109620ccc5a1	\N	no-cookie-redirect	master	3d8086eb-79c4-4b2d-ad4d-15ed5f8394ca	0	10	f	\N	\N
f4874c8a-0039-47c4-8885-bffeb06360ec	\N	\N	master	3d8086eb-79c4-4b2d-ad4d-15ed5f8394ca	0	20	t	4ca1c31d-aa32-487c-a206-baf5bce1e3c6	\N
c719c297-1787-477b-88bc-684ceba3d437	\N	basic-auth	master	4ca1c31d-aa32-487c-a206-baf5bce1e3c6	0	10	f	\N	\N
cefd72fb-033a-45f9-822f-0cbc1afc27b3	\N	basic-auth-otp	master	4ca1c31d-aa32-487c-a206-baf5bce1e3c6	3	20	f	\N	\N
85c6d616-6053-4ca0-b110-61d9abdd7dcc	\N	auth-spnego	master	4ca1c31d-aa32-487c-a206-baf5bce1e3c6	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
5465cf33-5404-489f-982f-3b1fe80176c9	browser	browser based authentication	master	basic-flow	t	t
813d2c93-2efe-4226-b3fb-11a6d5887854	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
d8f3d123-837e-4973-ae5e-811b6a254759	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
ee04db18-2a1e-4c00-bcd2-f4cb7115ce2a	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
405ba3d1-ae84-4978-8506-00085fc643ae	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
d781011c-4d89-4bf7-a217-1126cbc4ad5a	registration	registration flow	master	basic-flow	t	t
675045d7-6500-45a0-ac0f-6d9b6e64fb2f	registration form	registration form	master	form-flow	f	t
406c89e1-cbca-4401-b571-8f1c950cb53d	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
de159db8-cb2b-4d5c-8e01-657ca6fff1dc	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
79a2a2ff-66b7-478a-9081-6fa9a2f4fa07	clients	Base authentication for clients	master	client-flow	t	t
8d96c3b0-d51a-4f91-8a93-57e53efad3b0	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
e93f1f7d-b304-4746-818e-94ba2bd7aa26	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
c7838201-aad2-434c-81e6-7b9d7ceee46a	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
8ddbc7ff-adb2-4951-9c3e-fd311886152f	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
fa79fc61-8335-4abb-96c4-f59d5e06dcbf	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
ef62dcc0-d7ea-41c5-95c6-b2c8c6c87c67	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
c65a4479-9f98-487a-a0aa-0249c9b3d59f	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
1b8aeab0-2c57-48d4-9b4b-eff647333da6	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
3d8086eb-79c4-4b2d-ad4d-15ed5f8394ca	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
4ca1c31d-aa32-487c-a206-baf5bce1e3c6	Authentication Options	Authentication options.	master	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
42521a3e-c251-477c-b5c4-edd36f7dff15	review profile config	master
2a7cafcb-4565-41ff-9c31-3ac84c6ec73a	create unique user config	master
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
42521a3e-c251-477c-b5c4-edd36f7dff15	missing	update.profile.on.first.login
2a7cafcb-4565-41ff-9c31-3ac84c6ec73a	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
d301aa15-e0ef-4e80-8228-4bdff33e0ce5	t	f	master-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
891ad587-fbef-4860-8577-aab2c62879ca	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
7f92e756-c626-4df4-a1ff-516e5bc0df21	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
8ad62a0b-9544-496b-9d4f-7ec95ddfa389	t	f	broker	0	f	\N	\N	t	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
66b9bbea-7feb-49f9-9bc4-c62d6c7198b5	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
e67eb6e5-e0a8-4406-aac7-79f2bac3385d	t	f	admin-cli	0	t	\N	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
7f92e756-c626-4df4-a1ff-516e5bc0df21	S256	pkce.code.challenge.method
66b9bbea-7feb-49f9-9bc4-c62d6c7198b5	S256	pkce.code.challenge.method
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
db631faf-d9a1-4f66-9dac-76b1a12e8823	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
93a6d859-8e75-4d99-aac1-3676a97ec616	role_list	master	SAML role list	saml
956783e9-4e39-462a-b7f1-ae540b5429cc	profile	master	OpenID Connect built-in scope: profile	openid-connect
9fc7d656-dd86-4e9e-b491-507c53182ba8	email	master	OpenID Connect built-in scope: email	openid-connect
00c7a8a6-5d69-4fb2-b660-740d7b2d149e	address	master	OpenID Connect built-in scope: address	openid-connect
c84d9841-6d72-42f9-b285-e9b644b573a1	phone	master	OpenID Connect built-in scope: phone	openid-connect
f35fa060-6d8b-4100-b99d-2533543897c6	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
866a0dcf-ff7f-4679-9972-2a905eb52056	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
f1c284bc-0602-4edb-bc20-42862a2ee5a7	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
db631faf-d9a1-4f66-9dac-76b1a12e8823	true	display.on.consent.screen
db631faf-d9a1-4f66-9dac-76b1a12e8823	${offlineAccessScopeConsentText}	consent.screen.text
93a6d859-8e75-4d99-aac1-3676a97ec616	true	display.on.consent.screen
93a6d859-8e75-4d99-aac1-3676a97ec616	${samlRoleListScopeConsentText}	consent.screen.text
956783e9-4e39-462a-b7f1-ae540b5429cc	true	display.on.consent.screen
956783e9-4e39-462a-b7f1-ae540b5429cc	${profileScopeConsentText}	consent.screen.text
956783e9-4e39-462a-b7f1-ae540b5429cc	true	include.in.token.scope
9fc7d656-dd86-4e9e-b491-507c53182ba8	true	display.on.consent.screen
9fc7d656-dd86-4e9e-b491-507c53182ba8	${emailScopeConsentText}	consent.screen.text
9fc7d656-dd86-4e9e-b491-507c53182ba8	true	include.in.token.scope
00c7a8a6-5d69-4fb2-b660-740d7b2d149e	true	display.on.consent.screen
00c7a8a6-5d69-4fb2-b660-740d7b2d149e	${addressScopeConsentText}	consent.screen.text
00c7a8a6-5d69-4fb2-b660-740d7b2d149e	true	include.in.token.scope
c84d9841-6d72-42f9-b285-e9b644b573a1	true	display.on.consent.screen
c84d9841-6d72-42f9-b285-e9b644b573a1	${phoneScopeConsentText}	consent.screen.text
c84d9841-6d72-42f9-b285-e9b644b573a1	true	include.in.token.scope
f35fa060-6d8b-4100-b99d-2533543897c6	true	display.on.consent.screen
f35fa060-6d8b-4100-b99d-2533543897c6	${rolesScopeConsentText}	consent.screen.text
f35fa060-6d8b-4100-b99d-2533543897c6	false	include.in.token.scope
866a0dcf-ff7f-4679-9972-2a905eb52056	false	display.on.consent.screen
866a0dcf-ff7f-4679-9972-2a905eb52056		consent.screen.text
866a0dcf-ff7f-4679-9972-2a905eb52056	false	include.in.token.scope
f1c284bc-0602-4edb-bc20-42862a2ee5a7	false	display.on.consent.screen
f1c284bc-0602-4edb-bc20-42862a2ee5a7	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
891ad587-fbef-4860-8577-aab2c62879ca	956783e9-4e39-462a-b7f1-ae540b5429cc	t
891ad587-fbef-4860-8577-aab2c62879ca	9fc7d656-dd86-4e9e-b491-507c53182ba8	t
891ad587-fbef-4860-8577-aab2c62879ca	866a0dcf-ff7f-4679-9972-2a905eb52056	t
891ad587-fbef-4860-8577-aab2c62879ca	f35fa060-6d8b-4100-b99d-2533543897c6	t
891ad587-fbef-4860-8577-aab2c62879ca	db631faf-d9a1-4f66-9dac-76b1a12e8823	f
891ad587-fbef-4860-8577-aab2c62879ca	c84d9841-6d72-42f9-b285-e9b644b573a1	f
891ad587-fbef-4860-8577-aab2c62879ca	f1c284bc-0602-4edb-bc20-42862a2ee5a7	f
891ad587-fbef-4860-8577-aab2c62879ca	00c7a8a6-5d69-4fb2-b660-740d7b2d149e	f
7f92e756-c626-4df4-a1ff-516e5bc0df21	956783e9-4e39-462a-b7f1-ae540b5429cc	t
7f92e756-c626-4df4-a1ff-516e5bc0df21	9fc7d656-dd86-4e9e-b491-507c53182ba8	t
7f92e756-c626-4df4-a1ff-516e5bc0df21	866a0dcf-ff7f-4679-9972-2a905eb52056	t
7f92e756-c626-4df4-a1ff-516e5bc0df21	f35fa060-6d8b-4100-b99d-2533543897c6	t
7f92e756-c626-4df4-a1ff-516e5bc0df21	db631faf-d9a1-4f66-9dac-76b1a12e8823	f
7f92e756-c626-4df4-a1ff-516e5bc0df21	c84d9841-6d72-42f9-b285-e9b644b573a1	f
7f92e756-c626-4df4-a1ff-516e5bc0df21	f1c284bc-0602-4edb-bc20-42862a2ee5a7	f
7f92e756-c626-4df4-a1ff-516e5bc0df21	00c7a8a6-5d69-4fb2-b660-740d7b2d149e	f
e67eb6e5-e0a8-4406-aac7-79f2bac3385d	956783e9-4e39-462a-b7f1-ae540b5429cc	t
e67eb6e5-e0a8-4406-aac7-79f2bac3385d	9fc7d656-dd86-4e9e-b491-507c53182ba8	t
e67eb6e5-e0a8-4406-aac7-79f2bac3385d	866a0dcf-ff7f-4679-9972-2a905eb52056	t
e67eb6e5-e0a8-4406-aac7-79f2bac3385d	f35fa060-6d8b-4100-b99d-2533543897c6	t
e67eb6e5-e0a8-4406-aac7-79f2bac3385d	db631faf-d9a1-4f66-9dac-76b1a12e8823	f
e67eb6e5-e0a8-4406-aac7-79f2bac3385d	c84d9841-6d72-42f9-b285-e9b644b573a1	f
e67eb6e5-e0a8-4406-aac7-79f2bac3385d	f1c284bc-0602-4edb-bc20-42862a2ee5a7	f
e67eb6e5-e0a8-4406-aac7-79f2bac3385d	00c7a8a6-5d69-4fb2-b660-740d7b2d149e	f
8ad62a0b-9544-496b-9d4f-7ec95ddfa389	956783e9-4e39-462a-b7f1-ae540b5429cc	t
8ad62a0b-9544-496b-9d4f-7ec95ddfa389	9fc7d656-dd86-4e9e-b491-507c53182ba8	t
8ad62a0b-9544-496b-9d4f-7ec95ddfa389	866a0dcf-ff7f-4679-9972-2a905eb52056	t
8ad62a0b-9544-496b-9d4f-7ec95ddfa389	f35fa060-6d8b-4100-b99d-2533543897c6	t
8ad62a0b-9544-496b-9d4f-7ec95ddfa389	db631faf-d9a1-4f66-9dac-76b1a12e8823	f
8ad62a0b-9544-496b-9d4f-7ec95ddfa389	c84d9841-6d72-42f9-b285-e9b644b573a1	f
8ad62a0b-9544-496b-9d4f-7ec95ddfa389	f1c284bc-0602-4edb-bc20-42862a2ee5a7	f
8ad62a0b-9544-496b-9d4f-7ec95ddfa389	00c7a8a6-5d69-4fb2-b660-740d7b2d149e	f
d301aa15-e0ef-4e80-8228-4bdff33e0ce5	956783e9-4e39-462a-b7f1-ae540b5429cc	t
d301aa15-e0ef-4e80-8228-4bdff33e0ce5	9fc7d656-dd86-4e9e-b491-507c53182ba8	t
d301aa15-e0ef-4e80-8228-4bdff33e0ce5	866a0dcf-ff7f-4679-9972-2a905eb52056	t
d301aa15-e0ef-4e80-8228-4bdff33e0ce5	f35fa060-6d8b-4100-b99d-2533543897c6	t
d301aa15-e0ef-4e80-8228-4bdff33e0ce5	db631faf-d9a1-4f66-9dac-76b1a12e8823	f
d301aa15-e0ef-4e80-8228-4bdff33e0ce5	c84d9841-6d72-42f9-b285-e9b644b573a1	f
d301aa15-e0ef-4e80-8228-4bdff33e0ce5	f1c284bc-0602-4edb-bc20-42862a2ee5a7	f
d301aa15-e0ef-4e80-8228-4bdff33e0ce5	00c7a8a6-5d69-4fb2-b660-740d7b2d149e	f
66b9bbea-7feb-49f9-9bc4-c62d6c7198b5	956783e9-4e39-462a-b7f1-ae540b5429cc	t
66b9bbea-7feb-49f9-9bc4-c62d6c7198b5	9fc7d656-dd86-4e9e-b491-507c53182ba8	t
66b9bbea-7feb-49f9-9bc4-c62d6c7198b5	866a0dcf-ff7f-4679-9972-2a905eb52056	t
66b9bbea-7feb-49f9-9bc4-c62d6c7198b5	f35fa060-6d8b-4100-b99d-2533543897c6	t
66b9bbea-7feb-49f9-9bc4-c62d6c7198b5	db631faf-d9a1-4f66-9dac-76b1a12e8823	f
66b9bbea-7feb-49f9-9bc4-c62d6c7198b5	c84d9841-6d72-42f9-b285-e9b644b573a1	f
66b9bbea-7feb-49f9-9bc4-c62d6c7198b5	f1c284bc-0602-4edb-bc20-42862a2ee5a7	f
66b9bbea-7feb-49f9-9bc4-c62d6c7198b5	00c7a8a6-5d69-4fb2-b660-740d7b2d149e	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
db631faf-d9a1-4f66-9dac-76b1a12e8823	43327b95-aa7b-47c7-92ea-28735514f5a9
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
e3b78cdc-4928-4f4e-8249-38c23011edba	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
f3742048-042a-4e06-974b-96b1fea8e508	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
cb8c4f6c-3d11-46b5-81b8-b1216b2a8c97	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
dfe92612-ca17-4ebf-87c1-e1d257221371	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
afb009c5-314d-40e4-845e-c68e357dc358	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
d5ef3bc2-7c5e-4b08-923d-c8f52cdb7469	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
f7bb3018-a85e-4252-a5ce-568e636e41f9	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
35101096-ad11-407a-895f-cb0a1af753af	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
444470dc-c4a6-46e8-870c-f46942834c9d	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
47e3a1b6-5f88-4975-a7dd-d61426de247b	rsa-enc-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
95aec9ea-bf09-4e8c-8cac-4696566a947a	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
fbeac9d6-3516-42b1-a1c9-135b0fce5ac8	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
8ae2380d-2597-44e4-b4eb-d72da316392d	e3b78cdc-4928-4f4e-8249-38c23011edba	client-uris-must-match	true
877eaf62-6e7b-44d7-ad2a-8124e06b7cc6	e3b78cdc-4928-4f4e-8249-38c23011edba	host-sending-registration-request-must-match	true
c196dc59-dbc7-4f33-b624-f8ee24643608	dfe92612-ca17-4ebf-87c1-e1d257221371	max-clients	200
26dde801-5b9a-481d-8625-3e2c1b3eeb02	afb009c5-314d-40e4-845e-c68e357dc358	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
2f0b9a37-8da2-461a-b6c8-12106b480318	afb009c5-314d-40e4-845e-c68e357dc358	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
b1ab9ef3-97d2-487a-9277-fec8a87b0688	afb009c5-314d-40e4-845e-c68e357dc358	allowed-protocol-mapper-types	oidc-full-name-mapper
b8ae5682-b4fa-46c1-a623-51158622708f	afb009c5-314d-40e4-845e-c68e357dc358	allowed-protocol-mapper-types	oidc-address-mapper
e7415428-80a8-404a-b9f8-c320d11f57c4	afb009c5-314d-40e4-845e-c68e357dc358	allowed-protocol-mapper-types	saml-user-property-mapper
e9db2feb-9647-4a9f-bb9c-d0bf01b24df8	afb009c5-314d-40e4-845e-c68e357dc358	allowed-protocol-mapper-types	saml-user-attribute-mapper
29274cde-1244-4c26-bb53-9f017ab60aa6	afb009c5-314d-40e4-845e-c68e357dc358	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
3df80ddd-1d10-4cca-9cc2-e57be70d9ebc	afb009c5-314d-40e4-845e-c68e357dc358	allowed-protocol-mapper-types	saml-role-list-mapper
e601cc63-1a21-4c73-83c4-3ebcff71b6b2	f7bb3018-a85e-4252-a5ce-568e636e41f9	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
ad9bb4b3-0ed8-42ef-991f-7dee26ebcb72	f7bb3018-a85e-4252-a5ce-568e636e41f9	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
93a9d280-3ade-43b6-9b6e-7f566eceb555	f7bb3018-a85e-4252-a5ce-568e636e41f9	allowed-protocol-mapper-types	saml-role-list-mapper
bf33f2fa-38ae-402c-aa01-a9b0f86a7bf9	f7bb3018-a85e-4252-a5ce-568e636e41f9	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
50de3fea-3be4-45ca-aa26-a61ceb6cf872	f7bb3018-a85e-4252-a5ce-568e636e41f9	allowed-protocol-mapper-types	saml-user-attribute-mapper
c29e7fd3-3680-4fb9-b859-a0d9b59cf1d2	f7bb3018-a85e-4252-a5ce-568e636e41f9	allowed-protocol-mapper-types	saml-user-property-mapper
d7785eeb-1641-475a-8885-e345a4aa9a05	f7bb3018-a85e-4252-a5ce-568e636e41f9	allowed-protocol-mapper-types	oidc-address-mapper
2d61e3ed-8d36-4aac-b74f-bbfb27adbd45	f7bb3018-a85e-4252-a5ce-568e636e41f9	allowed-protocol-mapper-types	oidc-full-name-mapper
debac984-2882-43fc-b16f-75229217c28b	35101096-ad11-407a-895f-cb0a1af753af	allow-default-scopes	true
a7163464-b1f8-46b6-8231-12cd286bc3e0	d5ef3bc2-7c5e-4b08-923d-c8f52cdb7469	allow-default-scopes	true
e673b32d-d230-4e4a-9591-32d5a3b77557	fbeac9d6-3516-42b1-a1c9-135b0fce5ac8	kid	caa39a06-a545-4a46-9da3-fa47c7449877
f47bdbf4-a433-4811-9782-3f05b0bd59eb	fbeac9d6-3516-42b1-a1c9-135b0fce5ac8	secret	qV9UK-MV8Xx1q1Hxiywt5g
4721d74d-891f-4d40-818a-515848a74de6	fbeac9d6-3516-42b1-a1c9-135b0fce5ac8	priority	100
a74ef176-32ef-437c-8d2a-f923b6b26d5b	444470dc-c4a6-46e8-870c-f46942834c9d	priority	100
cb8d887a-3038-4695-b412-7dae2bd73204	444470dc-c4a6-46e8-870c-f46942834c9d	certificate	MIICmzCCAYMCBgF8ZU4czDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjExMDA5MTM0NDUwWhcNMzExMDA5MTM0NjMwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDYt5X1hu2TbERjUDmKx4jfyIJw1r0bCvhIRYsWqaDWeZmdQbiq0RWAO6zpemHNXX7VyxKMs8Mproo0ehiXrcHoPwVMGuthbI3eTFfTAb/tG5u75MmrUuCW40KxuivgB4DPTx9Zh9xss8KDjY2v3K9Akr0FkubEkpl/8rPoT6PmoqzTfxP+Wa5t7u8Y4JUlpgHUzC8LwxBvwx75rUAWXRE3Z8uboHh9Jt4UT4LdAAmgyMlTcvoL78QQ9j08LYF8Z3poKbbGb6bu5JdSRdczWExW7F3jnfHFDpdqCJR131hkHg92m0Ya1tnkQE0BqHer1PaXzsYEN3EZKMZKe3xjV0etAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFbLOwIKZXycLUAska5eg6QlwnSHE51IwGe/eDnTZHFVoMfb0+FnjkL6Uyl4hldMK5SvuOTNHP6tLDAOLL3+fPe0kbIVBsOLaoj8NST4BODlq/wImSrv+h35gmz4e5GeKFEzcofaXbAKbIc/5HHrSU6+1ljWeFLP7uzhI1JwTKD7S2WBILgJD5kQ+nbb6C3yQHr/50gB/0x7MmU+fpMIcGhVTl6D341KQ4X6bzS69R3Lw8tyfpxOTIjXRDrphAtH/PWjddteNR+o8doLvqGlMk1RWVMC+5ttY08CBSG4oa70F55lrm6SP5N661bMqZEHueG9IRIW4QRdy50ReaIyuxM=
c27ce40c-30c8-46e2-9432-1e8bdc2aec3d	444470dc-c4a6-46e8-870c-f46942834c9d	keyUse	sig
5f316f67-dea0-4a1f-b192-35fc315ee7c9	444470dc-c4a6-46e8-870c-f46942834c9d	privateKey	MIIEowIBAAKCAQEA2LeV9Ybtk2xEY1A5iseI38iCcNa9Gwr4SEWLFqmg1nmZnUG4qtEVgDus6XphzV1+1csSjLPDKa6KNHoYl63B6D8FTBrrYWyN3kxX0wG/7Rubu+TJq1LgluNCsbor4AeAz08fWYfcbLPCg42Nr9yvQJK9BZLmxJKZf/Kz6E+j5qKs038T/lmube7vGOCVJaYB1MwvC8MQb8Me+a1AFl0RN2fLm6B4fSbeFE+C3QAJoMjJU3L6C+/EEPY9PC2BfGd6aCm2xm+m7uSXUkXXM1hMVuxd453xxQ6XagiUdd9YZB4PdptGGtbZ5EBNAah3q9T2l87GBDdxGSjGSnt8Y1dHrQIDAQABAoIBAGaFOrii8uLJ1fRRcFc5m4OZ3DM7MsyHPPsbgvfemQq9DbF59L1CGfTGxj7ROVEoiKbk4UqUg5/FRPYcSGQAu/l9Tqk5Ft7ItrhRzz4v1rZ5WAvj6I9Wro5SxitDkhvyELqBiKgXAGygAUWwgjWOpY1bnXX0j5ywaVNA4mDkw/mHXdhDwfmli1AUg0G49FmSWTeXxSdDzYfrYdDrc7a1ueIQ4KJttp0YoA7XZ77rKV7fQfgRLWtz9FWT4SwOHuArJky/nu32EHuNZ/AKNYTUqynF5uA6NUQH5KHWMR21DSG6fRxgIAgpcjdjZuIMCTIdLOe+virYkGlENUjb+wKen9UCgYEA/btm/zQaPb1m5x9k/7FfRSL0d4pPrAZ8Yj8qJrlbTLQqbl5+yHSETJFt2YLOEMmPENal7cvLvznN93bf3j9r3GcMbSYLAvTouEETPLvQ/SRFvYExpWUTwU4TVu+V09dMyubtNyjaHX38sij30BTBAo+fg73Tb6GJRLjNZlV8iFsCgYEA2qd8GXfznTMH17NcPRa/rtkGAldKHagyiKwZ2MPwN06PcaPVJHZ2g74XLAmScHSHidbrZ+JtCAo10Qewc/JLs1eLOj0KsMMMmLYrGealIFvnVVVG2xduIIi/t5WUCFzUUOpNLCpUtKntYVjvL1aeYL1RonWAJPVZ8T9+RxSvrpcCgYEAxtk0efK6UgJ6f81h2OWIFWW0k26oy9d1aYW5IgoH3FAiJMcXsz9lY6Bhp6JUnmFoJrkh5v/dWKsTmMnn3oRzopJ78Zpr7NBFBgmx6toCijEAGukCIG3bkpX+oBY5pIDJ5QYfiCgS8CQJgxKKS9/H95rZV2TQLF87dcki5/09EJsCgYArBooE+PWXGVORvlmIK9HMNihYjZSoAVDwU+1CGkxKlcrkMbjfU/A+PEmTAM8wEb4aAZCRAJ0z185/M2QlbKg4wiFDdH+GCNuRsUcJ8bjMhUkgIYev1Qx2mnIfTe+zNZER2wkUh7/jTQzI+xcV2ZWQs7A8p6Jvo1fvgO74TbnEQQKBgHIqzbLU8RJR6YnR0mARotJBpfjjTWJYj6UXHKgYKhezF/6tBlYQXIqxffgWOy3TpfqT9j0SMpb1AROkqaRIUAEgp9bVJq+Ry/NnmnOcYI3WwqZs6JQCKcTOaaTPEOJIw+ds551CHKhRur20TmPhaT4eZKI5XBTMuVY4gWyWO1Q+
f674cbd4-66c2-40e4-a5cc-74f4bbc99a84	95aec9ea-bf09-4e8c-8cac-4696566a947a	priority	100
f86e8255-538f-4bd9-b79d-32665b3e1020	95aec9ea-bf09-4e8c-8cac-4696566a947a	kid	3070a16e-17af-457a-afa8-770e09393ee5
b97aa026-95b5-4e01-b4af-48ee7b211c37	95aec9ea-bf09-4e8c-8cac-4696566a947a	secret	Ms1dM51Y8n6uch7dPLIo2wHbkvj5B85-IiGn3hvwWqEB-mX_DQmpvCfqcExpPYqrWkRwCo8W9wGhqPeH2QkW6w
57632b03-1174-46fe-a8f6-e7bda8462cda	95aec9ea-bf09-4e8c-8cac-4696566a947a	algorithm	HS256
994b353f-fd61-421f-b724-ffd12b36e3e4	47e3a1b6-5f88-4975-a7dd-d61426de247b	certificate	MIICmzCCAYMCBgF8ZU4dxzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjExMDA5MTM0NDUwWhcNMzExMDA5MTM0NjMwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDPGUfPFkuDKpqL0b+OMRQ6KuJshNiNgEEhZZ7X/wkou5ayB3gu13h9BD5tZY2rSG0wAsivkSCOw9M7hpyvwy9vHPbKA1+8mUKa21yNj8EDzCZcIFhtxyOzS60UyNZcOpfPTeW3ymW3x9gPdMNUOuftvEuUomsi37d4FhvQs1kCkjiOnOcnqUZboHxXRtGhB85p7RsLVbNikw3PAPTpjFCvdQjTS0Uw9vietFzBPWygYWe1BQN9sLFyjEKYMq2b9hE3GjvcyzjFtncU+g9s3OGT3f4bNsKumj8C+xK0OeeIZXNXOFChpYpaEOwzWqlBH7UCm8xNv68UfS310DvJXQSzAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAGoIpQ0yicEVdunmniEp7G98lQDiAJBeS/0yaCuDeXm8tDcgd8SQOPf4h0qT7BWE/pfJ+QttYyjtMllw+tvVKh1Lg4TMRnhKhWc2fivh9iuuHd3rZd2N39IKc05NRmH2EYDUEld2g2a+/TpIz2HgidghTlrKM5N/Fx8sMmat97lMxI6BHxn4+YMYTsNPlhcymYMnjHe3eQ97SKGsGp/bt9V24nBh4cEkybevtXdeQKRobNnm7mVXAXkV9PULXQtwvyWIZHZv/k5eBkElKPUjrNbO66anoTFPf+lttwIdjaCD1VxYll8lt3a8pw84vFJxtP4vv/CYk+rYB7zaEkRYqbA=
49903fef-0eb4-4ffb-a1a1-8a55d3ea4968	47e3a1b6-5f88-4975-a7dd-d61426de247b	privateKey	MIIEpAIBAAKCAQEAzxlHzxZLgyqai9G/jjEUOiribITYjYBBIWWe1/8JKLuWsgd4Ltd4fQQ+bWWNq0htMALIr5EgjsPTO4acr8Mvbxz2ygNfvJlCmttcjY/BA8wmXCBYbccjs0utFMjWXDqXz03lt8plt8fYD3TDVDrn7bxLlKJrIt+3eBYb0LNZApI4jpznJ6lGW6B8V0bRoQfOae0bC1WzYpMNzwD06YxQr3UI00tFMPb4nrRcwT1soGFntQUDfbCxcoxCmDKtm/YRNxo73Ms4xbZ3FPoPbNzhk93+GzbCrpo/AvsStDnniGVzVzhQoaWKWhDsM1qpQR+1ApvMTb+vFH0t9dA7yV0EswIDAQABAoIBAQC/+ZBOUD15fnG6sJlgJvC4Ju6zZ8YSDVTSr4+6bAjCgHnl1/S5fzWKtfdkk2Hq5/2HJt1/mglTLgXORS9T4pxC5NeEVfJWMr/CKxw1gY+LhJ/+gGFYieP3HWx5Ot8yqYH2QiBy6aS24wLO+Q7kMqKyBv0M8C5eKoG5SM1J/ibBsLyKyL96tGfA6hi8Ie5lu+DSUsFhL1U+7BswS+9DD0tt6DpIc4hDrNQ9SoJAdN3JyYOkwbkEKQfT8DTFv7r6/tcYBqyanDalKHKg9pBHD0yq+DF0A4x/6CaqaJ7GZIaYM0nad6YpHfZmI4+CIJEsP1NVtlrFIZTQO5VuG/lLo1npAoGBAO/0o2iih4W+uR5giuEGtz64Ieg8sEPv2lWkMHGnpsZq4bWxVzrENX5lCypQpP/T8Ou9e1vAONLnlffM9gKCIUeRtXtlRH4ZGQmLgEngXxJMUKusufRu9CdmI1LMWLCFPMpCgEtX0wlEQZRfC5lIb/JfBmQEL1pitb/qK0oNnXF3AoGBANzyOb0S5ajxJAYStA69/z0a4MvLPhqbsBWo63mqorN2WyKvv5MKELh6HSqFopEermXIoYlXY9YcY3wKzUhroN8s8Zui0iYeist4166ga73VLaffSSlwsSBHQb3cqkySaV+akmvglmUJckrwtMXHFis3O3rwuoZrZXudmJVIFPWlAoGAH8jO8Gg+/VdTHBP7sWz7TuKDE0kerBEUYa27AQMNE1FLDo8sF8uvrktiHDvMb1q6me9ibLfcjwtAES/kElb8Y4eIe4zhcraOW3ZQCvkefsT/Fo5tn1QnISTlXu1UfiVX9Q60AcbjXGHfMfEZDzfKJFez+AGZ6CYVHxO8ojWFemcCgYEAruFnBBnN/++GJOxu6nBGc3Yv0f631FXAhRRj9bQy/btDnWvgRaEk5O964GpP52+SeGvaOBwcoJ9tuwPNwnG2Lo+jWR4CGjv4fd7TUJwXS3VNot8gSJWzDSp5ha8AeIU2tH5jQNHOGIDmnxxw6U6QZHpeMQwTh0vAUpzF5frc5CUCgYA6fBkLRq3Fm5+CMbEEmYquy3dV+oV10HokTM9DfMbJ6r5XIk1EAF5S+jWCbkX1RU43jnNaamkCwbnAH1UztEIQORX888vYZwfrPd+LwwUtn4SxjLi4BuPZO0K1K/0hf5K4gWlB6SKiWgasXfuY81dvHQMzD7CuLX9Nj1+MBThEIQ==
90c1224a-4a47-4d16-a06d-bdd1bcd5d46a	47e3a1b6-5f88-4975-a7dd-d61426de247b	priority	100
f72d7e21-0879-4ce0-acb8-70d6110cb74b	47e3a1b6-5f88-4975-a7dd-d61426de247b	keyUse	enc
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.composite_role (composite, child_role) FROM stdin;
ecffe31a-6fff-44a9-926a-ce6f7e36da6a	ba916cde-6838-44ce-acb2-e82893a33fd0
ecffe31a-6fff-44a9-926a-ce6f7e36da6a	dc2ba403-a613-4cac-b702-8079ce085f84
ecffe31a-6fff-44a9-926a-ce6f7e36da6a	0cfaa0d5-63d4-4626-bd99-1b0d9ac407cf
ecffe31a-6fff-44a9-926a-ce6f7e36da6a	2148617a-f96c-4870-9438-ec2e62d96cf5
ecffe31a-6fff-44a9-926a-ce6f7e36da6a	df0865fe-4dd9-4c88-bcc4-01c68c60a194
ecffe31a-6fff-44a9-926a-ce6f7e36da6a	5d109568-a7da-4472-905d-ab61356e9656
ecffe31a-6fff-44a9-926a-ce6f7e36da6a	bfffeb66-112e-4aca-8003-538b69db6594
ecffe31a-6fff-44a9-926a-ce6f7e36da6a	e53fe2cf-8c86-42f7-8a81-257a6c5040ff
ecffe31a-6fff-44a9-926a-ce6f7e36da6a	ca9c23c6-da48-49c4-be4c-672f49dd22d5
ecffe31a-6fff-44a9-926a-ce6f7e36da6a	4038d862-6ab9-4f50-8854-1ae1571a04aa
ecffe31a-6fff-44a9-926a-ce6f7e36da6a	7c03a4e0-ec61-4ce8-a5f1-cfe42bf57f22
ecffe31a-6fff-44a9-926a-ce6f7e36da6a	40acd6e1-ff2d-4dba-a45d-f325addb99ff
ecffe31a-6fff-44a9-926a-ce6f7e36da6a	9f962fec-7c5b-44e0-9826-5bd295f825f7
ecffe31a-6fff-44a9-926a-ce6f7e36da6a	8e24b4fc-0f9a-490a-b6f3-b77870e1d56b
ecffe31a-6fff-44a9-926a-ce6f7e36da6a	614cac96-d488-492f-a6e6-3148af9160d2
ecffe31a-6fff-44a9-926a-ce6f7e36da6a	f0a26968-1146-4672-b220-b711e82bf9c0
ecffe31a-6fff-44a9-926a-ce6f7e36da6a	d7ab55bd-61db-42e8-bbba-9c40798417c6
ecffe31a-6fff-44a9-926a-ce6f7e36da6a	790eb8fe-ac71-4c62-9836-e55f146c3598
df0865fe-4dd9-4c88-bcc4-01c68c60a194	f0a26968-1146-4672-b220-b711e82bf9c0
2148617a-f96c-4870-9438-ec2e62d96cf5	614cac96-d488-492f-a6e6-3148af9160d2
2148617a-f96c-4870-9438-ec2e62d96cf5	790eb8fe-ac71-4c62-9836-e55f146c3598
6fcafa55-3558-4d8f-88cf-dac22124a454	e5a26119-b53c-4cd8-bd5b-79e5c3684c99
6fcafa55-3558-4d8f-88cf-dac22124a454	7b73dad7-37ac-494d-adfb-7cfccb866742
7b73dad7-37ac-494d-adfb-7cfccb866742	956caaf4-dc32-4627-be77-6e8a39c6de7c
34b86060-9fbb-43ae-b067-6e2de02e712d	73c2b7be-6d6d-4cc7-80cb-d6a90a6fbf5f
ecffe31a-6fff-44a9-926a-ce6f7e36da6a	5fa7e20c-a25e-4c8c-820b-aa095294880a
6fcafa55-3558-4d8f-88cf-dac22124a454	43327b95-aa7b-47c7-92ea-28735514f5a9
6fcafa55-3558-4d8f-88cf-dac22124a454	ee4963ea-a864-4875-88cc-6d29f962cda5
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
c5c9235e-f8c1-4daf-a25b-5b32ce4d1448	\N	password	4bd08275-2cd9-49ae-89c2-cc3efad2c890	1633787191504	\N	{"value":"0w+1RgK/WqDvzL4rWZ3eV6TIlKtgsgQxslydYn1phyFjpoOn11zDoaQBi5iWoZ7Cdc8tnHvUz+ryAAVawlOiTw==","salt":"4h0HSq4Dhs9dFdB42DqGww==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2021-10-09 13:46:21.722126	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	3787181396
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2021-10-09 13:46:21.738369	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	3787181396
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2021-10-09 13:46:21.770168	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	3787181396
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2021-10-09 13:46:21.775846	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	3787181396
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2021-10-09 13:46:21.857218	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	3787181396
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2021-10-09 13:46:21.863684	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	3787181396
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2021-10-09 13:46:22.029493	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	3787181396
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2021-10-09 13:46:22.036125	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	3787181396
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2021-10-09 13:46:22.043678	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	3787181396
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2021-10-09 13:46:22.123385	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	3787181396
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2021-10-09 13:46:22.168833	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3787181396
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2021-10-09 13:46:22.17128	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3787181396
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2021-10-09 13:46:22.186404	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3787181396
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-10-09 13:46:22.20799	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	3787181396
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-10-09 13:46:22.209902	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3787181396
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-10-09 13:46:22.211719	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	3787181396
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-10-09 13:46:22.213535	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	3787181396
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2021-10-09 13:46:22.25356	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	3787181396
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2021-10-09 13:46:22.288808	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	3787181396
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2021-10-09 13:46:22.293062	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	3787181396
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-09 13:46:23.66001	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	3787181396
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2021-10-09 13:46:22.295437	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	3787181396
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2021-10-09 13:46:22.297744	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	3787181396
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2021-10-09 13:46:22.352042	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	3787181396
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2021-10-09 13:46:22.35716	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	3787181396
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2021-10-09 13:46:22.359138	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	3787181396
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2021-10-09 13:46:22.578523	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	3787181396
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2021-10-09 13:46:22.648163	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	3787181396
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2021-10-09 13:46:22.651281	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	3787181396
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2021-10-09 13:46:22.70857	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	3787181396
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2021-10-09 13:46:22.721033	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	3787181396
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2021-10-09 13:46:22.734392	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	3787181396
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2021-10-09 13:46:22.739334	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	3787181396
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-10-09 13:46:22.743882	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3787181396
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-10-09 13:46:22.745983	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	3787181396
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-10-09 13:46:22.769827	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	3787181396
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2021-10-09 13:46:22.773881	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	3787181396
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-10-09 13:46:22.780022	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	3787181396
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2021-10-09 13:46:22.783573	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	3787181396
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2021-10-09 13:46:22.787643	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	3787181396
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-10-09 13:46:22.789879	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	3787181396
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-10-09 13:46:22.791756	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	3787181396
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2021-10-09 13:46:22.795916	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	3787181396
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-10-09 13:46:23.652128	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	3787181396
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2021-10-09 13:46:23.656135	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	3787181396
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-09 13:46:23.663804	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	3787181396
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-09 13:46:23.665508	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	3787181396
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-09 13:46:23.728742	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	3787181396
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-09 13:46:23.732527	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	3787181396
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2021-10-09 13:46:23.775495	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	3787181396
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2021-10-09 13:46:23.949486	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	3787181396
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2021-10-09 13:46:23.952943	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3787181396
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2021-10-09 13:46:23.955116	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	3787181396
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2021-10-09 13:46:23.957802	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	3787181396
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-10-09 13:46:23.964245	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	3787181396
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-10-09 13:46:23.968774	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	3787181396
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-10-09 13:46:23.997893	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	3787181396
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-10-09 13:46:24.189436	58	EXECUTED	7:6d4893e36de22369cf73bcb051ded875	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	3787181396
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2021-10-09 13:46:24.213412	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	3787181396
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2021-10-09 13:46:24.218881	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	3787181396
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-10-09 13:46:24.224511	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	3787181396
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-10-09 13:46:24.236582	62	EXECUTED	7:9ac9e58545479929ba23f4a3087a0346	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.5.4	\N	\N	3787181396
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2021-10-09 13:46:24.239898	63	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	3787181396
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2021-10-09 13:46:24.242535	64	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	3787181396
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2021-10-09 13:46:24.244915	65	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	3787181396
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2021-10-09 13:46:24.268066	66	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	3787181396
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2021-10-09 13:46:24.285417	67	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	3787181396
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2021-10-09 13:46:24.289305	68	EXECUTED	7:c7aa4c8d9573500c2d347c1941ff0301	addColumn tableName=REALM		\N	3.5.4	\N	\N	3787181396
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2021-10-09 13:46:24.308811	69	EXECUTED	7:b207faee394fc074a442ecd42185a5dd	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.5.4	\N	\N	3787181396
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2021-10-09 13:46:24.313837	70	EXECUTED	7:ab9a9762faaba4ddfa35514b212c4922	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.5.4	\N	\N	3787181396
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2021-10-09 13:46:24.31723	71	EXECUTED	7:b9710f74515a6ccb51b72dc0d19df8c4	addColumn tableName=RESOURCE_SERVER		\N	3.5.4	\N	\N	3787181396
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-09 13:46:24.322057	72	EXECUTED	7:ec9707ae4d4f0b7452fee20128083879	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	3787181396
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-09 13:46:24.326493	73	EXECUTED	7:3979a0ae07ac465e920ca696532fc736	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	3787181396
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-09 13:46:24.327925	74	MARK_RAN	7:5abfde4c259119d143bd2fbf49ac2bca	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	3787181396
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-09 13:46:24.339478	75	EXECUTED	7:b48da8c11a3d83ddd6b7d0c8c2219345	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.5.4	\N	\N	3787181396
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-09 13:46:24.36061	76	EXECUTED	7:a73379915c23bfad3e8f5c6d5c0aa4bd	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.5.4	\N	\N	3787181396
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-10-09 13:46:24.365072	77	EXECUTED	7:39e0073779aba192646291aa2332493d	addColumn tableName=CLIENT		\N	3.5.4	\N	\N	3787181396
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-10-09 13:46:24.367202	78	MARK_RAN	7:81f87368f00450799b4bf42ea0b3ec34	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	3.5.4	\N	\N	3787181396
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-10-09 13:46:24.382899	79	EXECUTED	7:20b37422abb9fb6571c618148f013a15	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	3.5.4	\N	\N	3787181396
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-10-09 13:46:24.384902	80	MARK_RAN	7:1970bb6cfb5ee800736b95ad3fb3c78a	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	3.5.4	\N	\N	3787181396
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-09 13:46:24.399896	81	EXECUTED	7:45d9b25fc3b455d522d8dcc10a0f4c80	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	3.5.4	\N	\N	3787181396
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-09 13:46:24.401622	82	MARK_RAN	7:890ae73712bc187a66c2813a724d037f	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	3787181396
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-09 13:46:24.405966	83	EXECUTED	7:0a211980d27fafe3ff50d19a3a29b538	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	3787181396
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-09 13:46:24.407732	84	MARK_RAN	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	3787181396
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-09 13:46:24.422813	85	EXECUTED	7:01c49302201bdf815b0a18d1f98a55dc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	3787181396
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2021-10-09 13:46:24.428369	86	EXECUTED	7:3dace6b144c11f53f1ad2c0361279b86	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	3.5.4	\N	\N	3787181396
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2021-10-09 13:46:24.433804	87	EXECUTED	7:578d0b92077eaf2ab95ad0ec087aa903	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	3.5.4	\N	\N	3787181396
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2021-10-09 13:46:24.442983	88	EXECUTED	7:c95abe90d962c57a09ecaee57972835d	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	3.5.4	\N	\N	3787181396
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-09 13:46:24.454573	89	EXECUTED	7:f1313bcc2994a5c4dc1062ed6d8282d3	addColumn tableName=REALM; customChange		\N	3.5.4	\N	\N	3787181396
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-09 13:46:24.46187	90	EXECUTED	7:90d763b52eaffebefbcbde55f269508b	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	3.5.4	\N	\N	3787181396
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-09 13:46:24.48498	91	EXECUTED	7:d554f0cb92b764470dccfa5e0014a7dd	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3787181396
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-09 13:46:24.490949	92	EXECUTED	7:73193e3ab3c35cf0f37ccea3bf783764	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	3.5.4	\N	\N	3787181396
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-09 13:46:24.492838	93	MARK_RAN	7:90a1e74f92e9cbaa0c5eab80b8a037f3	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	3787181396
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-09 13:46:24.500398	94	EXECUTED	7:5b9248f29cd047c200083cc6d8388b16	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	3787181396
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-09 13:46:24.502234	95	MARK_RAN	7:64db59e44c374f13955489e8990d17a1	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	3.5.4	\N	\N	3787181396
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-09 13:46:24.50609	96	EXECUTED	7:329a578cdb43262fff975f0a7f6cda60	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	3.5.4	\N	\N	3787181396
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-09 13:46:24.552206	97	EXECUTED	7:fae0de241ac0fd0bbc2b380b85e4f567	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3787181396
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-09 13:46:24.554116	98	MARK_RAN	7:075d54e9180f49bb0c64ca4218936e81	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3787181396
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-09 13:46:24.561761	99	MARK_RAN	7:06499836520f4f6b3d05e35a59324910	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3787181396
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-09 13:46:24.583268	100	EXECUTED	7:fad08e83c77d0171ec166bc9bc5d390a	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3787181396
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-09 13:46:24.585191	101	MARK_RAN	7:3d2b23076e59c6f70bae703aa01be35b	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3787181396
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-09 13:46:24.603222	102	EXECUTED	7:1a7f28ff8d9e53aeb879d76ea3d9341a	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	3.5.4	\N	\N	3787181396
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-09 13:46:24.606613	103	EXECUTED	7:2fd554456fed4a82c698c555c5b751b6	customChange		\N	3.5.4	\N	\N	3787181396
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2021-10-09 13:46:24.610852	104	EXECUTED	7:b06356d66c2790ecc2ae54ba0458397a	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	3.5.4	\N	\N	3787181396
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	db631faf-d9a1-4f66-9dac-76b1a12e8823	f
master	93a6d859-8e75-4d99-aac1-3676a97ec616	t
master	956783e9-4e39-462a-b7f1-ae540b5429cc	t
master	9fc7d656-dd86-4e9e-b491-507c53182ba8	t
master	00c7a8a6-5d69-4fb2-b660-740d7b2d149e	f
master	c84d9841-6d72-42f9-b285-e9b644b573a1	f
master	f35fa060-6d8b-4100-b99d-2533543897c6	t
master	866a0dcf-ff7f-4679-9972-2a905eb52056	t
master	f1c284bc-0602-4edb-bc20-42862a2ee5a7	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
6fcafa55-3558-4d8f-88cf-dac22124a454	master	f	${role_default-roles}	default-roles-master	master	\N	\N
ecffe31a-6fff-44a9-926a-ce6f7e36da6a	master	f	${role_admin}	admin	master	\N	\N
ba916cde-6838-44ce-acb2-e82893a33fd0	master	f	${role_create-realm}	create-realm	master	\N	\N
dc2ba403-a613-4cac-b702-8079ce085f84	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	t	${role_create-client}	create-client	master	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	\N
0cfaa0d5-63d4-4626-bd99-1b0d9ac407cf	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	t	${role_view-realm}	view-realm	master	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	\N
2148617a-f96c-4870-9438-ec2e62d96cf5	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	t	${role_view-users}	view-users	master	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	\N
df0865fe-4dd9-4c88-bcc4-01c68c60a194	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	t	${role_view-clients}	view-clients	master	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	\N
5d109568-a7da-4472-905d-ab61356e9656	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	t	${role_view-events}	view-events	master	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	\N
bfffeb66-112e-4aca-8003-538b69db6594	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	t	${role_view-identity-providers}	view-identity-providers	master	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	\N
e53fe2cf-8c86-42f7-8a81-257a6c5040ff	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	t	${role_view-authorization}	view-authorization	master	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	\N
ca9c23c6-da48-49c4-be4c-672f49dd22d5	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	t	${role_manage-realm}	manage-realm	master	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	\N
4038d862-6ab9-4f50-8854-1ae1571a04aa	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	t	${role_manage-users}	manage-users	master	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	\N
7c03a4e0-ec61-4ce8-a5f1-cfe42bf57f22	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	t	${role_manage-clients}	manage-clients	master	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	\N
40acd6e1-ff2d-4dba-a45d-f325addb99ff	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	t	${role_manage-events}	manage-events	master	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	\N
9f962fec-7c5b-44e0-9826-5bd295f825f7	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	t	${role_manage-identity-providers}	manage-identity-providers	master	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	\N
8e24b4fc-0f9a-490a-b6f3-b77870e1d56b	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	t	${role_manage-authorization}	manage-authorization	master	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	\N
614cac96-d488-492f-a6e6-3148af9160d2	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	t	${role_query-users}	query-users	master	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	\N
f0a26968-1146-4672-b220-b711e82bf9c0	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	t	${role_query-clients}	query-clients	master	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	\N
d7ab55bd-61db-42e8-bbba-9c40798417c6	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	t	${role_query-realms}	query-realms	master	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	\N
790eb8fe-ac71-4c62-9836-e55f146c3598	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	t	${role_query-groups}	query-groups	master	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	\N
e5a26119-b53c-4cd8-bd5b-79e5c3684c99	891ad587-fbef-4860-8577-aab2c62879ca	t	${role_view-profile}	view-profile	master	891ad587-fbef-4860-8577-aab2c62879ca	\N
7b73dad7-37ac-494d-adfb-7cfccb866742	891ad587-fbef-4860-8577-aab2c62879ca	t	${role_manage-account}	manage-account	master	891ad587-fbef-4860-8577-aab2c62879ca	\N
956caaf4-dc32-4627-be77-6e8a39c6de7c	891ad587-fbef-4860-8577-aab2c62879ca	t	${role_manage-account-links}	manage-account-links	master	891ad587-fbef-4860-8577-aab2c62879ca	\N
c3735454-2b99-414a-b0e9-c21a95709682	891ad587-fbef-4860-8577-aab2c62879ca	t	${role_view-applications}	view-applications	master	891ad587-fbef-4860-8577-aab2c62879ca	\N
73c2b7be-6d6d-4cc7-80cb-d6a90a6fbf5f	891ad587-fbef-4860-8577-aab2c62879ca	t	${role_view-consent}	view-consent	master	891ad587-fbef-4860-8577-aab2c62879ca	\N
34b86060-9fbb-43ae-b067-6e2de02e712d	891ad587-fbef-4860-8577-aab2c62879ca	t	${role_manage-consent}	manage-consent	master	891ad587-fbef-4860-8577-aab2c62879ca	\N
e7f476cb-b659-41bc-b8c9-bc0f403b9214	891ad587-fbef-4860-8577-aab2c62879ca	t	${role_delete-account}	delete-account	master	891ad587-fbef-4860-8577-aab2c62879ca	\N
e84e5a36-4ad1-43ee-91ac-2958f5f85765	8ad62a0b-9544-496b-9d4f-7ec95ddfa389	t	${role_read-token}	read-token	master	8ad62a0b-9544-496b-9d4f-7ec95ddfa389	\N
5fa7e20c-a25e-4c8c-820b-aa095294880a	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	t	${role_impersonation}	impersonation	master	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	\N
43327b95-aa7b-47c7-92ea-28735514f5a9	master	f	${role_offline-access}	offline_access	master	\N	\N
ee4963ea-a864-4875-88cc-6d29f962cda5	master	f	${role_uma_authorization}	uma_authorization	master	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration_model (id, version, update_time) FROM stdin;
t3npe	15.0.2	1633787188
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
db64ba6b-8922-4241-b504-79c2411b92de	audience resolve	openid-connect	oidc-audience-resolve-mapper	7f92e756-c626-4df4-a1ff-516e5bc0df21	\N
79ebbdb2-4e0c-4125-841a-ddab536c06e4	locale	openid-connect	oidc-usermodel-attribute-mapper	66b9bbea-7feb-49f9-9bc4-c62d6c7198b5	\N
febc5088-bb78-4ed1-a719-ec996ad8419f	role list	saml	saml-role-list-mapper	\N	93a6d859-8e75-4d99-aac1-3676a97ec616
04e82796-06de-4c00-ab0f-b86e38c255a9	full name	openid-connect	oidc-full-name-mapper	\N	956783e9-4e39-462a-b7f1-ae540b5429cc
6e307a27-f751-48f4-bc49-da5a1a1434af	family name	openid-connect	oidc-usermodel-property-mapper	\N	956783e9-4e39-462a-b7f1-ae540b5429cc
d12a2848-5f9d-429a-8c7b-cd40c01231dc	given name	openid-connect	oidc-usermodel-property-mapper	\N	956783e9-4e39-462a-b7f1-ae540b5429cc
54a23284-5221-4b87-9b82-3d5fa9f0da73	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	956783e9-4e39-462a-b7f1-ae540b5429cc
cd68d744-4768-40e3-926e-309f4d835870	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	956783e9-4e39-462a-b7f1-ae540b5429cc
fea5a993-76a8-4b65-9936-673d9fde718d	username	openid-connect	oidc-usermodel-property-mapper	\N	956783e9-4e39-462a-b7f1-ae540b5429cc
917887ac-3222-420b-a091-0c223294c464	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	956783e9-4e39-462a-b7f1-ae540b5429cc
5ec4ceb9-3dc7-4249-983a-5756ce015f1d	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	956783e9-4e39-462a-b7f1-ae540b5429cc
8ffaf69d-a57e-4208-b888-70cdc486dea1	website	openid-connect	oidc-usermodel-attribute-mapper	\N	956783e9-4e39-462a-b7f1-ae540b5429cc
ddf363c5-b0db-46ae-a64e-6937bb0b7297	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	956783e9-4e39-462a-b7f1-ae540b5429cc
d24ebdfe-e393-44d6-9a01-f273cc49d301	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	956783e9-4e39-462a-b7f1-ae540b5429cc
fbe7abbb-ed71-4662-83d2-ed5942523c0f	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	956783e9-4e39-462a-b7f1-ae540b5429cc
f9e7cdef-6ec6-4d4d-a883-1445a0ed0563	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	956783e9-4e39-462a-b7f1-ae540b5429cc
81dd3c83-9b8d-4f6c-bb6d-38a9c4f8b465	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	956783e9-4e39-462a-b7f1-ae540b5429cc
cb342b51-e5a6-4b34-acb0-38dc3b7b421a	email	openid-connect	oidc-usermodel-property-mapper	\N	9fc7d656-dd86-4e9e-b491-507c53182ba8
c837d84c-0910-42e1-9856-5972318fa9d9	email verified	openid-connect	oidc-usermodel-property-mapper	\N	9fc7d656-dd86-4e9e-b491-507c53182ba8
5fbddd05-583c-44b4-b51e-795c3fbd74ba	address	openid-connect	oidc-address-mapper	\N	00c7a8a6-5d69-4fb2-b660-740d7b2d149e
cd6555bc-6480-413d-beeb-f344afea3f40	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	c84d9841-6d72-42f9-b285-e9b644b573a1
13a84d51-12c3-4f1b-9ce5-259f764eb0fd	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	c84d9841-6d72-42f9-b285-e9b644b573a1
256949c5-7ce5-4541-994d-102709f679de	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	f35fa060-6d8b-4100-b99d-2533543897c6
a9f3667d-7c9d-48d4-8eaa-c014b730583c	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	f35fa060-6d8b-4100-b99d-2533543897c6
3d1fd798-fdbc-475f-8ff3-b85c9339703c	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	f35fa060-6d8b-4100-b99d-2533543897c6
3fa3668b-78c7-44f0-ad96-dbb1c6a5ee11	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	866a0dcf-ff7f-4679-9972-2a905eb52056
12e07e8f-331c-48ee-8509-a593f4f95854	upn	openid-connect	oidc-usermodel-property-mapper	\N	f1c284bc-0602-4edb-bc20-42862a2ee5a7
138b5561-4591-4382-8f4d-8bec774307b6	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	f1c284bc-0602-4edb-bc20-42862a2ee5a7
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
79ebbdb2-4e0c-4125-841a-ddab536c06e4	true	userinfo.token.claim
79ebbdb2-4e0c-4125-841a-ddab536c06e4	locale	user.attribute
79ebbdb2-4e0c-4125-841a-ddab536c06e4	true	id.token.claim
79ebbdb2-4e0c-4125-841a-ddab536c06e4	true	access.token.claim
79ebbdb2-4e0c-4125-841a-ddab536c06e4	locale	claim.name
79ebbdb2-4e0c-4125-841a-ddab536c06e4	String	jsonType.label
febc5088-bb78-4ed1-a719-ec996ad8419f	false	single
febc5088-bb78-4ed1-a719-ec996ad8419f	Basic	attribute.nameformat
febc5088-bb78-4ed1-a719-ec996ad8419f	Role	attribute.name
04e82796-06de-4c00-ab0f-b86e38c255a9	true	userinfo.token.claim
04e82796-06de-4c00-ab0f-b86e38c255a9	true	id.token.claim
04e82796-06de-4c00-ab0f-b86e38c255a9	true	access.token.claim
6e307a27-f751-48f4-bc49-da5a1a1434af	true	userinfo.token.claim
6e307a27-f751-48f4-bc49-da5a1a1434af	lastName	user.attribute
6e307a27-f751-48f4-bc49-da5a1a1434af	true	id.token.claim
6e307a27-f751-48f4-bc49-da5a1a1434af	true	access.token.claim
6e307a27-f751-48f4-bc49-da5a1a1434af	family_name	claim.name
6e307a27-f751-48f4-bc49-da5a1a1434af	String	jsonType.label
d12a2848-5f9d-429a-8c7b-cd40c01231dc	true	userinfo.token.claim
d12a2848-5f9d-429a-8c7b-cd40c01231dc	firstName	user.attribute
d12a2848-5f9d-429a-8c7b-cd40c01231dc	true	id.token.claim
d12a2848-5f9d-429a-8c7b-cd40c01231dc	true	access.token.claim
d12a2848-5f9d-429a-8c7b-cd40c01231dc	given_name	claim.name
d12a2848-5f9d-429a-8c7b-cd40c01231dc	String	jsonType.label
54a23284-5221-4b87-9b82-3d5fa9f0da73	true	userinfo.token.claim
54a23284-5221-4b87-9b82-3d5fa9f0da73	middleName	user.attribute
54a23284-5221-4b87-9b82-3d5fa9f0da73	true	id.token.claim
54a23284-5221-4b87-9b82-3d5fa9f0da73	true	access.token.claim
54a23284-5221-4b87-9b82-3d5fa9f0da73	middle_name	claim.name
54a23284-5221-4b87-9b82-3d5fa9f0da73	String	jsonType.label
cd68d744-4768-40e3-926e-309f4d835870	true	userinfo.token.claim
cd68d744-4768-40e3-926e-309f4d835870	nickname	user.attribute
cd68d744-4768-40e3-926e-309f4d835870	true	id.token.claim
cd68d744-4768-40e3-926e-309f4d835870	true	access.token.claim
cd68d744-4768-40e3-926e-309f4d835870	nickname	claim.name
cd68d744-4768-40e3-926e-309f4d835870	String	jsonType.label
fea5a993-76a8-4b65-9936-673d9fde718d	true	userinfo.token.claim
fea5a993-76a8-4b65-9936-673d9fde718d	username	user.attribute
fea5a993-76a8-4b65-9936-673d9fde718d	true	id.token.claim
fea5a993-76a8-4b65-9936-673d9fde718d	true	access.token.claim
fea5a993-76a8-4b65-9936-673d9fde718d	preferred_username	claim.name
fea5a993-76a8-4b65-9936-673d9fde718d	String	jsonType.label
917887ac-3222-420b-a091-0c223294c464	true	userinfo.token.claim
917887ac-3222-420b-a091-0c223294c464	profile	user.attribute
917887ac-3222-420b-a091-0c223294c464	true	id.token.claim
917887ac-3222-420b-a091-0c223294c464	true	access.token.claim
917887ac-3222-420b-a091-0c223294c464	profile	claim.name
917887ac-3222-420b-a091-0c223294c464	String	jsonType.label
5ec4ceb9-3dc7-4249-983a-5756ce015f1d	true	userinfo.token.claim
5ec4ceb9-3dc7-4249-983a-5756ce015f1d	picture	user.attribute
5ec4ceb9-3dc7-4249-983a-5756ce015f1d	true	id.token.claim
5ec4ceb9-3dc7-4249-983a-5756ce015f1d	true	access.token.claim
5ec4ceb9-3dc7-4249-983a-5756ce015f1d	picture	claim.name
5ec4ceb9-3dc7-4249-983a-5756ce015f1d	String	jsonType.label
8ffaf69d-a57e-4208-b888-70cdc486dea1	true	userinfo.token.claim
8ffaf69d-a57e-4208-b888-70cdc486dea1	website	user.attribute
8ffaf69d-a57e-4208-b888-70cdc486dea1	true	id.token.claim
8ffaf69d-a57e-4208-b888-70cdc486dea1	true	access.token.claim
8ffaf69d-a57e-4208-b888-70cdc486dea1	website	claim.name
8ffaf69d-a57e-4208-b888-70cdc486dea1	String	jsonType.label
ddf363c5-b0db-46ae-a64e-6937bb0b7297	true	userinfo.token.claim
ddf363c5-b0db-46ae-a64e-6937bb0b7297	gender	user.attribute
ddf363c5-b0db-46ae-a64e-6937bb0b7297	true	id.token.claim
ddf363c5-b0db-46ae-a64e-6937bb0b7297	true	access.token.claim
ddf363c5-b0db-46ae-a64e-6937bb0b7297	gender	claim.name
ddf363c5-b0db-46ae-a64e-6937bb0b7297	String	jsonType.label
d24ebdfe-e393-44d6-9a01-f273cc49d301	true	userinfo.token.claim
d24ebdfe-e393-44d6-9a01-f273cc49d301	birthdate	user.attribute
d24ebdfe-e393-44d6-9a01-f273cc49d301	true	id.token.claim
d24ebdfe-e393-44d6-9a01-f273cc49d301	true	access.token.claim
d24ebdfe-e393-44d6-9a01-f273cc49d301	birthdate	claim.name
d24ebdfe-e393-44d6-9a01-f273cc49d301	String	jsonType.label
fbe7abbb-ed71-4662-83d2-ed5942523c0f	true	userinfo.token.claim
fbe7abbb-ed71-4662-83d2-ed5942523c0f	zoneinfo	user.attribute
fbe7abbb-ed71-4662-83d2-ed5942523c0f	true	id.token.claim
fbe7abbb-ed71-4662-83d2-ed5942523c0f	true	access.token.claim
fbe7abbb-ed71-4662-83d2-ed5942523c0f	zoneinfo	claim.name
fbe7abbb-ed71-4662-83d2-ed5942523c0f	String	jsonType.label
f9e7cdef-6ec6-4d4d-a883-1445a0ed0563	true	userinfo.token.claim
f9e7cdef-6ec6-4d4d-a883-1445a0ed0563	locale	user.attribute
f9e7cdef-6ec6-4d4d-a883-1445a0ed0563	true	id.token.claim
f9e7cdef-6ec6-4d4d-a883-1445a0ed0563	true	access.token.claim
f9e7cdef-6ec6-4d4d-a883-1445a0ed0563	locale	claim.name
f9e7cdef-6ec6-4d4d-a883-1445a0ed0563	String	jsonType.label
81dd3c83-9b8d-4f6c-bb6d-38a9c4f8b465	true	userinfo.token.claim
81dd3c83-9b8d-4f6c-bb6d-38a9c4f8b465	updatedAt	user.attribute
81dd3c83-9b8d-4f6c-bb6d-38a9c4f8b465	true	id.token.claim
81dd3c83-9b8d-4f6c-bb6d-38a9c4f8b465	true	access.token.claim
81dd3c83-9b8d-4f6c-bb6d-38a9c4f8b465	updated_at	claim.name
81dd3c83-9b8d-4f6c-bb6d-38a9c4f8b465	String	jsonType.label
cb342b51-e5a6-4b34-acb0-38dc3b7b421a	true	userinfo.token.claim
cb342b51-e5a6-4b34-acb0-38dc3b7b421a	email	user.attribute
cb342b51-e5a6-4b34-acb0-38dc3b7b421a	true	id.token.claim
cb342b51-e5a6-4b34-acb0-38dc3b7b421a	true	access.token.claim
cb342b51-e5a6-4b34-acb0-38dc3b7b421a	email	claim.name
cb342b51-e5a6-4b34-acb0-38dc3b7b421a	String	jsonType.label
c837d84c-0910-42e1-9856-5972318fa9d9	true	userinfo.token.claim
c837d84c-0910-42e1-9856-5972318fa9d9	emailVerified	user.attribute
c837d84c-0910-42e1-9856-5972318fa9d9	true	id.token.claim
c837d84c-0910-42e1-9856-5972318fa9d9	true	access.token.claim
c837d84c-0910-42e1-9856-5972318fa9d9	email_verified	claim.name
c837d84c-0910-42e1-9856-5972318fa9d9	boolean	jsonType.label
5fbddd05-583c-44b4-b51e-795c3fbd74ba	formatted	user.attribute.formatted
5fbddd05-583c-44b4-b51e-795c3fbd74ba	country	user.attribute.country
5fbddd05-583c-44b4-b51e-795c3fbd74ba	postal_code	user.attribute.postal_code
5fbddd05-583c-44b4-b51e-795c3fbd74ba	true	userinfo.token.claim
5fbddd05-583c-44b4-b51e-795c3fbd74ba	street	user.attribute.street
5fbddd05-583c-44b4-b51e-795c3fbd74ba	true	id.token.claim
5fbddd05-583c-44b4-b51e-795c3fbd74ba	region	user.attribute.region
5fbddd05-583c-44b4-b51e-795c3fbd74ba	true	access.token.claim
5fbddd05-583c-44b4-b51e-795c3fbd74ba	locality	user.attribute.locality
cd6555bc-6480-413d-beeb-f344afea3f40	true	userinfo.token.claim
cd6555bc-6480-413d-beeb-f344afea3f40	phoneNumber	user.attribute
cd6555bc-6480-413d-beeb-f344afea3f40	true	id.token.claim
cd6555bc-6480-413d-beeb-f344afea3f40	true	access.token.claim
cd6555bc-6480-413d-beeb-f344afea3f40	phone_number	claim.name
cd6555bc-6480-413d-beeb-f344afea3f40	String	jsonType.label
13a84d51-12c3-4f1b-9ce5-259f764eb0fd	true	userinfo.token.claim
13a84d51-12c3-4f1b-9ce5-259f764eb0fd	phoneNumberVerified	user.attribute
13a84d51-12c3-4f1b-9ce5-259f764eb0fd	true	id.token.claim
13a84d51-12c3-4f1b-9ce5-259f764eb0fd	true	access.token.claim
13a84d51-12c3-4f1b-9ce5-259f764eb0fd	phone_number_verified	claim.name
13a84d51-12c3-4f1b-9ce5-259f764eb0fd	boolean	jsonType.label
256949c5-7ce5-4541-994d-102709f679de	true	multivalued
256949c5-7ce5-4541-994d-102709f679de	foo	user.attribute
256949c5-7ce5-4541-994d-102709f679de	true	access.token.claim
256949c5-7ce5-4541-994d-102709f679de	realm_access.roles	claim.name
256949c5-7ce5-4541-994d-102709f679de	String	jsonType.label
a9f3667d-7c9d-48d4-8eaa-c014b730583c	true	multivalued
a9f3667d-7c9d-48d4-8eaa-c014b730583c	foo	user.attribute
a9f3667d-7c9d-48d4-8eaa-c014b730583c	true	access.token.claim
a9f3667d-7c9d-48d4-8eaa-c014b730583c	resource_access.${client_id}.roles	claim.name
a9f3667d-7c9d-48d4-8eaa-c014b730583c	String	jsonType.label
12e07e8f-331c-48ee-8509-a593f4f95854	true	userinfo.token.claim
12e07e8f-331c-48ee-8509-a593f4f95854	username	user.attribute
12e07e8f-331c-48ee-8509-a593f4f95854	true	id.token.claim
12e07e8f-331c-48ee-8509-a593f4f95854	true	access.token.claim
12e07e8f-331c-48ee-8509-a593f4f95854	upn	claim.name
12e07e8f-331c-48ee-8509-a593f4f95854	String	jsonType.label
138b5561-4591-4382-8f4d-8bec774307b6	true	multivalued
138b5561-4591-4382-8f4d-8bec774307b6	foo	user.attribute
138b5561-4591-4382-8f4d-8bec774307b6	true	id.token.claim
138b5561-4591-4382-8f4d-8bec774307b6	true	access.token.claim
138b5561-4591-4382-8f4d-8bec774307b6	groups	claim.name
138b5561-4591-4382-8f4d-8bec774307b6	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	d301aa15-e0ef-4e80-8228-4bdff33e0ce5	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	5465cf33-5404-489f-982f-3b1fe80176c9	d781011c-4d89-4bf7-a217-1126cbc4ad5a	ee04db18-2a1e-4c00-bcd2-f4cb7115ce2a	406c89e1-cbca-4401-b571-8f1c950cb53d	79a2a2ff-66b7-478a-9081-6fa9a2f4fa07	2592000	f	900	t	f	1b8aeab0-2c57-48d4-9b4b-eff647333da6	0	f	0	0	6fcafa55-3558-4d8f-88cf-dac22124a454
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	master	
_browser_header.xContentTypeOptions	master	nosniff
_browser_header.xRobotsTag	master	none
_browser_header.xFrameOptions	master	SAMEORIGIN
_browser_header.contentSecurityPolicy	master	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	master	1; mode=block
_browser_header.strictTransportSecurity	master	max-age=31536000; includeSubDomains
bruteForceProtected	master	false
permanentLockout	master	false
maxFailureWaitSeconds	master	900
minimumQuickLoginWaitSeconds	master	60
waitIncrementSeconds	master	60
quickLoginCheckMilliSeconds	master	1000
maxDeltaTimeSeconds	master	43200
failureFactor	master	30
displayName	master	Keycloak
displayNameHtml	master	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	master	RS256
offlineSessionMaxLifespanEnabled	master	false
offlineSessionMaxLifespan	master	5184000
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.redirect_uris (client_id, value) FROM stdin;
891ad587-fbef-4860-8577-aab2c62879ca	/realms/master/account/*
7f92e756-c626-4df4-a1ff-516e5bc0df21	/realms/master/account/*
66b9bbea-7feb-49f9-9bc4-c62d6c7198b5	/admin/master/console/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
9f7d1d9e-c4c7-4f6d-989b-c283aac49679	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
cb39032c-07ed-4d41-b1d1-eb726c99dc5f	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
3ae34d33-27d8-438c-b8c0-3223e45178d2	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
c5cca79c-adab-4428-adec-8979ed596c89	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
f602229c-91a3-4837-a647-defccdbbc453	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
6135e932-be79-4d07-a235-d33e5c1e2d43	update_user_locale	Update User Locale	master	t	f	update_user_locale	1000
50ebb1c6-36b7-475e-9cfb-8b8806f98ef2	delete_account	Delete Account	master	f	f	delete_account	60
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
7f92e756-c626-4df4-a1ff-516e5bc0df21	7b73dad7-37ac-494d-adfb-7cfccb866742
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
4bd08275-2cd9-49ae-89c2-cc3efad2c890	\N	8fd6cee3-fe3e-4434-af7f-e69d99402a5b	f	t	\N	\N	\N	master	user	1633787191392	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
6fcafa55-3558-4d8f-88cf-dac22124a454	4bd08275-2cd9-49ae-89c2-cc3efad2c890
ecffe31a-6fff-44a9-926a-ce6f7e36da6a	4bd08275-2cd9-49ae-89c2-cc3efad2c890
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_origins (client_id, value) FROM stdin;
66b9bbea-7feb-49f9-9bc4-c62d6c7198b5	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

