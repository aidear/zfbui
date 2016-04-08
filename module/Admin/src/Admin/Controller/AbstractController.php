<?php
namespace Admin\Controller;

use Zend\Mvc\Controller\AbstractActionController as Father;
use Zend\Mvc\MvcEvent;
use Zend\Session\Container;
use Zend\View\Model\ViewModel;
class AbstractController extends Father
{
	protected function attachDefaultListeners()
	{
		parent::attachDefaultListeners();
	
		$events = $this->getEventManager();
		$this->events->attach(MvcEvent::EVENT_DISPATCH, array($this, 'preDispatch'), 1000);
		$this->events->attach(MvcEvent::EVENT_DISPATCH, array($this, 'postDispatch'), -1000);
	}
	public function preDispatch(MvcEvent $e) {
	}
	public function postDispatch(MvcEvent $e) {
		$layout = $e->getViewModel();
		if (!$layout instanceof ViewModel) {
			return;
		}
		$view = $e->getViewModel();
		
		$loginInfo = $this->_getSession('loginInfo');
		$view->setVariable('loginInfo', $loginInfo);
		$routeName = $e->getRouteMatch()->getMatchedRouteName();
		if ($routeName == 'home') {
			$this->layout('layout/main');
		}
	}
	/**
	 * 获取Session
	 * @param string $nameSpace
	 * @return \Zend\Session\Container
	 */
	protected function _getSession($nameSpace = 'user'){
		return new Container($nameSpace);
	}
}
