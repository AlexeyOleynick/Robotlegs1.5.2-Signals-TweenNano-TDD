package alexey.oleynick.canvas {
import alexey.oleynick.canvas.view.ICanvasView;
import alexey.oleynick.canvas.view.item.IGalleryItemView;
import alexey.oleynick.canvas.view.item.factory.IGalleryItemViewFactory;
import alexey.oleynick.model.IImageModel;

import org.robotlegs.mvcs.Command;

public class CreateCanvasCommand extends Command {

    private var canvasView:ICanvasView;
    private var imageModel:IImageModel;
    private var itemViewFactory:IGalleryItemViewFactory;

    public function CreateCanvasCommand(canvasView:ICanvasView, imageModel:IImageModel, itemViewFactory:IGalleryItemViewFactory) {
        this.canvasView = canvasView;
        this.imageModel = imageModel;
        this.itemViewFactory = itemViewFactory;
    }

    override public function execute():void {
        while (!canvasView.isFull) {
            var galleryItemView:IGalleryItemView = itemViewFactory.getImageByBitmap(imageModel.getRandomBitmap());
            canvasView.addImage(galleryItemView);
        }
        contextView.addChild(canvasView.displayObject);
    }
}
}
