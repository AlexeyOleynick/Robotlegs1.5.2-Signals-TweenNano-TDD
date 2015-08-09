package alexey.oleynick.canvas.view.distributor.column.factory {
import alexey.oleynick.canvas.view.distributor.column.VectorImageColumn;
import alexey.oleynick.config.InMemoryColumnConfig;

import org.hamcrest.assertThat;
import org.hamcrest.object.instanceOf;

public class VectorImageColumnFactoryTest {

    [Test]
    public function shouldReturnVectorImageColumn():void {
        var factory:VectorImageColumnFactory = new VectorImageColumnFactory(new InMemoryColumnConfig());
        assertThat(factory.getColumnByIndex(0), instanceOf(VectorImageColumn));
    }
}
}
