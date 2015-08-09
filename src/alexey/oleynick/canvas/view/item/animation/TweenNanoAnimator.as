package alexey.oleynick.canvas.view.item.animation {
import com.greensock.TweenNano;

import flash.display.DisplayObject;

public class TweenNanoAnimator implements IAnimator {

    private static const SHIFT_ANIMATION_DURATION:Number = 0.3;
    private static const FADE_ANIMATION_DURATION:Number = 0.3;

    public function fadeIn(displayObjectToAnimate:DisplayObject, callback:Function, callbackArgs:Array):void {
        TweenNano.to(displayObjectToAnimate, FADE_ANIMATION_DURATION, {
            alpha: 1,
            onComplete: callback,
            onCompleteParams: callbackArgs
        });
    }

    public function fadeOut(displayObjectToAnimate:DisplayObject, callback:Function, callbackArgs:Array):void {
        TweenNano.to(displayObjectToAnimate, 0.3, {alpha: 0, onComplete: callback, onCompleteParams: callbackArgs});
    }

    public function shiftYto(displayObjectToAnimate:DisplayObject, targetY:Number):void {
        TweenNano.to(displayObjectToAnimate, SHIFT_ANIMATION_DURATION, {y: targetY});
    }
}
}
