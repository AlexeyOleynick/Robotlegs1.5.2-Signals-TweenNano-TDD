package alexey.oleynick.canvas.view.item.factory {
import alexey.oleynick.canvas.view.item.IGalleryItemView;
import alexey.oleynick.canvas.view.item.animation.IAnimator;
import alexey.oleynick.model.IImageModel;

import flash.display.Bitmap;

import mockolate.runner.MockolateRule;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

public class BitmapGalleryItemViewFactoryTest {

    [Rule]
    public var rule:MockolateRule = new MockolateRule();

    [Mock]
    public var model:IImageModel;

    [Mock]
    public var animator:IAnimator;

    [Test]
    public function shouldContainProvidedBitmap():void {
        var bitmap:Bitmap = new Bitmap();
        var galleryItemViewFactory:BitmapGalleryItemViewFactory = new BitmapGalleryItemViewFactory(model, animator);
        var galleryItemView:IGalleryItemView = galleryItemViewFactory.getImageByBitmap(bitmap);
        assertThat(galleryItemView.displayObject.contains(bitmap), equalTo(true));
    }
}
}
