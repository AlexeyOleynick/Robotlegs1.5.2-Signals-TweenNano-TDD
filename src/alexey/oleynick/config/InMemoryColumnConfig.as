package alexey.oleynick.config {
public class InMemoryColumnConfig implements IImageColumnConfig {

    public function get columnHeightInPixels():int {
        return 600;
    }

    public function get columnCount():int {
        return 8;
    }

    public function get columnWidthInPixels():int {
        return 800/columnCount;
    }
}
}
