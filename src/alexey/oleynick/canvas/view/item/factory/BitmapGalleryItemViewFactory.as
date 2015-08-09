package alexey.oleynick.canvas.view.item.factory {
import alexey.oleynick.canvas.view.item.BitmapGalleryItemView;
import alexey.oleynick.canvas.view.item.IGalleryItemView;
import alexey.oleynick.canvas.view.item.animation.IAnimator;
import alexey.oleynick.model.IImageModel;

import flash.display.Bitmap;

public class BitmapGalleryItemViewFactory implements IGalleryItemViewFactory {

    private var imageModel:IImageModel;
    private var animator:IAnimator;

    public function BitmapGalleryItemViewFactory(imageModel:IImageModel, animator:IAnimator) {
        this.imageModel = imageModel;
        this.animator = animator;
    }

    public function getImageByBitmap(bitmap:Bitmap):IGalleryItemView {
        return new BitmapGalleryItemView(bitmap, animator);
    }
}
}
