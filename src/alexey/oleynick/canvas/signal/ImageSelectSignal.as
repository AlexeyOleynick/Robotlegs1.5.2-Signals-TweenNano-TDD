package alexey.oleynick.canvas.signal {
import alexey.oleynick.canvas.view.item.IGalleryItemView;

import org.osflash.signals.Signal;

public class ImageSelectSignal extends Signal {

    public function ImageSelectSignal() {
        super(IGalleryItemView);
    }
}
}
