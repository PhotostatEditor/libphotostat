// Tests that the Writer can read the image correctly
void test_write () {
    var reader = new LibPhotostat.ImageIO.Reader ("./tests/images/image_1.png");
    reader.trigger_operation ();

    assert (reader.processed != null);

    // Now write this image to a file
    var writer = new LibPhotostat.ImageIO.Writer ("image_written.png", reader.processed.image, "png");
    writer.trigger_operation ();

    assert (writer.success);

}

public int main (string[] args) {
    Test.init (ref args);

    Test.add_func ("/writer/test_write", test_write);

    Test.run ();

    return 0;
}
