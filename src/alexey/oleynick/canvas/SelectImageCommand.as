package alexey.oleynick.canvas {
import alexey.oleynick.canvas.signal.ReplaceImageSignal;
import alexey.oleynick.canvas.view.item.IGalleryItemView;
import alexey.oleynick.canvas.view.item.factory.IGalleryItemViewFactory;
import alexey.oleynick.model.IImageModel;

import org.robotlegs.mvcs.SignalCommand;

public class SelectImageCommand extends SignalCommand {

    [Inject]
    public var model:IImageModel;

    [Inject]
    public var imageToReplace:IGalleryItemView;

    [Inject]
    public var replaceSignal:ReplaceImageSignal;

    [Inject]
    public var galleryItemViewFactory:IGalleryItemViewFactory;

    override public function execute():void {
        replaceSignal.dispatch(imageToReplace, galleryItemViewFactory.getImageByBitmap(model.getRandomBitmap()));
    }
}
}
