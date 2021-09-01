void func () {
    assert (true);
}


int main (string[] args) {
    Test.init (ref args);
    Test.add_func ("/test/func", func);
    Test.run ();

    return 0;
}
