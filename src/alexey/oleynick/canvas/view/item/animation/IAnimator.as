package alexey.oleynick.canvas.view.item.animation {
import flash.display.DisplayObject;

public interface IAnimator {
    function fadeIn(displayObjectToAnimate:DisplayObject, callback:Function, callbackArgs:Array):void;

    function fadeOut(displayObjectToAnimate:DisplayObject, callback:Function, callbackArgs:Array):void;

    function shiftYto(displayObjectToAnimate:DisplayObject, targetY:Number):void;
}
}
