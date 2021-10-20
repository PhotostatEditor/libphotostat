public class LibPhotostat.Utils.Maths {
    public static void clamp_pixel (ref uchar value) {
        if (value > 255) {
            value = 255;
        }

        if (value < 0) {
            value = 0;
        }
    }
}
