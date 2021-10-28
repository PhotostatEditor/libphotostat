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
 Calculations for Brightness and Contrast.
    new_channel = (old_channel - 128) * contrast + brightness + 128

    where, old_channel refers to either red, green or blue channel value of a pixel in source image.
    and new_channel refers to corressponding channel in output image.

    The alpha value however remains unchanged.
 */

public class LibPhotostat.PointOps.BrightnessContrast : AbstractOperation {
    public double contrast;
    public double brightness;

    public BrightnessContrast () {
    }

    public override void perform_operation () {
        processed = original.copy ();

        for (int i = operation_bounds.x1; i <= operation_bounds.x2; ++i) {
            for (int j = operation_bounds.y1; j <= operation_bounds.y2; ++j) {
                uchar* pixel = original.get_pixel (i, j);

                // Perform computations for each channel.
                uchar red = (uchar) ((pixel[0] - 128) * contrast + brightness + 128);
                uchar green = (uchar) ((pixel[1] - 128) * contrast + brightness + 128);
                uchar blue = (uchar) ((pixel[2] - 128) * contrast + brightness + 128);
                uchar alpha = pixel[3];

                // Make sure that channel values lie within accepted range.
                Utils.Maths.clamp_pixel (ref red);
                Utils.Maths.clamp_pixel (ref green);
                Utils.Maths.clamp_pixel (ref blue);
                processed.set_pixel (i, j, red, green, blue, alpha);
            }
        }
    }

    public override void set_parameter (string parameter, string value) {
        switch (parameter) {
            case "brightness":
                brightness = double.parse (value);
                break;
            case "contrast":
                contrast = double.parse (value);
                break;
            default:
                warning ("""Invalid parameter %s given to BrightnessContrast operation.""".printf (parameter));
                break;
        }
    }

    public override void set_operation_bounds (Utils.Rectangle bounds) {
        this.operation_bounds = bounds;
    }
}
