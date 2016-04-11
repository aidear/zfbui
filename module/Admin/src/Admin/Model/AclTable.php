<?php
namespace Admin\Model;

use Admin\Model\DbTable;
class AclTable extends DbTable
{
	public function __construct() {
		$this->setTableGateway ("db", 'sys_acl');
	}

	public function getSourceByRole($role) {
		$select = $this->tableGateway->getSql()->select();
		$select->where(array('role_name' => $role));
		$ret = $this->tableGateway->selectWith($select);
		return $ret->toArray();
	}
}