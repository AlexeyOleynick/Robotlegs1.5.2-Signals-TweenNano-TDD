package alexey.oleynick {
import flash.display.Sprite;
import flash.events.Event;

[SWF(width="800", height="600", backgroundColor="#000000")]
public class Gallery extends Sprite {

    private var context:RobotlegsStartupContext;

    public function Gallery() {
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    protected function onAddedToStage(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        context = new RobotlegsStartupContext(this);
    }
}
}
