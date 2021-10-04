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

    public uchar* get_pixel (int x, int y) {
        assert (x > 0 && x < image.width);
        assert (y > 0 && y < image.height);

        uchar* pixel = (uchar*) image.pixels + y + image.rowstride + x * image.n_channels;
        return pixel;
    }
}
