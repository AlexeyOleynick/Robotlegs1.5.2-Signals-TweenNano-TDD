package alexey.oleynick.canvas.view.item {
import alexey.oleynick.canvas.view.item.animation.IAnimator;

import flash.display.Bitmap;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

public class BitmapGalleryItemView extends Sprite implements IGalleryItemView {
    private var bitmap:Bitmap;
    private var animator:IAnimator;

    public function BitmapGalleryItemView(bitmap:Bitmap, animator:IAnimator) {
        this.bitmap = bitmap;
        this.animator = animator;
        bitmap.smoothing = true;
        buttonMode = true;
        addChild(bitmap);
    }

    public function get displayObject():DisplayObjectContainer {
        return this;
    }

    public function destroy():void {
        bitmap.bitmapData.dispose();
    }

    public function shiftYto(y:Number):void {
        animator.shiftYto(this, y);
    }

    public function show(dispatch:Function):void {
        this.alpha = 0;
        animator.fadeIn(this, dispatch, [this]);
    }

    public function hide(dispatch:Function):void {
        animator.fadeOut(this, dispatch, [this]);
    }
}
}
