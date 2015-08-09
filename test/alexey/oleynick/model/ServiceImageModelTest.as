package alexey.oleynick.model {
import alexey.oleynick.model.service.IImageService;

import flash.display.Bitmap;

import mockolate.runner.MockolateRule;
import mockolate.stub;

import org.hamcrest.assertThat;
import org.hamcrest.collection.inArray;
import org.hamcrest.object.strictlyEqualTo;

public class ServiceImageModelTest {

    [Rule]
    public var rule:MockolateRule = new MockolateRule();

    [Mock]
    public var imageService:IImageService;

    [Test]
    public function shouldReturnRandomBitmap():void {
        var bitmap:Bitmap = new Bitmap();

        var imageIds:Vector.<int> = new Vector.<int>();
        imageIds.push(10, 15, 23);

        stub(imageService).getter("availableIds").returns(imageIds);
        stub(imageService).method("getImageById").args(inArray([10, 15, 23])).returns(bitmap);

        var serviceImageModel:ServiceImageModel = new ServiceImageModel(imageService);
        assertThat(serviceImageModel.getRandomBitmap(), strictlyEqualTo(bitmap));
    }
}
}
