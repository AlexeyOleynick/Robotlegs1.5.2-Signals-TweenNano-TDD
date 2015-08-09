package alexey.oleynick {
import alexey.oleynick.canvas.CreateCanvasCommand;
import alexey.oleynick.canvas.SelectImageCommand;
import alexey.oleynick.canvas.signal.ImageSelectSignal;
import alexey.oleynick.canvas.signal.ReplaceImageSignal;
import alexey.oleynick.canvas.view.CanvasMediator;
import alexey.oleynick.canvas.view.CanvasView;
import alexey.oleynick.canvas.view.ICanvasView;
import alexey.oleynick.canvas.view.distributor.ColumnImageDistributor;
import alexey.oleynick.canvas.view.distributor.IImageDistributor;
import alexey.oleynick.canvas.view.distributor.column.factory.IImageColumnFactory;
import alexey.oleynick.canvas.view.distributor.column.factory.VectorImageColumnFactory;
import alexey.oleynick.canvas.view.item.animation.IAnimator;
import alexey.oleynick.canvas.view.item.animation.TweenNanoAnimator;
import alexey.oleynick.canvas.view.item.factory.BitmapGalleryItemViewFactory;
import alexey.oleynick.canvas.view.item.factory.IGalleryItemViewFactory;
import alexey.oleynick.config.IImageColumnConfig;
import alexey.oleynick.config.InMemoryColumnConfig;
import alexey.oleynick.model.IImageModel;
import alexey.oleynick.model.ServiceImageModel;
import alexey.oleynick.model.service.EmbeddedImageService;
import alexey.oleynick.model.service.IImageService;

import flash.display.DisplayObjectContainer;

import org.robotlegs.base.ContextEvent;
import org.robotlegs.mvcs.SignalContext;

public class RobotlegsStartupContext extends SignalContext {
    {

        public function RobotlegsStartupContext(contextView:DisplayObjectContainer) {
            super(contextView);
        }

        override public function startup():void {

            commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, CreateCanvasCommand, ContextEvent, true);

            signalCommandMap.mapSignalClass(ImageSelectSignal, SelectImageCommand);

            injector.mapSingletonOf(IImageColumnConfig, InMemoryColumnConfig);
            injector.mapSingletonOf(IAnimator, TweenNanoAnimator);

            injector.mapSingletonOf(IImageModel, ServiceImageModel);
            injector.mapSingletonOf(IImageService, EmbeddedImageService);
            injector.mapSingletonOf(IGalleryItemViewFactory, BitmapGalleryItemViewFactory);
            injector.mapClass(IImageDistributor, ColumnImageDistributor);
            injector.mapSingletonOf(ICanvasView, CanvasView);
            injector.mapSingleton(ReplaceImageSignal);
            injector.mapSingletonOf(IImageColumnFactory, VectorImageColumnFactory);
            mediatorMap.mapView(CanvasView, CanvasMediator);

            super.startup();

        }

    }
}
}
