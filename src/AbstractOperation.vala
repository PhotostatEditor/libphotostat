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

public abstract class LibPhotostat.AbstractOperation : Object {
    // The original and processed images contains the values of images before and after performing the operations.
    // This makes it easier to perform undo-redo operations on images.
    public Image original;
    public Image processed;

    // Stores the region over which to apply the operation.
    public Utils.Rectangle operation_bounds;

    // This signal should be triggered whenever the operation needs to be performed.
    // Actual computation will be handled internally.
    public signal void trigger_operation ();
    // This signal gets triggered automatically when the operation is done.
    // The result of operation will not be available until this signal is triggered.
    public signal void operation_complete ();

    // This method must be defined for performing all the operations.
    // This method will only call other functions that do the actual computation.
    public virtual void perform_operation () {}

    // Operations might require some parameters. These will be added through this method.
    public virtual void set_parameter (string parameter, string value) {}

    // This method is responsible for making sure that all the parameters have correct values.
    // Optional to implement?
    public virtual void validate_parameters () {}

    // This method sets the region over which to apply the operation.
    public virtual void set_operation_bounds (Utils.Rectangle bounds) {}

    construct {
        // When the trigger_operation signal is triggered, only then perform the actual operation.
        trigger_operation.connect (() => {
            perform_operation ();
        });

        processed = new Image ();
    }

    public void set_predecessor (AbstractOperation predecessor) {
        original = predecessor.processed;
        // when predecessors operation is complete, start operation.
        predecessor.operation_complete.connect ( () => {
            trigger_operation ();
        });
    }
}
