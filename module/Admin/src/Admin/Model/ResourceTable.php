<?php
namespace Admin\Model;

use Zend\Db\Sql\Where;
class ResourceTable extends DbTable
{
	public function __construct() {
		$this->setTableGateway ("db", 'sys_resource');
	}
}