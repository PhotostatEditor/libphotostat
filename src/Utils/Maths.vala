public class LibPhotostat.Utils.Maths {
    public static void clamp_pixel (ref uchar value) {
        value = value > 255 ? 255 : (value < 0 ? 0 : value);
    }
}
