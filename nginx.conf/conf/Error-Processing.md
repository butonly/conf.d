Error Processing

The ngx_http_ssl_module module supports several non-standard error codes that can be used for redirects using the error_page directive:

495
an error has occurred during the client certificate verification;
496
a client has not presented the required certificate;
497
a regular request has been sent to the HTTPS port.
The redirection happens after the request is fully parsed and the variables, such as $request_uri, $uri, $args and others, are available.
