package  
{
	import core.datavalue.model.events.ProxyEvent;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class AnotherUI extends Sprite 
	{
		private var textField:TextField;
		
		public var stageLink:Stage;
		public var someModel:SomeModel;
		
		public function AnotherUI() 
		{
			super();
		}
		
		public function initialize():void
		{
			stageLink.addChild(this);
			
			stageLink.addEventListener(Event.ENTER_FRAME, update);
			
			addUI();
			
			someModel.addEventListener(ProxyEvent.UPDATE_EVENT, onModelUpdate);
		}
		
		private function onModelUpdate(e:ProxyEvent):void 
		{
			textField.appendText('-=fields was changed=-\n');
			for (var vr:String in someModel.changedFields)
				textField.appendText(vr + ' = ' + someModel[vr] + '\n');
		}
		
		private function addUI():void 
		{
			textField = new TextField();
			textField.multiline = true;
			addChild(textField);
			textField.autoSize = TextFieldAutoSize.LEFT;
		}
		
		private function update(e:Event):void 
		{
			this.x = stage.stageWidth - this.width;
			
			if (this.height > stage.stageHeight)
				textField.text = '';
		}
		
	}

}