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

// Tests that the contrast and brightness setters are implemented and work as expected.
void test_parameter_setter () {
    var bc_op = new LibPhotostat.PointOps.BrightnessContrast ();

    bc_op.set_parameter ("contrast", "1.5");
    bc_op.set_parameter ("brightness", "0.5");

    assert (bc_op.contrast == 1.5);
    assert (bc_op.brightness == 0.5);
}

// Tests that the bounds setter is implemented and works as expected
void test_bounds_setter () {
    var bc_op = new LibPhotostat.PointOps.BrightnessContrast ();
    bc_op.original = new LibPhotostat.Image.from_size (10, 10);

    var bounds = LibPhotostat.Utils.Rectangle (3, 3, 8, 8);
    bc_op.set_operation_bounds (bounds);

    assert (bc_op.operation_bounds == bounds);
}

// Tests that setting bounds and performing operation only affects the concerned region
void test_bounds_effect () {
    var bc_op = new LibPhotostat.PointOps.BrightnessContrast ();
    bc_op.original = new LibPhotostat.Image.from_size (10, 10);
    bc_op.original.image.fill ((uint32) 0xffaaee00);

    var bounds = LibPhotostat.Utils.Rectangle (3, 3, 8, 8);
    bc_op.set_operation_bounds (bounds);
    bc_op.set_parameter ("contrast", "1.5");
    bc_op.set_parameter ("brightness", "0.5");

    bc_op.perform_operation ();

    // Check that a pixel outside bounds are unmodified
    uchar[] out_pixel = bc_op.processed.get_pixel (0, 0);
    uchar[] in_pixel = bc_op.original.get_pixel (0, 0);
    assert (out_pixel[0] == in_pixel[0]);
    assert (out_pixel[1] == in_pixel[1]);
    assert (out_pixel[2] == in_pixel[2]);
    assert (out_pixel[3] == in_pixel[3]);

    // Check that a pixel inside bounds is calculated correctly
    out_pixel = bc_op.processed.get_pixel (5, 5);
    assert (out_pixel[0] == 63);
    assert (out_pixel[1] == 191);
    assert (out_pixel[2] == 37);
    assert (out_pixel[3] == 63);
}

public int main (string[] args) {
    Test.init (ref args);

    Test.add_func ("/BrightnessContrast/test_parameter_setter", test_parameter_setter);
    Test.add_func ("/BrightnessContrast/test_bounds_setter", test_bounds_setter);
    Test.add_func ("/BrightnessContrast/test_bounds_effect", test_bounds_effect);

    Test.run ();

    return 0;
}
