<?php
namespace Admin\Service;

use Admin\Model\ResourceTable;
use Admin\Model\RoleTable;
use Admin\Model\AclTable;
use Zend\Permissions\Acl\Acl as Father;
class Acl
{
	public static $acl;
	public static function loadAcl() {
		$cache = Cache::get('static');
		self::$acl = $cache->getItem('admin_acl');
		if (null === self::$acl) {
			$resources = self::loadResource();
			$roles = self::loadRole();
			$allows = self::loadAllow();
			$acl = new Father();
			foreach($roles as $v){
				if($v->parent_name){
					$acl->addRole($v->name , $v->parent_name);
				}else{
					$acl->addRole($v->name);
				}
			}
			foreach ($resources as $v) {
				$resource = $v->module . '_' . $v->controller . '_' . $v->action;
				$acl->addResource($resource);
			}
			foreach ($allows as $v) {
				$acl->allow($v->role_name, $v->resource_name);
			}
			$cache->setItem('admin_acl', $acl);
			self::$acl = $acl;
		}
	}
	public static function loadResource() {
		$resourceTable = new ResourceTable();
		$select = $resourceTable->tableGateway->getSql()->select();
		$ret = $resourceTable->tableGateway->selectWith($select);
		return $ret;
	}
	public static function loadRole() {
		$roleTable = new RoleTable();
		$select = $roleTable->tableGateway->getSql()->select();
		$ret = $roleTable->tableGateway->selectWith($select);
		return $ret;
	}
	public static function loadAllow() {
		$aclTable = new AclTable();
		$select = $aclTable->tableGateway->getSql()->select();
		$ret = $aclTable->tableGateway->selectWith($select);
		return $ret;
	}
}