package alexey.oleynick.canvas.view.distributor {
import alexey.oleynick.canvas.view.distributor.column.IImageColumn;
import alexey.oleynick.canvas.view.distributor.column.factory.IImageColumnFactory;
import alexey.oleynick.canvas.view.item.IGalleryItemView;
import alexey.oleynick.config.IImageColumnConfig;

import mockolate.received;
import mockolate.runner.MockolateRule;
import mockolate.stub;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.notNullValue;
import org.osflash.signals.utils.SignalAsyncEvent;
import org.osflash.signals.utils.handleSignal;

public class ColumnImageDistributorTest {

    [Rule]
    public var rule:MockolateRule = new MockolateRule();

    [Mock]
    public var config:IImageColumnConfig;

    [Mock]
    public var columnFactory:IImageColumnFactory;

    [Mock]
    public var column1:IImageColumn;
    [Mock]
    public var column2:IImageColumn;
    [Mock]
    public var column3:IImageColumn;

    [Mock]
    public var galleryItemView1:IGalleryItemView;

    [Mock]
    public var galleryItemView2:IGalleryItemView;

    private var imageDistributor:ColumnImageDistributor;

    [Before]
    public function setUp():void {
        stub(columnFactory).method("getColumnByIndex").args(0).returns(column1);
        stub(columnFactory).method("getColumnByIndex").args(1).returns(column2);
        stub(columnFactory).method("getColumnByIndex").args(2).returns(column3);

        stub(config).getter("columnCount").returns(3);

        imageDistributor = new ColumnImageDistributor(config, columnFactory);
    }

    [Test]
    public function signalsShouldNotBeNull():void {
        assertThat(imageDistributor.imageAddedSignal, notNullValue());
        assertThat(imageDistributor.imageRemovedSignal, notNullValue());
    }

    [Test]
    public function isFullShouldReturnFalseIfSomeColumnsAreNotFull():void {
        stub(column1).getter("isFull").returns(true);
        stub(column2).getter("isFull").returns(false);
        stub(column3).getter("isFull").returns(true);
        assertThat(imageDistributor.isFull, equalTo(false));
    }

    [Test]
    public function isFullShouldReturnTrueIfAllColumnsAreFull():void {
        stub(column1).getter("isFull").returns(true);
        stub(column2).getter("isFull").returns(true);
        stub(column3).getter("isFull").returns(true);
        assertThat(imageDistributor.isFull, equalTo(true));
    }

    [Test]
    public function shouldPlaceImageToColumnWithMinimumHeight():void {
        stub(column1).getter("height").returns(100);
        stub(column2).getter("height").returns(50);
        stub(column3).getter("height").returns(200);

        imageDistributor.placeImage(galleryItemView1);
        assertThat(column2, received().method("add").arg(galleryItemView1));
    }

    [Test(async)]
    public function shouldDispatchImageAddedSignalOnPlaceImage():void {
        handleSignal(this, imageDistributor.imageAddedSignal, checkImageCreatedSignal, 500, galleryItemView1);
        imageDistributor.placeImage(galleryItemView1);

    }

    [Test]
    public function shouldReplaceImageInColumnThatContains():void {
        stub(column2).method("contains").args(galleryItemView1).returns(true);
        imageDistributor.replaceImage(galleryItemView1, galleryItemView2);
        assertThat(column2, received().method("replaceImage").args(galleryItemView1, galleryItemView2));
    }

    [Test]
    public function shouldCallHideOnSourceImageWithImageRemovedSignalCallback():void {
        stub(column2).method("contains").args(galleryItemView1).returns(true);
        imageDistributor.replaceImage(galleryItemView1, galleryItemView2);
        assertThat(galleryItemView1, received().method("hide").arg(imageDistributor.imageRemovedSignal.dispatch))
    }

    [Test]
    public function shouldCallShowOnTargetImageWithImageAddedSignalCallback():void {
        stub(column2).method("contains").args(galleryItemView1).returns(true);
        imageDistributor.replaceImage(galleryItemView1, galleryItemView2);
        assertThat(galleryItemView2, received().method("show").arg(imageDistributor.imageAddedSignal.dispatch))
    }

    private function checkImageCreatedSignal(event:SignalAsyncEvent, galleryItemToCheck:Object):void {
        assertThat(event.args[0], equalTo(galleryItemToCheck));
    }

}
}
