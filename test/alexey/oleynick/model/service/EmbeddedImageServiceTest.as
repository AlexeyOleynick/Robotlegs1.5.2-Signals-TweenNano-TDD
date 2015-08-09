package alexey.oleynick.model.service {

import flash.display.Bitmap;

import org.hamcrest.assertThat;
import org.hamcrest.collection.arrayWithSize;
import org.hamcrest.number.greaterThan;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.notNullValue;

public class EmbeddedImageServiceTest {
    private var imageService:EmbeddedImageService;

    [Before]
    public function setUp():void {
        imageService = new EmbeddedImageService();
    }

    [Test]
    public function arrayWithAvailableIdsShouldNotBeEmpty():void {
        var availableIds:Vector.<int> = imageService.availableIds;
        assertThat(availableIds, arrayWithSize(greaterThan(1)));
    }

    [Test]
    public function shouldReturnBitmapById():void {
        var bitmap:Bitmap = imageService.getImageById(imageService.availableIds[0]);
        assertThat(bitmap, notNullValue());
        assertThat(bitmap, instanceOf(Bitmap));
    }
}
}
