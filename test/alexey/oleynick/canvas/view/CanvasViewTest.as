package alexey.oleynick.canvas.view {
import alexey.oleynick.canvas.signal.ImageSelectSignal;
import alexey.oleynick.canvas.view.distributor.IImageDistributor;
import alexey.oleynick.canvas.view.item.IGalleryItemView;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;

import mockolate.received;
import mockolate.runner.MockolateRule;
import mockolate.stub;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.notNullValue;
import org.osflash.signals.Signal;

public class CanvasViewTest {
    [Rule]
    public var rule:MockolateRule = new MockolateRule();
    [Mock]
    public var imageDistributor:IImageDistributor;
    [Mock]
    public var imageSelectSignal:ImageSelectSignal;
    [Mock]
    public var galleryItemView1:IGalleryItemView;
    [Mock]
    public var galleryItemView2:IGalleryItemView;
    private var canvasView:CanvasView;
    private var galleryItemDisplayObject:DisplayObject = new Sprite();
    private var imageAddedSignal:Signal = new Signal;
    private var imageRemovedSignal:Signal = new Signal;

    [Before]
    public function setUp():void {
        stub(galleryItemView1).getter("displayObject").returns(galleryItemDisplayObject);

        stub(imageDistributor).getter("imageAddedSignal").returns(imageAddedSignal);
        stub(imageDistributor).getter("imageRemovedSignal").returns(imageRemovedSignal);
        this.canvasView = new CanvasView(imageDistributor, imageSelectSignal);
    }

    [Test]
    public function shouldReturnIsFullFromImageDistributor():void {
        stub(imageDistributor).getter("isFull").returns(true, false, true);
        assertThat(canvasView.isFull, equalTo(true));
        assertThat(canvasView.isFull, equalTo(false));
        assertThat(canvasView.isFull, equalTo(true));
    }

    [Test]
    public function displayObjectShouldNotBeNull():void {
        assertThat(canvasView.displayObject, notNullValue());
    }

    [Test]
    public function shouldForwardReplaceImageToImageDistributor():void {
        canvasView.replaceImage(galleryItemView1, galleryItemView2);
        assertThat(imageDistributor, received().method("replaceImage").args(galleryItemView1, galleryItemView2));
    }

    [Test]
    public function shouldForwardAddImageToImageDistributor():void {
        canvasView.addImage(galleryItemView1);
        assertThat(imageDistributor, received().method("placeImage").arg(galleryItemView1));
    }

    [Test]
    public function shouldAddChildOnAddedToDistributor():void {
        imageAddedSignal.dispatch(galleryItemView1);
        assertThat(canvasView.displayObject.contains(galleryItemView1.displayObject), equalTo(true));
    }

    [Test]
    public function shouldDispatchImageSelectSignalOnGalleryItemClickOnce():void {
        imageAddedSignal.dispatch(galleryItemView1);
        galleryItemView1.displayObject.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
        galleryItemView1.displayObject.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
        assertThat(imageSelectSignal, received().method("dispatch").arg(galleryItemView1.displayObject).once());
    }

    [Test]
    public function shouldRemoveChildAndDestroyOnRemovedFromDistributor():void {
        imageAddedSignal.dispatch(galleryItemView1);
        assertThat(canvasView.displayObject.contains(galleryItemView1.displayObject), equalTo(true));
        imageRemovedSignal.dispatch(galleryItemView1);
        assertThat(canvasView.displayObject.contains(galleryItemView1.displayObject), equalTo(false));
        assertThat(galleryItemView1, received().method("destroy"));
    }
}
}
