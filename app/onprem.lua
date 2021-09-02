-- Utility functions for fetching environment variables
local function is_empty(string_value)
    return string_value == nil or string_value == ""
end

local function trim(string_value)
    return string.gsub(string_value, "%s+", "")
end

local function get_env(env_name)
    local value = os.getenv(env_name)
    if is_empty(value) then
        return nil
    end

    return trim(tostring(value))
end

local function get_env_string(env_name, default_value)
    local env_value = get_env(env_name)
    if env_value == nil then
        return default_value
    end

    return env_value
end

local function get_env_boolean(env_name, default_value)
    local env_value = get_env(env_name)
    if env_value == nil then
        return default_value
    end

    return string.lower(env_value) == "true"
end

local function get_env_number(env_name, default_value)
    local env_value = get_env(env_name)
    if env_value == nil then
        return default_value
    end

    local env_value_number = tonumber(env_value)
    if env_value_number == nil then
        return default_value
    end

    return env_value_number
end

-- App initialization
box.cfg {
    background = get_env_boolean("APP_BACKGROUND", true),
    listen = get_env_number("APP_LISTEN", 3301),
    pid_file = get_env_string("APP_PID_FILE", "/dewt/tarantool.pid"),
    memtx_dir = get_env_string("APP_MEMTX_DIR", "/dewt/data"),
    wal_dir = get_env_string("APP_WAL_DIR", "/dewt/data"),
    vinyl_dir = get_env_string("APP_VINYL_DIR", "/dewt/data"),
    work_dir = get_env_string("APP_WORK_DIR", "/dewt/app"),
    log = get_env_string("APP_LOG", "/dewt/logs/log.txt"),
    memtx_memory = get_env_number("APP_MEMTX_MEMORY", 512 * 1024 * 1024),
    checkpoint_interval = get_env_number("APP_CHECKPOINT_INTERVAL", 7200),
    custom_proc_title = get_env_string("APP_CUSTOM_PROC_TITLE", "drakonhub_onprem")
}

global_cfg = {
    db = get_env_string("APP_DB", "tardb"),

    --db = "mysqldb",
    mysql = {
        host = get_env_string("APP_MYSQL_HOST", "127.0.0.1"),
        db = get_env_string("APP_MYSQL_DB", "drakonhub"),
        user = get_env_string("APP_MYSQL_USER", "tara"),
        password = get_env_string("APP_MYSQL_PASSWORD", "123456"),
        size = get_env_number("APP_MYSQL_SIZE", 5)
    },
    diatest = get_env_string("APP_DIATEST", "/dewt/diatest"),
    host = get_env_string("APP_HOST", "127.0.0.1"),
    port = get_env_number("APP_PORT", 8090),
    http_options = {
        log_requests = get_env_boolean("APP_HTTP_OPTIONS_LOG_REQUESTS", false)
    },
    session_timeout = get_env_number("APP_SESSION_TIMEOUT", 10 * 24 * 3600),
    static_timeout = get_env_number("APP_STATIC_TIMEOUT", 1 * 3600),
    file_timeout = get_env_number("APP_FILE_TIMEOUT", 2),
    static_dir = get_env_string("APP_STATIC_DIR", "/dewt/static"),
    emails_dir = get_env_string("APP_EMAILS_DIR", "/dewt/emails"),
    feedback_dir = get_env_string("APP_FEEDBACK_DIR", "/dewt/feedback"),
    journal_dir = get_env_string("APP_JOURNAL_DIR", "/dewt/journal"),
    content_dir = get_env_string("APP_CONTENT_DIR", "/dewt/content"),
    read_dir = get_env_string("APP_READ_DIR", "/dewt/read"),
    files = get_env_string("APP_FILES_DIR", "/dewt/files"),
    password_timeout = get_env_number("APP_PASSWORD_TIMEOUT", 5),
    use_capture = get_env_boolean("APP_USE_CAPTURE", false),
    max_recent = get_env_number("APP_MAX_RECENT", 20),
    max_log = get_env_number("APP_MAX_LOG", 50000),
    tmp = get_env_string("APP_TMP", "/dewt/tmp"),
    debug_mail = get_env_boolean("APP_DEBUG_MAIL", false),
    feedback_email = get_env_string("APP_FEEDBACK_EMAIL", "bad@example.com"),
    create_license = get_env_string("APP_CREATE_LICENSE", "extended"),
    licensing = get_env_boolean("APP_LICENSING", true),
    https_sender_port = get_env_boolean("APP_HTTPS_SENDER_PORT", 3400),
    google_anal = get_env_boolean("APP_GOOGLE_ANAL", false),
    my_site = get_env_string("APP_MY_SITE", "https://127.0.0.1"),
    my_domain = get_env_string("APP_MY_DOMAIN", "127.0.0.1"),
    my_ip = my_ip,
    complete_delay = get_env_number("APP_COMPLETE_DELAY", 2),
    on_premises = get_env_boolean("APP_ON_PREMISES", true),
    application = get_env_string("APPLICATION", "DrakonHub"),
    insecure_cookie = get_env_boolean("APP_INSECURE_COOKIE", false),
    mg = get_env_boolean("APP_MG", false),
    mg_domain = get_env_string("APP_MG_DOMAIN", nil)
}

external_creds = require("external_creds")

-- Mailgun
local mg_key = get_env_string("APP_MG_KEY", nil)
if mg_key ~= nil then
    external_creds.mg_key = mg_key
end

require("init")
