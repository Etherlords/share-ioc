package  
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * Class with some logic
	 */
	public class SomeLogic 
	{
		
		private var _myView:SomeUI;
		
		public var someModel:SomeModel;
		
		[Inject]
		public var stageLink:Stage;
		
		public function SomeLogic() 
		{
			inject(this);
		}
		
		public function get myView():SomeUI 
		{
			return _myView;
		}
		
		public function set myView(value:SomeUI):void 
		{
			_myView = value;
		}
		
		public function initialize():void 
		{
			stageLink.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			someModel.x = e.stageX;
			someModel.y = e.stageY;
			
			someModel.update();
		}
		
		
		
	}

}