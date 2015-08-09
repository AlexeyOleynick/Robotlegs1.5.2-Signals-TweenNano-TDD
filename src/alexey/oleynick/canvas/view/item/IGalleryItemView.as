package alexey.oleynick.canvas.view.item {
import alexey.oleynick.stage.IDisplayObjectWrapper;

public interface IGalleryItemView extends IDisplayObjectWrapper {

    function destroy():void;

    function shiftYto(y:Number):void;

    function show(dispatch:Function):void;

    function hide(dispatch:Function):void;
}

}
