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

 /*
 Inversion is calculated using the formula
    new_channel = max_channel_value - old_channel
        where new_channel and old_channel refer to red, green and blue values of each pixel.
 */

public class LibPhotostat.PointOps.Inversion : AbstractOperation {

    public Inversion () {
    }

    public override void perform_operation () {
        processed = original.copy ();

        for (int i = operation_bounds.x1; i <= operation_bounds.x2; ++i) {
            for (int j = operation_bounds.y1; j <= operation_bounds.y2; ++j) {
                uchar* pixel = original.get_pixel (i, j);

                var red = 255 - pixel[0];
                var green = 255 - pixel[1];
                var blue = 255 - pixel[2];
                var alpha = pixel[3];

                processed.set_pixel (i, j, red, green, blue, alpha);
            }
        }
    }

    public override void set_parameter (string parameter, string value) {
        warning ("""Invalid parameter %s given to Inversion operation.""".printf (parameter));
    }

    public override void set_operation_bounds (Utils.Rectangle bounds) {
        this.operation_bounds = bounds;
    }
}
