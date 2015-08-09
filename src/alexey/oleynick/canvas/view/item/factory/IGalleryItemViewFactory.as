package alexey.oleynick.canvas.view.item.factory {
import alexey.oleynick.canvas.view.item.IGalleryItemView;

import flash.display.Bitmap;

public interface IGalleryItemViewFactory {
    function getImageByBitmap(bitmap:Bitmap):IGalleryItemView;
}
}
