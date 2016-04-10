<?php
namespace Admin\Model;

use Zend\Db\Sql\Where;
class RoleTable extends DbTable
{
	public function __construct() {
		$this->setTableGateway ("db", 'sys_role');
	}
	public function getAll() {
		$sql = "SELECT * FROM `sys_role`";
		return $this->fetchAll($sql);
	}

	public function checkIsExist($name, $roleID = null) {
		$where = new Where();
		$where->equalTo('Name', $name);
		if ($roleID) {
			$where->notEqualTo('RoleID', $roleID);
		}
		return $this->tableGateway->select($where)->count();
	}
}