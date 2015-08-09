package alexey.oleynick.canvas.view.distributor.column {
import alexey.oleynick.canvas.view.item.IGalleryItemView;
import alexey.oleynick.config.IImageColumnConfig;

import flash.display.Sprite;

import mockolate.received;
import mockolate.runner.MockolateRule;
import mockolate.stub;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

public class VectorImageColumnTest {

    [Rule]
    public var rule:MockolateRule = new MockolateRule();

    [Mock]
    public var config:IImageColumnConfig;

    [Mock]
    public var galleryItemView100x100:IGalleryItemView;
    [Mock]
    public var galleryItemView200x100:IGalleryItemView;
    [Mock]
    public var galleryItemView400x100:IGalleryItemView;

    private var vectorImageColumn:VectorImageColumn;

    [Before]
    public function setUp():void {
        stub(config).getter("columnHeightInPixels").returns(400);
        stub(config).getter("columnWidthInPixels").returns(100);

        stub(galleryItemView100x100).getter("displayObject").returns(getSpriteWithSize(100, 100));
        stub(galleryItemView200x100).getter("displayObject").returns(getSpriteWithSize(200, 100));
        stub(galleryItemView400x100).getter("displayObject").returns(getSpriteWithSize(400, 100));
        vectorImageColumn = new VectorImageColumn(config, 2);
    }

    [Test]
    public function shouldSetCoordinatesAccordingToColumnIndexAndScaleImageOnAdd():void {
        vectorImageColumn.add(galleryItemView100x100);
        assertThat(galleryItemView100x100.displayObject.scaleX, equalTo(1));
        assertThat(galleryItemView100x100.displayObject.scaleY, equalTo(1));
        assertThat(galleryItemView100x100.displayObject.x, equalTo(200));
        assertThat(galleryItemView100x100.displayObject.y, equalTo(0));

        vectorImageColumn.add(galleryItemView200x100);
        assertThat(galleryItemView200x100.displayObject.scaleX, equalTo(0.5));
        assertThat(galleryItemView200x100.displayObject.scaleY, equalTo(0.5));
        assertThat(galleryItemView200x100.displayObject.x, equalTo(200));
        assertThat(galleryItemView200x100.displayObject.y, equalTo(100));
    }

    [Test]
    public function shouldReturnHeightAsTotalHeightOfTheImages():void {
        vectorImageColumn.add(galleryItemView100x100);
        vectorImageColumn.add(galleryItemView200x100);
        assertThat(vectorImageColumn.height, equalTo(150));
    }

    [Test]
    public function isFullShouldReturnTrueIfTotalHeightMoreThanHeightInConfig():void {
        assertThat(vectorImageColumn.isFull, equalTo(false));

        vectorImageColumn.add(galleryItemView100x100);
        vectorImageColumn.add(galleryItemView100x100);
        assertThat(vectorImageColumn.isFull, equalTo(false));

        vectorImageColumn.add(galleryItemView100x100);
        vectorImageColumn.add(galleryItemView100x100);
        assertThat(vectorImageColumn.isFull, equalTo(false));

        vectorImageColumn.add(galleryItemView100x100);
        assertThat(vectorImageColumn.isFull, equalTo(true));
    }

    [Test]
    public function containsShouldReturnTrueIfImageWasAdded():void {
        assertThat(vectorImageColumn.contains(galleryItemView100x100), equalTo(false));
        vectorImageColumn.add(galleryItemView100x100);
        assertThat(vectorImageColumn.contains(galleryItemView100x100), equalTo(true));
    }

    [Test]
    public function shouldSetTheSameCoordinatesOnReplace():void {
        vectorImageColumn.add(galleryItemView100x100);
        vectorImageColumn.add(galleryItemView200x100);
        vectorImageColumn.replaceImage(galleryItemView200x100, galleryItemView400x100);
        assertThat(galleryItemView400x100.displayObject.x, equalTo(200));
        assertThat(galleryItemView400x100.displayObject.y, equalTo(100));
    }

    [Test]
    public function shouldScaleImageOnReplace():void {
        vectorImageColumn.add(galleryItemView100x100);
        vectorImageColumn.add(galleryItemView200x100);
        vectorImageColumn.replaceImage(galleryItemView200x100, galleryItemView400x100);
        assertThat(galleryItemView400x100.displayObject.scaleX, equalTo(0.25));
        assertThat(galleryItemView400x100.displayObject.scaleY, equalTo(0.25));
    }

    [Test]
    public function shouldShiftImagesBelowOnReplace():void {
        vectorImageColumn.add(galleryItemView100x100);
        vectorImageColumn.add(galleryItemView200x100);
        vectorImageColumn.replaceImage(galleryItemView100x100, galleryItemView400x100);
        assertThat(galleryItemView200x100, received().method("shiftYto").arg(25));
    }

    private function getSpriteWithSize(width:int, height:int):Sprite {
        var sprite:Sprite = new Sprite();
        sprite.graphics.drawRect(0, 0, width, height);
        return sprite;
    }
}
}
