<?php
namespace Admin\Controller;

use Admin\Model\RoleTable;
use Admin\Model\AclTable;
use Zend\View\Model\JsonModel;
class RoleController extends AbstractController
{
    function indexAction(){
        $page = $this->params()->fromQuery('page' , 1);
        $roleTable = new RoleTable();
        $items = $roleTable->getAll();
        $aclTable = new AclTable();
        foreach ($items as $k=>$v) {
        	$items[$k]['resource'] = $aclTable->getSourceByRole($v['Name']);
        }
        return array('list' => $items);
    }
    
    function saveAction(){
        $request = $this->getRequest();
               
        if($request->isPost()){
            $params = $request->getPost();
            if (trim($params->Name) == '') {
            	return new JsonModel(array('code' => -1, 'msg' => '角色名不允许为空！'));
            }
            $roleTable = new RoleTable();
            if ($roleTable->checkIsExist($params->Name, $params->RoleID)) {
            	return new JsonModel(array('code' => -2, 'msg' => '角色名称重复，请更换其他名称！'));
            }
            if ($params->RoleID) {
            	$sql = "UPDATE `sys_role` SET `Name` = '{$params->Name}', `CnName` = '{$params->CnName}' WHERE `RoleID`={$params->RoleID}";
            } else {
            	$sql = "INSERT INTO sys_role (`Name`, `CnName`, `AddTime`) VALUES ('{$params->Name}', '{$params->CnName}', '".date('Y-m-d H:i:s')."')";
            }
            $roleTable->query($sql);
            return new JsonModel(array('code' => 0, 'msg' => '保存成功！'));
        }
        
        $table = $this->_getRoleTable();
        $roles = $table->getAll();
        $form->setParents($roles);
        $return = array('form' => $form);
        if($this->flashMessenger()->hasMessages()){
        	$return['msg'] = $this->flashMessenger()->getMessages();
        	return $return;
        }
        return $return;
    }
    
    function deleteAction(){
    	$ids = $this->params()->fromPost('RoleID');
    	$roleTable = new RoleTable();
    	if (is_array($ids)) {
    		$sql = "DELETE FROM `sys_role` WHERE RoleID IN (".implode(',', $ids).")";
    	} else {
    		$sql = "DELETE FROM `sys_role` WHERE RoleID={$ids}";
    	}
    	
    	$roleTable->query($sql);
    	return new JsonModel(array('code' => 0, 'msg' => '删除成功！'));
    }
    
    private function _getRoleTable(){
        return $this->getServiceLocator()->get('RoleTable');
    }
    
    private function _getCache(){
        return $this->getServiceLocator()->get('cache');
    }
    
    private function _getAcl(){
        return $this->getServiceLocator()->get('acl');
    }
}