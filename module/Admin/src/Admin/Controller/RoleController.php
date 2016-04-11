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
        	$date = date('Y-m-d H:i:s');
            $params = $request->getPost();
            if (trim($params->name) == '') {
            	return new JsonModel(array('code' => -1, 'msg' => '角色名不允许为空！'));
            }
            $roleTable = new RoleTable();
            if ($roleTable->checkIsExist($params->name, $params->id)) {
            	return new JsonModel(array('code' => -2, 'msg' => '角色名称重复，请更换其他名称！'));
            }
            if ($params->id) {
            	$sql = "UPDATE `sys_role` SET `name` = '{$params->name}', `cn_name` = '{$params->cn_name}' WHERE `id`={$params->id}";
            } else {
            	$sql = "INSERT INTO sys_role (`name`, `cn_name`, `add_time`) VALUES ('{$params->name}', '{$params->cn_name}', '".$date."')";
            }
            $roleTable->query($sql);
            return new JsonModel(array('code' => 0, 'msg' => '保存成功！', 'Data' => $params));
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
    	$ids = $this->params()->fromPost('id');
    	$roleTable = new RoleTable();
    	if (is_array($ids)) {
    		$sql = "DELETE FROM `sys_role` WHERE id IN (".implode(',', $ids).")";
    	} else {
    		$sql = "DELETE FROM `sys_role` WHERE id={$ids}";
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