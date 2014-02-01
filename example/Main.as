package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class Main extends IoCMain
	{
		public function Main() 
		{
			super();
		}
		
		override public function launch():void 
		{
			//create xml bootstrap and load config
			new XMLBootstrap().loadConfig('../example/mainconfig.xml');
		}
		
	}
	
}