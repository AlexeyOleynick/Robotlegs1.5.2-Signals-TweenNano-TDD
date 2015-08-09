package alexey.oleynick.canvas.view {
import alexey.oleynick.canvas.signal.ImageSelectSignal;
import alexey.oleynick.canvas.view.distributor.IImageDistributor;
import alexey.oleynick.canvas.view.item.IGalleryItemView;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.MouseEvent;

public class CanvasView extends Sprite implements ICanvasView {

    private var imageSelectSignal:ImageSelectSignal;
    private var imageDistributor:IImageDistributor;

    public function CanvasView(imageDistributor:IImageDistributor, imageSelectSignal:ImageSelectSignal) {
        this.imageDistributor = imageDistributor;
        this.imageSelectSignal = imageSelectSignal;
        imageDistributor.imageAddedSignal.add(imageAddedToDistributorListener);
        imageDistributor.imageRemovedSignal.add(imageRemovedFromDistributorListener);
    }

    public function get isFull():Boolean {
        return imageDistributor.isFull;
    }

    public function get displayObject():DisplayObjectContainer {
        return this;
    }

    public function replaceImage(source:IGalleryItemView, target:IGalleryItemView):void {
        imageDistributor.replaceImage(source, target);
    }

    public function addImage(itemView:IGalleryItemView):void {
        imageDistributor.placeImage(itemView);
    }

    private function imageAddedToDistributorListener(itemView:IGalleryItemView):void {
        addChild(itemView.displayObject);
        itemView.displayObject.addEventListener(MouseEvent.CLICK, imageClickedListener);
    }

    private function imageRemovedFromDistributorListener(itemView:IGalleryItemView):void {
        removeChild(itemView.displayObject);
        itemView.destroy();
    }

    private function imageClickedListener(event:MouseEvent):void {
        event.target.removeEventListener(MouseEvent.CLICK, imageClickedListener);
        imageSelectSignal.dispatch(event.target);
    }
}
}
