package alexey.oleynick.model.service {
import flash.display.Bitmap;

public interface IImageService {

    function get availableIds():Vector.<int>;

    function getImageById(id:int):Bitmap;

}
}
