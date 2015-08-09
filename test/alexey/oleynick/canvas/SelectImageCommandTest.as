package alexey.oleynick.canvas {
import alexey.oleynick.canvas.signal.ReplaceImageSignal;
import alexey.oleynick.canvas.view.item.IGalleryItemView;
import alexey.oleynick.canvas.view.item.factory.IGalleryItemViewFactory;
import alexey.oleynick.model.IImageModel;

import mockolate.received;
import mockolate.runner.MockolateRule;
import mockolate.stub;

import org.hamcrest.assertThat;

public class SelectImageCommandTest {

    [Rule]
    public var rule:MockolateRule = new MockolateRule();

    [Mock]
    public var model:IImageModel;

    [Mock]
    public var replaceSignal:ReplaceImageSignal;

    [Mock]
    public var galleryItemViewFactory:IGalleryItemViewFactory;

    [Mock]
    public var sourceGalleryItemView:IGalleryItemView;
    [Mock]
    public var targetGalleryItemView:IGalleryItemView;

    private var selectImageCommand:SelectImageCommand;

    [Before]
    public function setUp():void {
        stub(galleryItemViewFactory).method("getImageByBitmap").returns(targetGalleryItemView);
        selectImageCommand = new SelectImageCommand();
        selectImageCommand.model = model;
        selectImageCommand.imageToReplace = sourceGalleryItemView;
        selectImageCommand.galleryItemViewFactory = galleryItemViewFactory;
        selectImageCommand.replaceSignal = replaceSignal;
    }

    [Test]
    public function shouldDispatchReplaceSignalWithInjectedItemAndItemFromFactory():void {
        selectImageCommand.execute();
        assertThat(replaceSignal, received().method("dispatch").args(sourceGalleryItemView, targetGalleryItemView));
    }
}
}
