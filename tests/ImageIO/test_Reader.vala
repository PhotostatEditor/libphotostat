// Tests that the Reader can read the image correctly
void test_read () {
    var reader = new LibPhotostat.ImageIO.Reader ("./tests/images/image_1.png");
    reader.trigger_operation ();

    // As the read operation is synchronous, no need to wait for operation_complete
    // Make sure the image was read properly
    assert (reader.processed != null);

    // If image was read, it must have non-zero dimensions
    assert (reader.processed.width != 0);
    assert (reader.processed.height != 0);
    assert (reader.processed.get_n_channels () != 0);
}

void test_fail_on_wrong_path () {
    var reader = new LibPhotostat.ImageIO.Reader ("some/wrong/path.jpg");
    reader.trigger_operation ();

    // If wrong path is given, no image will be read.
    assert (reader.processed == null);
}

public int main (string[] args) {
    Test.init (ref args);

    Test.add_func ("/Reader/test_read", test_read);
    Test.add_func ("/Reader/test_fail_on_wrong_path", test_fail_on_wrong_path);

    Test.run ();

    return 0;
}
