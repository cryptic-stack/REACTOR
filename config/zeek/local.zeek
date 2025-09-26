##! Local site policy for Zeek REACTOR setup

redef ignore_checksums = T;

# Load the base policies
@load base/frameworks/logging
@load base/frameworks/notice
@load base/frameworks/analyzer

# Protocol analysis
@load base/protocols/conn
@load base/protocols/dns
@load base/protocols/http
@load base/protocols/ssl
@load base/protocols/ssh
@load base/protocols/smtp
@load base/protocols/ftp
@load base/protocols/dhcp

# File analysis
@load base/files/hash
@load base/files/pe
@load base/files/x509

# Detection frameworks
@load base/frameworks/intel
@load base/frameworks/notice/actions/drop

# Security-focused policies
@load policy/frameworks/intel/seen
@load policy/frameworks/intel/do_notice
@load policy/integration/barnyard2
@load policy/tuning/json-logs

# Custom logging format
@load tuning/json-logs

# Network scanning detection
@load policy/misc/scan

# Log to JSON format
redef LogAscii::use_json = T;

# Configure Intel framework
redef Intel::read_files += {
    "/opt/zeek/share/zeek/intel/reactor-intel.txt"
};

# Notice configuration
redef Notice::policy += {
    [$pred(n: Notice::Info) = { return n$note == Scan::Port_Scan; },
     $action = Notice::ACTION_EMAIL,
     $email_dest = "admin@reactor.local",
     $email_body_sections = vector(Notice::ACTION_EMAIL_BODY_TRACKING)],
};

# HTTP monitoring
redef HTTP::default_capture_password = T;

# SSL/TLS monitoring
redef SSL::disable_analyzer_after_detection = F;

# DNS monitoring
redef DNS::log_client = T;

# File extraction
redef FileExtract::prefix = "/opt/zeek/extracted/";
redef FileExtract::default_limit = 10485760;