
box.cfg {
	background = true,
	listen = 3301,
	pid_file = "/dewt/tarantool.pid",
	memtx_dir = "/dewt/data",
	wal_dir = "/dewt/data",
	vinyl_dir = "/dewt/data",
	work_dir = "/dewt/app",
	log = "/dewt/logs/log.txt",
	memtx_memory = 512 * 1024 *1024,
	checkpoint_interval = 7200,
	custom_proc_title = "drakonhub_onprem"
}

global_cfg = {
	db = "tardb",
	--db = "mysqldb",
	mysql = {
		host = "127.0.0.1",
		db = "drakonhub",
		user = "tara",
		password = "123456",	
		size = 5
	},
	diatest = "/dewt/diatest",
	host = os.getenv("HOST"),
	port = 8090,
	http_options = {
		log_requests = false
	},	
	session_timeout = 10 * 24 * 3600,
	static_timeout = 1 * 3600,
	file_timeout = 2,
	static_dir = "/dewt/static",
	emails_dir = "/dewt/emails",
	feedback_dir = "/dewt/feedback",
	journal_dir = "/dewt/journal",
	content_dir = "/dewt/content",
	read_dir = "/dewt/read",	
	password_timeout = 5,
	use_capture = false,
	max_recent = 20,
	max_log = 50000,
	tmp = "/dewt/tmp",
	debug_mail = false,
	feedback_email = "bad@example.com",
	create_license = "extended",
	licensing = true,
	https_sender_port = 3400,
	google_anal = false,
	my_site = os.getenv("MY_SITE"),
	my_domain = os.getenv("MY_DOMAIN"),
	my_ip = my_ip,
	complete_delay = 2,
	on_premises = true,
	application = "DrakonHub",
	insecure_cookie = os.getenv("INSECURE_COOKIE") == "true"
}

external_creds = require("external_creds")
require("init")


