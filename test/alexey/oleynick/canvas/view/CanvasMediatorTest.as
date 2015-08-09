package alexey.oleynick.canvas.view {
import alexey.oleynick.canvas.signal.ReplaceImageSignal;
import alexey.oleynick.canvas.view.item.IGalleryItemView;
import alexey.oleynick.model.IImageModel;

import mockolate.received;
import mockolate.runner.MockolateRule;

import org.hamcrest.assertThat;

public class CanvasMediatorTest {

    [Rule]
    public var rule:MockolateRule = new MockolateRule();

    [Mock]
    public var imageModel:IImageModel;
    [Mock]
    public var canvasView:ICanvasView;
    [Mock]
    public var galleryItemView1:IGalleryItemView;
    [Mock]
    public var galleryItemView2:IGalleryItemView;
    private var replaceImageSignal:ReplaceImageSignal = new ReplaceImageSignal();

    [Before]
    public function setUp():void {
        var canvasMediator:CanvasMediator = new CanvasMediator(canvasView, imageModel, replaceImageSignal);
        canvasMediator.onRegister();

    }

    [Test]
    public function shouldReplaceImageInViewOnSignalDispatch():void {
        replaceImageSignal.dispatch(galleryItemView1, galleryItemView2);
        assertThat(canvasView, received().method("replaceImage").args(galleryItemView1, galleryItemView2));
    }
}
}
