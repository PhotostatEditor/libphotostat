void test_read () {
    var reader = new LibPhotostat.Reader ("images/image_1.png");
    reader.run ();
}


int main (string[] args) {
    test_read ();

    return 0;
}
