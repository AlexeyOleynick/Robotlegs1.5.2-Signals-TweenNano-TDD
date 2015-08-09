package alexey.oleynick.canvas.view.item {
import alexey.oleynick.canvas.view.item.animation.IAnimator;

import flash.display.Bitmap;
import flash.display.BitmapData;

import mockolate.received;
import mockolate.runner.MockolateRule;

import org.hamcrest.assertThat;
import org.hamcrest.collection.hasItem;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.strictlyEqualTo;

public class BitmapGalleryItemViewTest {

    [Rule]
    public var rule:MockolateRule = new MockolateRule();

    [Mock]
    public var animator:IAnimator;

    private var callback:Function = new Function();

    private var bitmapData:BitmapData = new BitmapData(100, 100);
    private var bitmap:Bitmap = new Bitmap(bitmapData);

    private var galleryItemView:BitmapGalleryItemView;

    [Before]
    public function setUp():void {
        galleryItemView = new BitmapGalleryItemView(bitmap, animator);
    }

    [Test]
    public function displayObjectShouldContainBitmap():void {
        assertThat(galleryItemView.displayObject.contains(bitmap), equalTo(true));
    }

    [Test]
    public function shouldSmoothBitmap():void {
        assertThat(bitmap.smoothing, equalTo(true));
    }

    [Test]
    public function shouldBeInButtonMode():void {
        assertThat(galleryItemView.buttonMode, equalTo(true));
    }

    [Test]
    public function shouldSetAlphaToZeroAndCallAnimatorToShow():void {
        galleryItemView.show(callback);
        assertThat(galleryItemView.displayObject.alpha, equalTo(0));
        assertThat(animator, received().method("fadeIn").args(strictlyEqualTo(galleryItemView), strictlyEqualTo(callback), hasItem(galleryItemView)));
    }

    [Test]
    public function shouldCallAnimatorToHide():void {
        galleryItemView.hide(callback);
        assertThat(animator, received().method("fadeOut").args(strictlyEqualTo(galleryItemView), strictlyEqualTo(callback), hasItem(galleryItemView)));
    }

    [Test]
    public function shouldCallAnimatorToShiftToY():void {
        galleryItemView.shiftYto(300);
        assertThat(animator, received().method("shiftYto").args(galleryItemView.displayObject, 300));
    }

    [Test(expects="Error")]
    public function shouldDisposeBitmap():void {
        galleryItemView.destroy();
        bitmap.bitmapData.getPixel(1, 1);
    }

}
}
