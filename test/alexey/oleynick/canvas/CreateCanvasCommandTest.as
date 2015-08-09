package alexey.oleynick.canvas {
import alexey.oleynick.canvas.view.ICanvasView;
import alexey.oleynick.canvas.view.item.IGalleryItemView;
import alexey.oleynick.canvas.view.item.factory.IGalleryItemViewFactory;
import alexey.oleynick.model.IImageModel;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import mockolate.received;
import mockolate.runner.MockolateRule;
import mockolate.stub;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

public class CreateCanvasCommandTest {

    [Rule]
    public var rule:MockolateRule = new MockolateRule();

    [Mock]
    public var canvasView:ICanvasView;

    [Mock]
    public var imageModel:IImageModel;

    [Mock]
    public var galleryItemViewFactory:IGalleryItemViewFactory;

    [Mock]
    public var galleryItemView:IGalleryItemView;

    private var createCanvasCommand:CreateCanvasCommand;

    private var canvasDisplayObject:DisplayObject = new Sprite();

    private var contextView:DisplayObjectContainer = new Sprite();

    [Before]
    public function setUp():void {
        stub(canvasView).getter("displayObject").returns(canvasDisplayObject);
        stub(canvasView).getter("isFull").returns(false, false, true);

        stub(galleryItemViewFactory).method("getImageByBitmap").returns(galleryItemView);

        createCanvasCommand = new CreateCanvasCommand(canvasView, imageModel, galleryItemViewFactory);
        createCanvasCommand.contextView = contextView;
    }

    [Test]
    public function shouldInsertDisplayObjectFromCanvasToRoot():void {
        createCanvasCommand.execute();
        assertThat(contextView.contains(canvasDisplayObject), equalTo(true));
    }

    [Test]
    public function shouldAddGalleryItemViewFromFactoryToCanvasTwice():void {
        createCanvasCommand.execute();
        assertThat(canvasView, received().method("addImage").arg(galleryItemView).twice());
    }

}
}
