package alexey.oleynick.canvas.view.distributor.column {
import alexey.oleynick.canvas.view.item.IGalleryItemView;
import alexey.oleynick.config.IImageColumnConfig;

public class VectorImageColumn implements IImageColumn {

    private var config:IImageColumnConfig;

    private var imageCollection:Vector.<IGalleryItemView>;
    private var index:int;

    public function VectorImageColumn(config:IImageColumnConfig, index:int) {
        this.config = config;
        this.index = index;
        imageCollection = new Vector.<IGalleryItemView>();
    }

    public function get height():int {
        var height:Number = 0;
        for each (var item:IGalleryItemView in imageCollection) {
            height += item.displayObject.height;
        }
        return height;
    }

    public function get isFull():Boolean {
        return height > config.columnHeightInPixels;
    }

    public function add(image:IGalleryItemView):void {
        image.displayObject.x = index * config.columnWidthInPixels;
        image.displayObject.y = height;
        scaleImage(image);
        imageCollection.push(image);
    }

    public function replaceImage(image:IGalleryItemView, replaceWith:IGalleryItemView):void {
        scaleImage(replaceWith);
        replaceWith.displayObject.x = image.displayObject.x;
        replaceWith.displayObject.y = image.displayObject.y;

        var sourceImageIndex:int = imageCollection.indexOf(image);
        imageCollection[sourceImageIndex] = replaceWith;

        var images:Vector.<IGalleryItemView> = getAllImagesInColumnBelow(replaceWith);
        for each (var view:IGalleryItemView in images) {
            view.shiftYto(getImagesHeightAbove(view));
        }

    }

    public function contains(image:IGalleryItemView):Boolean {
        return imageCollection.indexOf(image) != -1;
    }

    private function getAllImagesInColumnBelow(image:IGalleryItemView):Vector.<IGalleryItemView> {
        if (contains(image)) {
            return imageCollection.slice(imageCollection.indexOf(image));
        } else {
            return new Vector.<IGalleryItemView>();
        }
    }

    private function getImagesHeightAbove(image:IGalleryItemView):Number {
        var imageIndexInCollection:int = imageCollection.indexOf(image);
        var height:Number = 0;
        for (var imageIndex:int = 0; imageIndex < imageIndexInCollection; imageIndex++) {
            var view:IGalleryItemView = imageCollection[imageIndex];
            height += view.displayObject.height;
        }
        return height;
    }

    private function scaleImage(replaceWith:IGalleryItemView):void {
        var resizeRate:Number = config.columnWidthInPixels / replaceWith.displayObject.width;
        replaceWith.displayObject.scaleX = resizeRate;
        replaceWith.displayObject.scaleY = resizeRate;
    }

}
}
