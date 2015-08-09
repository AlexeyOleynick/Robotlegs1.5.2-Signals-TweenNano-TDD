package alexey.oleynick.canvas.view.distributor.column.factory {
import alexey.oleynick.canvas.view.distributor.column.*;

public interface IImageColumnFactory {
    function getColumnByIndex(index:int):IImageColumn;
}
}
