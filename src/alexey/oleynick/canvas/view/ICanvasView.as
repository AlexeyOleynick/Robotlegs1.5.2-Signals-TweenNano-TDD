package alexey.oleynick.canvas.view {
import alexey.oleynick.canvas.view.item.IGalleryItemView;
import alexey.oleynick.stage.IDisplayObjectWrapper;

public interface ICanvasView extends IDisplayObjectWrapper {

    function get isFull():Boolean;

    function addImage(itemView:IGalleryItemView):void;

    function replaceImage(source:IGalleryItemView, target:IGalleryItemView):void;
}
}
