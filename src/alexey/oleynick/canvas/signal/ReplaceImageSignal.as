package alexey.oleynick.canvas.signal {
import alexey.oleynick.canvas.view.item.IGalleryItemView;

import org.osflash.signals.Signal;

public class ReplaceImageSignal extends Signal {
    public function ReplaceImageSignal() {
        super(IGalleryItemView, IGalleryItemView);
    }
}
}
