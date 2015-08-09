package alexey.oleynick.canvas.view.distributor.column {
import alexey.oleynick.canvas.view.item.IGalleryItemView;

public interface IImageColumn {

    function get height():int;

    function get isFull():Boolean;

    function replaceImage(image:IGalleryItemView, replaceWith:IGalleryItemView):void;

    function contains(image:IGalleryItemView):Boolean;

    function add(image:IGalleryItemView):void;

}
}
