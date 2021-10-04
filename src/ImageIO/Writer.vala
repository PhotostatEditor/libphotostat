/*
 * Copyright (c) 2021 The Photostat Project
 *
 * This file is part of LibPhotostat.
 *
 * LibPhotostat is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * LibPhotostat is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with LibPhotostat. If not, see <https://www.gnu.org/licenses/>.
 *
 * Authored by: Ashish Shevale <shevaleashish@gmail.com>
 */

public class LibPhotostat.ImageIO.Writer : AbstractOperation {
    private string file_name;
    private string format;
    private Gdk.Pixbuf image;

    public bool success;

    public Writer (string file_name, Gdk.Pixbuf image, string format) {
        this.file_name = file_name;
        this.format = format;
        this.image = image;

        success = false;
    }

    public override void perform_operation () {
        try {
            image.save (file_name, format);
            success = true;
        } catch (Error e) {
            print (e.message);
            success = false;
        }
    }
}
