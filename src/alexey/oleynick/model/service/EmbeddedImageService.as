package alexey.oleynick.model.service {
import flash.display.Bitmap;

public class EmbeddedImageService implements IImageService {
    [Embed(source="../../../../../resource/a.jpg")]
    public static var BitmapA:Class;

    [Embed(source="../../../../../resource/b.jpg")]
    public static var BitmapB:Class;

    [Embed(source="../../../../../resource/c.jpg")]
    public static var BitmapC:Class;

    [Embed(source="../../../../../resource/d.jpg")]
    public static var BitmapD:Class;

    [Embed(source="../../../../../resource/e.jpg")]
    public static var BitmapE:Class;

    [Embed(source="../../../../../resource/f.jpg")]
    public static var BitmapF:Class;

    [Embed(source="../../../../../resource/g.jpg")]
    public static var BitmapG:Class;

    [Embed(source="../../../../../resource/h.jpg")]
    public static var BitmapH:Class;

    [Embed(source="../../../../../resource/i.jpg")]
    public static var BitmapI:Class;

    [Embed(source="../../../../../resource/j.jpg")]
    public static var BitmapJ:Class;

    [Embed(source="../../../../../resource/k.jpg")]
    public static var BitmapK:Class;

    private var bitmapClasses:Vector.<Class>;
    private var bitmapIds:Vector.<int>;

    public function EmbeddedImageService() {
        bitmapClasses = new Vector.<Class>();
        bitmapClasses.push(BitmapA, BitmapB, BitmapC, BitmapD, BitmapE, BitmapF, BitmapG, BitmapH, BitmapI, BitmapJ, BitmapK);

        setBitmapIds();
    }

    public function get availableIds():Vector.<int> {
        return bitmapIds;
    }

    //TODO: Add id validation
    public function getImageById(id:int):Bitmap {
        return new bitmapClasses[id]() as Bitmap;
    }

    private function setBitmapIds():void {
        bitmapIds = new Vector.<int>();
        for (var bitmapIndexInVector:int = 0; bitmapIndexInVector < bitmapClasses.length; bitmapIndexInVector++) {
            bitmapIds.push(bitmapIndexInVector);
        }
    }
}
}
