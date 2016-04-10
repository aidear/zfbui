<?php
namespace Admin\Model;

class RoleTable extends DbTable
{
	public function __construct() {
		$this->setTableGateway ("db", 'sys_role');
	}
	public function getAll() {
		$sql = "SELECT * FROM `sys_role`";
		return $this->fetchAll($sql);
	}

	public function checkIsExist($name) {
		return $this->tableGateway->select(array('Name' => $name))->count();
	}
}