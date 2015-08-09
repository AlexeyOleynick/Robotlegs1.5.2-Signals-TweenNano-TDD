package alexey.oleynick.config {
import org.hamcrest.assertThat;
import org.hamcrest.number.between;

public class InMemoryColumnConfigTest {
    private var config:InMemoryColumnConfig;

    [Before]
    public function setUp():void {
        config = new InMemoryColumnConfig();
    }

    [Test]
    public function shouldReturnColumnHeightInPixels():void {
        assertThat(config.columnCount, between(1, 40));
    }

    [Test]
    public function shouldReturnColumnCount():void {
        assertThat(config.columnHeightInPixels, between(100, 2000));
    }

    [Test]
    public function shouldReturnColumnWidthInPixels():void {
        assertThat(config.columnWidthInPixels, between(10, 1000));
    }

}
}
