package alexey.oleynick.canvas.view.distributor.column.factory {
import alexey.oleynick.canvas.view.distributor.column.IImageColumn;
import alexey.oleynick.canvas.view.distributor.column.VectorImageColumn;
import alexey.oleynick.config.IImageColumnConfig;

public class VectorImageColumnFactory implements IImageColumnFactory {

    private var config:IImageColumnConfig;

    public function VectorImageColumnFactory(config:IImageColumnConfig) {
        this.config = config;
    }

    public function getColumnByIndex(index:int):IImageColumn {
        return new VectorImageColumn(config, index);
    }
}
}
