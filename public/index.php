<?php
/**
 * This makes our life easier when dealing with paths. Everything is relative
 * to the application root now.
 */
define('ROOT_PATH', dirname(__DIR__));
chdir(dirname(__DIR__));
// 定义应用运行环境，可以在 .htaccess 中设置 SetEnv APPLICATION_ENV development
defined('APPLICATION_ENV')
|| define('APPLICATION_ENV', (getenv('APPLICATION_ENV')?getenv('APPLICATION_ENV'):'production'));

// 定义激活的模块，用于区分前后台，可以在 .htaccess 中设置 SetEnv ACTIVE_MODULE admin
defined('ACTIVE_MODULE')
|| define('ACTIVE_MODULE', (getenv('ACTIVE_MODULE')?getenv('ACTIVE_MODULE'):'admin'));

// 不是产品环境则允许显示错误，以方便调试
if (APPLICATION_ENV != 'production') {
	error_reporting(E_ALL ^ E_NOTICE ^ E_WARNING);
	ini_set('display_startup_errors', 1);
	ini_set('display_errors', 1);
} else {
	// 是产品环境则不允许显示错误
	ini_set('display_startup_errors', 0);
	ini_set('display_errors', 0);
}
// Decline static file requests back to the PHP built-in webserver
if (php_sapi_name() === 'cli-server' && is_file(__DIR__ . parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH))) {
    return false;
}

// Setup autoloading
require 'init_autoloader.php';

// Run the application!
Zend\Mvc\Application::init(require 'config/' . ACTIVE_MODULE . '.config.php')->run();
