package  
{
	import core.ioc.Context;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class IoCMain extends Sprite 
	{
		private var classes:ClassesReference
		
		public function IoCMain():void 
		{
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// entry point
			stage.align = 'TL';
			stage.scaleMode = 'noScale';
			
			//Add stage to context for using in next levels of code
			Context.instance.addObjectToContext(stage, 'Stage');
			
			launch();
		}
		
		public function launch():void
		{
			new XMLBootstrap();
		}
		
	}

}