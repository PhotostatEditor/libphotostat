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

public struct LibPhotostat.Utils.Rectangle {
    // Note that all the dimensions are stored as integers.
    // This is because the dimensions refer to pixels which can only be whole numbers.
    public int x1;
    public int y1;
    public int x2;
    public int y2;

    public Rectangle (int x1, int y1, int x2, int y2) {
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;
    }

    public int center_x {
        get {
            return (int) ( (x2 - x1) / 2 );
        }
    }
    public int center_y {
        get {
            return (int) ( (y2 - y1) / 2 );
        }
    }

}
