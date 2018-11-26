<?php
// define('TMP_DIR', sys_get_temp_dir());
define('TMP_DIR', __DIR__ .  DIRECTORY_SEPARATOR . 'tmp');
define('TMP_FILE_PATTERN', 'preseed_%s.bin');
// define('HTTP_AUTH_USER', ''); empty will be ignore http auth
define('HTTP_AUTH_USER', 'preseedusr');
define('HTTP_AUTH_PASS', 'preseedpass');

function require_auth() {
	header('Cache-Control: no-cache, must-revalidate, max-age=0');
	$has_supplied_credentials = !(empty($_SERVER['PHP_AUTH_USER']) && empty($_SERVER['PHP_AUTH_PW']));
	$is_not_authenticated = (
		!$has_supplied_credentials ||
		$_SERVER['PHP_AUTH_USER'] != HTTP_AUTH_USER ||
		$_SERVER['PHP_AUTH_PW']   != HTTP_AUTH_PASS
	);
	if ($is_not_authenticated) {
		header('HTTP/1.1 401 Authorization Required');
		header('WWW-Authenticate: Basic realm="Access denied"');
		exit;
	}
}

function gc_olds() {
  foreach (glob(TMP_DIR . DIRECTORY_SEPARATOR . "*.bin") as $file) {
    if(time() - filemtime($file) > 7200) {
      unlink($file);
    }
  }
}

function setStatus($code) {
  $http_status_codes = array(100 => "Continue", 101 => "Switching Protocols", 102 => "Processing", 200 => "OK", 201 => "Created", 202 => "Accepted", 203 => "Non-Authoritative Information", 204 => "No Content", 205 => "Reset Content", 206 => "Partial Content", 207 => "Multi-Status", 300 => "Multiple Choices", 301 => "Moved Permanently", 302 => "Found", 303 => "See Other", 304 => "Not Modified", 305 => "Use Proxy", 306 => "(Unused)", 307 => "Temporary Redirect", 308 => "Permanent Redirect", 400 => "Bad Request", 401 => "Unauthorized", 402 => "Payment Required", 403 => "Forbidden", 404 => "Not Found", 405 => "Method Not Allowed", 406 => "Not Acceptable", 407 => "Proxy Authentication Required", 408 => "Request Timeout", 409 => "Conflict", 410 => "Gone", 411 => "Length Required", 412 => "Precondition Failed", 413 => "Request Entity Too Large", 414 => "Request-URI Too Long", 415 => "Unsupported Media Type", 416 => "Requested Range Not Satisfiable", 417 => "Expectation Failed", 418 => "I'm a teapot", 419 => "Authentication Timeout", 420 => "Enhance Your Calm", 422 => "Unprocessable Entity", 423 => "Locked", 424 => "Failed Dependency", 424 => "Method Failure", 425 => "Unordered Collection", 426 => "Upgrade Required", 428 => "Precondition Required", 429 => "Too Many Requests", 431 => "Request Header Fields Too Large", 444 => "No Response", 449 => "Retry With", 450 => "Blocked by Windows Parental Controls", 451 => "Unavailable For Legal Reasons", 494 => "Request Header Too Large", 495 => "Cert Error", 496 => "No Cert", 497 => "HTTP to HTTPS", 499 => "Client Closed Request", 500 => "Internal Server Error", 501 => "Not Implemented", 502 => "Bad Gateway", 503 => "Service Unavailable", 504 => "Gateway Timeout", 505 => "HTTP Version Not Supported", 506 => "Variant Also Negotiates", 507 => "Insufficient Storage", 508 => "Loop Detected", 509 => "Bandwidth Limit Exceeded", 510 => "Not Extended", 511 => "Network Authentication Required", 598 => "Network read timeout error", 599 => "Network connect timeout error");
  if (isset($http_status_codes[$code])) {
    header('HTTP/1.1 ' . $code . $http_status_codes[$code]);
  } else {
    header('HTTP/1.1 ' . 500 . $http_status_codes[500]);
  }
  exit;
}

gc_olds();

if (strlen(HTTP_AUTH_USER) > 0) {
  require_auth();
}

if (isset($_POST['preseed']) && is_string($_POST['preseed']) && isset($_FILES["preseed"])) {
  if (!preg_match('/^[a-z0-9]{1,64}$/i', $_POST['preseed'])) {
    setStatus(400);
  }
  $desFile = vsprintf('%s%s%s', [
    TMP_DIR,
    DIRECTORY_SEPARATOR,
    sprintf(TMP_FILE_PATTERN, $_POST['preseed']),
  ]);
  $fileData = file_get_contents($_FILES["preseed"]["tmp_name"]);
  file_put_contents($desFile, $fileData);
  setStatus(201);
}

if (isset($_GET['preseed']) && is_string($_GET['preseed'])) {
  if (!preg_match('/^[a-z0-9]{1,64}$/i', $_GET['preseed'])) {
    setStatus(400);
  }
  $sourceFile = vsprintf('%s%s%s', [
    TMP_DIR,
    DIRECTORY_SEPARATOR,
    sprintf(TMP_FILE_PATTERN, $_GET['preseed']),
  ]);
  if (file_exists($sourceFile)) {
    header('Content-Type: text/plain');
    header('Expires: 0');
    header('Cache-Control: must-revalidate');
    header('Pragma: public');
    header('Content-Length: ' . filesize($sourceFile));
    readfile($sourceFile);
    exit;
  } else {
    setStatus(404);
  }
}

if (isset($_GET['ping-preseed'])) {
  setStatus(201);
}

setStatus(403);
