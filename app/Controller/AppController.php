<?php
/**
 * Application level Controller
 *
 * This file is application-wide controller file. You can put all
 * application-wide controller-related methods here.
 *
 * PHP 5
 *
 * CakePHP(tm) : Rapid Development Framework (http://cakephp.org)
 * Copyright 2005-2012, Cake Software Foundation, Inc. (http://cakefoundation.org)
 *
 * Licensed under The MIT License
 * Redistributions of files must retain the above copyright notice.
 *
 * @copyright     Copyright 2005-2012, Cake Software Foundation, Inc. (http://cakefoundation.org)
 * @link          http://cakephp.org CakePHP(tm) Project
 * @package       app.Controller
 * @since         CakePHP(tm) v 0.2.9
 * @license       MIT License (http://www.opensource.org/licenses/mit-license.php)
 */

App::uses('Controller', 'Controller');

/**
 * Application Controller
 *
 * Add your application-wide methods in the class below, your controllers
 * will inherit them.
 *
 * @package       app.Controller
 * @link http://book.cakephp.org/2.0/en/controllers.html#the-app-controller
 */
class AppController extends Controller {
	
	public $components = array('Session', 'Auth');
	public $helpers = array('Array', 'Main', 'Html');
	public $user = array();
	public $layout = "admin";
	public $uid = '';
	public $username = '';
	public $snsurl = '';
	public $wxAPI = '';
	public $wxToken = 'liunian';
	public $site_key = "CakeWX";
	public $site_cx = "Powered by CakeWX";
	public $version = "1.5";
	public $verdate = "三  2  4 12:39:34 CST 2015";
	
	/**
	 * undocumented function
	 *
	 * @return void
	 * @author apple
	 **/
	public function beforeFilter() {
		$this->wxAPI = Router::url('/wxapi', TRUE);
		$this->Auth->allow('index');
		$this->Auth->authError = "Accend deny";
		$this->Auth->loginError = "Login failed";
		$this->Auth->loginRedirect = array('controller' => "admin", 'action' => "index");
		$this->Auth->loginAction = array('plugin' => "", 'controller' => "user", 'action' => "login");
		$this->Auth->authorize = array('Controller');
		$this->Auth->authenticate = array('Form');
		$this->Auth->authenticate = array(
		    'Form' => array('userModel' => 'TPerson', 'fields' => array('username' => "FMemberId", 'password' => "FPassWord"), 'scope' => array('TPerson.FIsAuth' => true)),
		);
		$this->Auth->authError = "用户未被授权，禁止访问。";
		//$this->Auth->sessionKey = FALSE;
		
		// login case
		$this->user = AuthComponent::user();
		if (!empty($this->user)) {
			$this->user = AuthComponent::user();
			$this->uid = $this->user['Id'];
			$this->username = $this->user['FMemberId'];
			$this->isAdmin = $this->user['FIsAdmin'] ? TRUE : FALSE;
		}	
		// Views
		$this->_setGlobalViews();
	}
	
	public function isAuthorized($user) {
		return TRUE;
		$this->loadModel('TPerson');
		$result = $this->TPerson->find('all', array("conditions" => array('FMemberId' => $user['FMemberId'])));
		$taCount = isset($result[0]['TChapterAdmin']) ? count($result[0]['TChapterAdmin']) : 0;
		if ($taCount) {
			return TRUE;
		}
	
	    // Default deny
	    return FALSE;
	}	
	
	public function afterFilter() {
        parent::afterFilter();
		
        // sql logging to chrome console
        if (class_exists('ConnectionManager') && Configure::read('debug') >= 2) {
            App::import('Vendor', 'ChromePhp/ChromePhp');

            $sources = ConnectionManager::sourceList();
            $logs = array();
            foreach ($sources as $source) {
                $db = ConnectionManager::getDataSource($source);
                $logs[$source] = $db->getLog();
            }

            foreach ($logs as $source => $logInfo){

                $text = $logInfo['count'] > 1 ? 'queries' : 'query';
                ChromePhp::info('------- SQL: '.sprintf('(%s) %s %s took %s ms', $source, count($logInfo['log']), $text, $logInfo['time']).' -------');
                ChromePhp::info('------- REQUEST: '.$this->request->params['controller'].'/'.$this->request->params['action'].' -------');

                foreach ($logInfo['log'] as $k => $i){

                    $i += array('error' => '');
                    if (!empty($i['params']) && is_array($i['params'])) {
                        $bindParam = $bindType = null;
                        if (preg_match('/.+ :.+/', $i['query'])) {
                            $bindType = true;
                        }
                        foreach ($i['params'] as $bindKey => $bindVal) {
                            if ($bindType === true) {
                                $bindParam .= h($bindKey) ." => " . h($bindVal) . ", ";
                            } else {
                                $bindParam .= h($bindVal) . ", ";
                            }
                        }
                        $i['query'] .= " , params[ " . rtrim($bindParam, ', ') . " ]";
                    }

                    $error = !empty($i['error']) ? "\nError: ".$i['error']:"\n";
                    $logStr = $i['query'].$error."\nAffected: ".$i['affected']."\nNum. Rows: ".$i['numRows']."\nTook(ms): ".$i['took']."\n\n";

                    if(!empty($i['error'])){
                        ChromePhp::error($logStr);
                    }
                    else if($i['took'] >= 100){
                        ChromePhp::warn($logStr);
                    }
                    else{
                        ChromePhp::info($logStr);
                    }
                }
            }
        }
    }
	
	/**
	 * undocumented function
	 *
	 * @return void
	 * @author apple
	 **/
	function isLogin() {
		if ($this->uid) return TRUE;
	}

	function checkLogin() {
		if ($this->isLogin()) {
			$this->redirect(array('plugin' => "", 'controller' => "admin", 'action' => "index"));
		}
	}
	
	/**
	 * undocumented function
	 *
	 * @return void
	 * @author apple
	 **/
	function flashSuccess($msg)
	{
		$this->Session->setFlash($msg);
	}
	
	/**
	 * undocumented function
	 *
	 * @return void
	 * @author apple
	 **/
	function flashError($msg)
	{
		$this->Session->setFlash($msg, 'default', array(), 'error');
	}
	
	/**
	 * undocumented function
	 *
	 * @return void
	 * @author niancode
	 **/
	function LNRender($data = null, $view = null, $ext = '', $debug = 0, $caction = 'wc')
	{
		$tview = "";
		$backendDir = "/Admin/";
		$frontendDir = ":Mobile/";
		$uri = Router::getParams();
		
		// Check
		if ($data) {
			$this->set('data', $data);
		}
		if ($debug == 1) {
			echo '<pre>';print_r($this->data);exit;
		}
		
		
		// Case 
		switch ($uri['controller']) {
			case 'admin':
				if ($uri['action'] == 'index') {
					$tview = "{$backendDir}Webchat";
				} else if ($uri['action'] == 'wc') {
					$action = $uri['pass'][1];
					if ($action == 'index') {
						$tview = "{$backendDir}Wc/wHome";
					} else {
						$tview = "{$backendDir}Wc/{$action}";
					}
				} else {
					$action = ucfirst($uri['action']);
					$tview = "{$backendDir}{$action}";	
				}
				break;
			case 'mob':
				$action = ucfirst($uri['action']);
				$tview = "{$frontendDir}{$action}";
				break;
			default:
				$action = ucfirst($uri['action']);
				$tview = "{$backendDir}{$action}";
				break;
		}
		
		// Load View
		$split = $ext == 'twig' ? ':' : '/';
		$ext = $ext == 'twig' ? ".html.{$ext}" : $ext;
		$tview = $view ? "{$tview}{$split}{$view}{$ext}" : "{$tview}{$split}index{$ext}";
		// echo $tview;exit;
		return $this->render($tview);
	}
	
	/**
	 * undocumented function
	 *
	 * @return void
	 * @author apple
	 **/
	function _setGlobalViews() {	
		$conf = $this->_getSiteConf();
		$settings['site_sign'] = $conf['Site']['name'];
		$settings['site_name'] = $conf['Site']['title'];
		$settings['site_title'] = "{$conf['Site']['title']}";
		$settings['site_keywords'] = $conf['Site']['keywords'];
		$settings['site_description'] = $conf['Site']['description'];
		$this->set('settings', $settings);
		$this->set('cakeSign', $settings['site_sign']);
		$this->set('cakeTitle', $settings['site_title']);
		$this->set('cakeSiteName', $settings['site_name']);
		$this->set('cakeKeywords', $settings['site_keywords']);
		$this->set('cakeDescription', $settings['site_description']);
		$this->set('uid', $this->uid);
		$this->set('username', $this->username);
		$this->set('user', $this->user);
		$this->set('name', $this->user['FullName']);
		$this->set('WC_BASE', "");
		$this->set('version', "<a href=\"http://cakewx.com\">{$this->site_key}</a>&nbsp;V{$this->version}");
		$this->set('cakeStats', $conf['Site']['FSiteStats']);
	}
	
	/**
	 * undocumented function
	 *
	 * @return void
	 * @author niancode
	 **/
	function _getSiteConf()
	{
		$sets = array('Site' => array("title" => array('default' => "开源免费的微信公众平台开发框架"), "name" => array('default' => "CakeWX"), "keywords" => array(), "description" => array(), "FSiteStats" => array()));
		$conf = array();
		foreach ($sets as $key => $value) {
			foreach ($value as $k  => $v) {
				$v_s = is_array($v) ? $k : $v;
				$rconf = Configure::read("{$key}.{$v_s}");
				$rdefault = isset($v['default']) ? $v['default'] : '';
				$conf[$key][$v_s] = $rconf ? $rconf : $rdefault;
			}
		}
		return $conf;
	}
}
