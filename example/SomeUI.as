package  
{
	import core.datavalue.model.events.ProxyEvent;
	import flash.display.Sprite;
	import flash.display.Stage;
	
	public class SomeUI extends Sprite 
	{
		
		public var stageLink:Stage;
		public var someModel:SomeModel;
		
		public function SomeUI() 
		{
			super();
			
		}
		
		public function initialize():void
		{
			stageLink.addChild(this);
			
			draw();
			
			someModel.addEventListener(ProxyEvent.UPDATE_EVENT, onUpdate);
		}
		
		private function onUpdate(e:ProxyEvent):void 
		{
			for(var field:String in someModel.changedFields)
				this[field] = someModel[field];
		}
		
		private function draw():void 
		{
			this.graphics.lineStyle(1, 0x0);
			
			this.graphics.beginFill(0xCCCCCC);
			this.graphics.drawRect(0, 0, 50, 50);
		}
		
	}

}