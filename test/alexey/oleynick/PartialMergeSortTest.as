package alexey.oleynick {
import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

public class PartialMergeSortTest {

    [Test]
    public function shouldMergeTwoSortedArraysWithSortRetention():void {
        var first:Array = [1, 6, 10, 21, 56, 342, 3241];
        var second:Array = [2, 11, 6453, 8000];
        var requiredResult:Array = [1, 2, 6, 10, 11, 21, 56, 342, 3241, 6453, 8000];

        assertThat(mergeArrays(first, second), equalTo(requiredResult));

        first = [5];
        second = [2, 11, 6453, 8000];
        requiredResult = [2, 5, 11, 6453, 8000];

        assertThat(mergeArrays(first, second), equalTo(requiredResult));
    }

    private function mergeArrays(first:Array, second:Array):Array {
        var firstPointer:int = 0;
        var secondPointer:int = 0;

        var mergedArray:Array = [];

        while (firstPointer < first.length && secondPointer < second.length) {

            if (first[firstPointer] < second[secondPointer]) {
                mergedArray.push(first[firstPointer]);
                firstPointer++;
            } else {
                mergedArray.push(second[secondPointer]);
                secondPointer++;
            }

        }

        while (firstPointer < first.length) {
            mergedArray.push(first[firstPointer]);
            firstPointer++;
        }

        while (secondPointer < second.length) {
            mergedArray.push(second[secondPointer]);
            secondPointer++;
        }

        return mergedArray;
    }

}
}
