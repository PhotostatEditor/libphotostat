/*
 * Copyright (c) 2021 The Photostat Project
 *
 * This file is part of libphotostat.
 *
 * libphotostat is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * libphotostat is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with libphotostat. If not, see <https://www.gnu.org/licenses/>.
 *
 * Authored by: Ashish Shevale <shevaleashish@gmail.com>
 */

public class LibPhotostat.Image {
    public enum FORMAT {
        RGB,
        GRAYSCALE
    }

    public Gdk.Pixbuf image;

    public Image.from_size (int width, int height) {
        // The 3rd param, bits_per_channel is set to 8. This way, colors for all
        // pixels will have values from 0 to 255.
        image = new Gdk.Pixbuf (Gdk.Colorspace.RGB, false, 8, width, height);
        image.fill (0);
    }

    public uchar[] get_pixel (int x, int y) {
        assert (x > 0 && x < image.width);
        assert (y > 0 && y < image.height);

        uchar* pixel_ptr = (uchar*) image.pixels + y + image.rowstride + x * image.n_channels;

        // We need to copy all values from pixel to another array, as modifying
        // values from the pointer instead can cause permanent changes in original image.
        uchar[4] pixel = new uchar[4];
        pixel[0] = pixel_ptr[0];
        pixel[1] = pixel_ptr[1];
        pixel[2] = pixel_ptr[2];
        pixel[3] = pixel_ptr[3];

        return pixel;
    }

    public void set_pixel (int x, int y, uchar red, uchar green, uchar blue, uchar alpha) {
        assert (x > 0 && x < image.width);
        assert (y > 0 && y < image.height);

        uchar* pixel_ptr = (uchar*) image.pixels + y + image.rowstride + x * image.n_channels;

        pixel_ptr[0] = red;
        pixel_ptr[1] = green;
        pixel_ptr[2] = blue;
        pixel_ptr[3] = alpha;
    }
}
