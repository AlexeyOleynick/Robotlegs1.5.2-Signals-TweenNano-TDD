package alexey.oleynick.canvas.view.distributor {
import alexey.oleynick.canvas.view.distributor.column.IImageColumn;
import alexey.oleynick.canvas.view.distributor.column.factory.IImageColumnFactory;
import alexey.oleynick.canvas.view.item.IGalleryItemView;
import alexey.oleynick.config.IImageColumnConfig;

import org.osflash.signals.Signal;

public class ColumnImageDistributor implements IImageDistributor {
    private var config:IImageColumnConfig;
    private var columnsWithImages:Vector.<IImageColumn>;

    private var _imageAddedSignal:Signal = new Signal(IGalleryItemView);
    private var _imageRemovedSignal:Signal = new Signal(IGalleryItemView);

    public function ColumnImageDistributor(config:IImageColumnConfig, imageColumnFactory:IImageColumnFactory) {
        this.config = config;
        columnsWithImages = new Vector.<IImageColumn>(config.columnCount, true);

        for (var columnIndex:int = 0; columnIndex < config.columnCount; columnIndex++) {
            columnsWithImages[columnIndex] = imageColumnFactory.getColumnByIndex(columnIndex);
        }
    }

    public function get imageAddedSignal():Signal {
        return _imageAddedSignal;
    }

    public function get imageRemovedSignal():Signal {
        return _imageRemovedSignal;
    }

    public function get isFull():Boolean {
        for each (var column:IImageColumn in columnsWithImages) {
            if (!column.isFull) return false;
        }
        return true;
    }

    public function placeImage(imageView:IGalleryItemView):void {
        var columnToAddTo:IImageColumn = getColumnWithMinimumHeight();
        columnToAddTo.add(imageView);
        _imageAddedSignal.dispatch(imageView);
    }

    public function replaceImage(image:IGalleryItemView, replaceWith:IGalleryItemView):void {
        var column:IImageColumn = getColumnThatContains(image);

        column.replaceImage(image, replaceWith);

        replaceWith.show(_imageAddedSignal.dispatch);
        image.hide(_imageRemovedSignal.dispatch);

    }

    private function getColumnThatContains(image:IGalleryItemView):IImageColumn {
        for each (var column:IImageColumn in columnsWithImages) {
            if (column.contains(image)) {
                return column;
            }
        }
        throw new Error("Image not found in column");
    }

    private function getColumnWithMinimumHeight():IImageColumn {
        var columnWithMinHeight:IImageColumn = columnsWithImages[0];
        for (var columnIndex:int = 1; columnIndex < columnsWithImages.length; columnIndex++) {
            var columnToCompare:IImageColumn = columnsWithImages[columnIndex];
            if (columnToCompare.height < columnWithMinHeight.height) {
                columnWithMinHeight = columnToCompare;
            }
        }
        return columnWithMinHeight;
    }
}
}
