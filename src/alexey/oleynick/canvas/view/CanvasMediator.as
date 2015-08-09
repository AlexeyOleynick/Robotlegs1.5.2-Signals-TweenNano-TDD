package alexey.oleynick.canvas.view {
import alexey.oleynick.canvas.signal.ReplaceImageSignal;
import alexey.oleynick.canvas.view.item.IGalleryItemView;
import alexey.oleynick.model.IImageModel;

import org.robotlegs.mvcs.Mediator;

public class CanvasMediator extends Mediator {

    private var replaceImageSignal:ReplaceImageSignal;

    private var view:ICanvasView;
    private var model:IImageModel;

    public function CanvasMediator(view:ICanvasView, model:IImageModel, replaceImageSignal:ReplaceImageSignal) {
        this.view = view;
        this.model = model;
        this.replaceImageSignal = replaceImageSignal;
    }

    override public function onRegister():void {
        replaceImageSignal.add(replaceImage);
    }

    private function replaceImage(source:IGalleryItemView, target:IGalleryItemView):void {
        view.replaceImage(source, target);
    }
}
}
