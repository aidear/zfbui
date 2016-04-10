<?php
namespace Admin\Controller;

use Zend\View\Model\ViewModel;
use Admin\Model\ResourceTable;

class AjaxController extends AbstractController
{

	public function getResourceAction() {
		$type = $this->params()->fromPost('type');
		$type = $type ? $type : 'add';
		$role = $this->params()->fromPost('role');
		$data = array();
		$table = new ResourceTable();
		if (!$role) {
			$rs = array('code' => -200, 'msg' => '参数错误');
		} else {
			$acl = $this->getServiceLocator()->get('acl');
			$resources = $acl->acl->getResources();

			$hasResources = array();
			$noneResources = array();
			foreach($resources as $v){
				if($acl->acl->isAllowed($role , $v)){
					$hasResources[] = $v;
				}else{
					$noneResources[] = $v;
				}
			}
			if ($type == 'add') {
				$data = $table->getSourceByNames($noneResources);
			} else {
				$data = $table->getSourceByNames($hasResources);
			}
			$rs = array('code' => 0, 'msg' => 'sucess', 'data' => $data);
		}
		return new JsonModel($rs);
	}
}