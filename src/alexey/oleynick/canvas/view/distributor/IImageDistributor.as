package alexey.oleynick.canvas.view.distributor {
import alexey.oleynick.canvas.view.item.IGalleryItemView;

import org.osflash.signals.Signal;

public interface IImageDistributor {
    function get isFull():Boolean;

    function get imageAddedSignal():Signal;

    function get imageRemovedSignal():Signal;

    function placeImage(imageView:IGalleryItemView):void;

    function replaceImage(image:IGalleryItemView, replaceWith:IGalleryItemView):void;
}
}
