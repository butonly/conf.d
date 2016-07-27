Embedded Variables
==================

### ngx_http_core_module

The `ngx_http_core_module` module supports embedded variables with names matching the Apache Server variables. First of all, these are variables representing client request header fields, such as * $http_user_agent, * $http_cookie, and so on. Also there are other variables:

* $arg_name

argument name in the request line

* $args

arguments in the request line

* $binary_remote_addr

client address in a binary form, value’s length is always 4 bytes for IPv4 addresses or 16 bytes for IPv6 addresses

* $body_bytes_sent

number of bytes sent to a client, not counting the response header; this variable is compatible with the “%B” parameter of the mod_log_config Apache module

* $bytes_sent

number of bytes sent to a client (1.3.8, 1.2.5)

* $connection

connection serial number (1.3.8, 1.2.5)

* $connection_requests

current number of requests made through a connection (1.3.8, 1.2.5)

* $content_length

“Content-Length” request header field

* $content_type

“Content-Type” request header field

* $cookie_name

the name cookie

* $document_root

root or alias directive’s value for the current request

* $document_uri

same as * $uri

* $host

in this order of precedence: host name from the request line, or host name from the “Host” request header field, or the server name matching a request

* $hostname

host name

* $http_name

arbitrary request header field; the last part of a variable name is the field name converted to lower case with dashes replaced by underscores

* $https

“on” if connection operates in SSL mode, or an empty string otherwise

* $is_args

“?” if a request line has arguments, or an empty string otherwise

* $limit_rate

setting this variable enables response rate limiting; see limit_rate

* $msec

current time in seconds with the milliseconds resolution (1.3.9, 1.2.6)

* $nginx_version

nginx version

* $pid

PID of the worker process

* $pipe

“p” if request was pipelined, “.” otherwise (1.3.12, 1.2.7)

* $proxy_protocol_addr

client address from the PROXY protocol header, or an empty string otherwise (1.5.12)

The PROXY protocol must be previously enabled by setting the proxy_protocol parameter in the listen directive.

* $proxy_protocol_port

client port from the PROXY protocol header, or an empty string otherwise (1.11.0)

The PROXY protocol must be previously enabled by setting the proxy_protocol parameter in the listen directive.

* $query_string

same as * $args

* $realpath_root

an absolute pathname corresponding to the root or alias directive’s value for the current request, with all symbolic links resolved to real paths

* $remote_addr

client address

* $remote_port

client port

* $remote_user

user name supplied with the Basic authentication

* $request

full original request line

* $request_body

request body

The variable’s value is made available in locations processed by the proxy_pass, fastcgi_pass, uwsgi_pass, and scgi_pass directives when the request body was read to a memory buffer.

* $request_body_file

name of a temporary file with the request body

At the end of processing, the file needs to be removed. To always write the request body to a file, client_body_in_file_only needs to be enabled. When the name of a temporary file is passed in a proxied request or in a request to a FastCGI/uwsgi/SCGI server, passing the request body should be 
disabled by the proxy_pass_request_body off, fastcgi_pass_request_body off, uwsgi_pass_request_body off, or scgi_pass_request_body off directives, respectively.

* $request_completion

“OK” if a request has completed, or an empty string otherwise

* $request_filename

file path for the current request, based on the root or alias directives, and the request URI

* $request_id

unique request identifier generated from 16 random bytes, in hexadecimal (1.11.0)

* $request_length

request length (including request line, header, and request body) (1.3.12, 1.2.7)

* $request_method

request method, usually “GET” or “POST”

* $request_time

request processing time in seconds with a milliseconds resolution (1.3.9, 1.2.6); time elapsed since the first bytes were read from the client

* $request_uri

full original request URI (with arguments)

* $scheme

request scheme, “http” or “https”

* $sent_http_name

arbitrary response header field; the last part of a variable name is the field name converted to lower case with dashes replaced by underscores

* $server_addr

an address of the server which accepted a request

Computing a value of this variable usually requires one system call. To avoid a system call, the listen directives must specify addresses and use the bind parameter.

* $server_name

name of the server which accepted a request

* $server_port

port of the server which accepted a request

* $server_protocol

request protocol, usually “HTTP/1.0”, “HTTP/1.1”, or “HTTP/2.0”

* $status

response status (1.3.2, 1.2.2)

* $tcpinfo_rtt, * $tcpinfo_rttvar, * $tcpinfo_snd_cwnd, * $tcpinfo_rcv_space

information about the client TCP connection; available on systems that support the TCP_INFO socket option

* $time_iso8601

local time in the ISO 8601 standard format (1.3.12, 1.2.7)

* $time_local

local time in the Common Log Format (1.3.12, 1.2.7)

* $uri

current URI in request, normalized

The value of * $uri may change during request processing, e.g. when doing internal redirects, or when using index files.


### ngx_http_upstream_module

The `ngx_http_upstream_module` module supports the following embedded variables:

* $upstream_addr

keeps the IP address and port, or the path to the UNIX-domain socket of the upstream server. If several servers were contacted during request processing, their addresses are separated by commas, e.g. “192.168.1.1:80, 192.168.1.2:80, unix:/tmp/sock”. If an internal redirect from one server group to 
another happens, initiated by “X-Accel-Redirect” or error_page, then the server addresses from different groups are separated by colons, e.g. “192.168.1.1:80, 192.168.1.2:80, unix:/tmp/sock : 192.168.10.1:80, 192.168.10.2:80”.

* $upstream_cache_status

keeps the status of accessing a response cache (0.8.3). The status can be either “MISS”, “BYPASS”, “EXPIRED”, “STALE”, “UPDATING”, “REVALIDATED”, or “HIT”.

* $upstream_connect_time

keeps time spent on establishing a connection with the upstream server (1.9.1); the time is kept in seconds with millisecond resolution. In case of SSL, includes time spent on handshake. Times of several connections are separated by commas and colons like addresses in the $upstream_addr variable.

* $upstream_cookie_name

cookie with the specified name sent by the upstream server in the “Set-Cookie” response header field (1.7.1). Only the cookies from the response of the last server are saved.

* $upstream_header_time

keeps time spent on receiving the response header from the upstream server (1.7.10); the time is kept in seconds with millisecond resolution. Times of several responses are separated by commas and colons like addresses in the $upstream_addr variable.

* $upstream_http_name

keep server response header fields. For example, the “Server” response header field is available through the $upstream_http_server variable. The rules of converting header field names to variable names are the same as for the variables that start with the “$http_” prefix. Only the header fields 
from the response of the last server are saved.

* $upstream_response_length

keeps the length of the response obtained from the upstream server (0.7.27); the length is kept in bytes. Lengths of several responses are separated by commas and colons like addresses in the $upstream_addr variable.

* $upstream_response_time

keeps time spent on receiving the response from the upstream server; the time is kept in seconds with millisecond resolution. Times of several responses are separated by commas and colons like addresses in the $upstream_addr variable.

* $upstream_status

keeps status code of the response obtained from the upstream server. Status codes of several responses are separated by commas and colons like addresses in the $upstream_addr variable.


### ngx_http_ssl_module

The `ngx_http_ssl_module` module supports several embedded variables:

* $ssl_cipher

returns the string of ciphers used for an established SSL connection;

* $ssl_client_cert

returns the client certificate in the PEM format for an established SSL connection, with each line except the first prepended with the tab character; this is intended for the use in the proxy_set_header directive;

* $ssl_client_fingerprint

returns the SHA1 fingerprint of the client certificate for an established SSL connection (1.7.1);

* $ssl_client_raw_cert

returns the client certificate in the PEM format for an established SSL connection;

* $ssl_client_serial

returns the serial number of the client certificate for an established SSL connection;

* $ssl_client_s_dn

returns the “subject DN” string of the client certificate for an established SSL connection;

* $ssl_client_i_dn

returns the “issuer DN” string of the client certificate for an established SSL connection;

* $ssl_client_verify

returns the result of client certificate verification: “SUCCESS”, “FAILED”, and “NONE” if a certificate was not present;

* $ssl_protocol

returns the protocol of an established SSL connection;

* $ssl_server_name

returns the server name requested through SNI (1.7.0);

* $ssl_session_id

returns the session identifier of an established SSL connection;

* $ssl_session_reused

returns “r” if an SSL session was reused, or “.” otherwise (1.5.11).
