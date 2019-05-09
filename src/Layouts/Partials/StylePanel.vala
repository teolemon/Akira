/*
 * Copyright (c) 2019 Alecaddd (http://alecaddd.com)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA
 *
 * Authored by: Bilal Elmoussaoui <bil.elmoussaoui@gmail.com>
 */

public class Akira.Layouts.Partials.StylePanel : Gtk.Box {

    public Gtk.Label label;

    private Gtk.Revealer options_revealer;
    private Gtk.Box options_box;
    private Gtk.Scale border_radius_scale;
    private Gtk.Entry border_radius_entry;
    private Gtk.ToggleButton options_button;

    private Gtk.Entry border_radius_bottom_left_entry;
    private Gtk.Entry border_radius_bottom_right_entry;
    private Gtk.Entry border_radius_top_left_entry;
    private Gtk.Entry border_radius_top_right_entry;

    private Gtk.Switch autoscale_switch;
    private Gtk.Switch uniform_switch;

    public StylePanel () {
        Object(
            orientation: Gtk.Orientation.VERTICAL
        );
    }

    construct {

        label =  new Gtk.Label (_("Style"));
        label.get_style_context ().add_class ("artboard-name");
        label.get_style_context ().add_class ("panel-title");
        label.halign = Gtk.Align.FILL;
        label.xalign = 0;
        label.hexpand = true;
        label.set_ellipsize (Pango.EllipsizeMode.END);
        pack_start (label, true, true, 0);

        var panel_grid = new Gtk.Grid ();
        get_style_context ().add_class ("style-panel");
        panel_grid.row_spacing = 6;
        panel_grid.border_width = 12;
        panel_grid.column_spacing = 6;
        panel_grid.hexpand = true;
        pack_start (panel_grid, true, true, 0);


        var border_radius_label = new Gtk.Label (_("Border Radius"));
        border_radius_label.get_style_context ().add_class ("group-title");
        border_radius_label.halign = Gtk.Align.START;
        border_radius_label.hexpand = true;
        border_radius_label.margin_bottom = 2;
        panel_grid.attach (border_radius_label, 0, 1, 3, 1);

        border_radius_scale = new Gtk.Scale.with_range (Gtk.Orientation.HORIZONTAL, 0, 100, 1);
        border_radius_scale.digits = 0;
        border_radius_scale.draw_value = false;
        border_radius_scale.valign = Gtk.Align.CENTER;
        border_radius_scale.halign = Gtk.Align.FILL;
        border_radius_scale.hexpand = true;
        panel_grid.attach (border_radius_scale, 0, 2, 1, 1);

        border_radius_entry = new Gtk.Entry ();
        border_radius_entry.width_chars = 6;
        border_radius_entry.valign = Gtk.Align.CENTER;
        panel_grid.attach (border_radius_entry, 1, 2, 1, 1);

        var options_image = new Gtk.Image.from_icon_name ("open-menu-symbolic", Gtk.IconSize.BUTTON);
        options_button = new Gtk.ToggleButton ();
        options_button.valign = Gtk.Align.CENTER;
        options_button.halign = Gtk.Align.END;
        options_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
        options_button.add (options_image);
        panel_grid.attach (options_button, 2, 2, 1, 1);

        options_revealer = new Gtk.Revealer ();
        panel_grid.attach (options_revealer, 0, 3, 3, 1);

        options_button.bind_property ("active", options_revealer, "reveal-child", BindingFlags.DEFAULT | BindingFlags.SYNC_CREATE);

        options_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
        options_box.border_width = 12;
        options_box.hexpand = true;

        var border_entries_grid = new Gtk.Grid ();
        border_entries_grid.row_spacing = 12;
        border_entries_grid.border_width = 12;
        border_entries_grid.column_spacing = 12;
        border_entries_grid.hexpand = true;

        border_radius_top_left_entry = new Gtk.Entry ();
        border_radius_top_left_entry.width_chars = 4;
        border_radius_top_left_entry.valign = Gtk.Align.CENTER;
        border_radius_top_left_entry.halign = Gtk.Align.START;
        border_entries_grid.attach (border_radius_top_left_entry, 0, 0, 1, 1);

        border_radius_top_right_entry = new Gtk.Entry ();
        border_radius_top_right_entry.width_chars = 4;
        border_radius_top_right_entry.valign = Gtk.Align.CENTER;
        border_radius_top_right_entry.halign = Gtk.Align.END;
        border_entries_grid.attach (border_radius_top_right_entry, 1, 0, 1, 1);

        border_radius_bottom_left_entry = new Gtk.Entry ();
        border_radius_bottom_left_entry.width_chars = 4;
        border_radius_bottom_left_entry.valign = Gtk.Align.CENTER;
        border_radius_bottom_left_entry.halign = Gtk.Align.START;
        border_entries_grid.attach (border_radius_bottom_left_entry, 0, 1, 1, 1);

        border_radius_bottom_right_entry = new Gtk.Entry ();
        border_radius_bottom_right_entry.valign = Gtk.Align.CENTER;
        border_radius_bottom_right_entry.halign = Gtk.Align.END;
        border_radius_bottom_right_entry.width_chars = 4;
        border_entries_grid.attach (border_radius_bottom_right_entry, 1, 1, 1, 1);

        options_box.pack_start (border_entries_grid, true, true, 0);
        options_revealer.add (options_box);


        var border_options_grid = new Gtk.Grid ();
        border_options_grid.row_spacing = 6;
        border_options_grid.border_width = 12;
        border_options_grid.column_spacing = 6;
        border_options_grid.hexpand = true;

        autoscale_switch = new Gtk.Switch ();
        autoscale_switch.valign = Gtk.Align.CENTER;
        autoscale_switch.halign = Gtk.Align.START;
        border_options_grid.attach (autoscale_switch, 0, 0, 1, 1);
        var autoscale_label = new Gtk.Label (_("Autoscale Corners"));
        autoscale_label.valign = Gtk.Align.CENTER;
        autoscale_label.halign = Gtk.Align.START;
        border_options_grid.attach (autoscale_label, 1, 0, 1, 1);

        uniform_switch = new Gtk.Switch ();
        uniform_switch.valign = Gtk.Align.CENTER;
        uniform_switch.halign = Gtk.Align.START;
        border_options_grid.attach (uniform_switch, 0, 1, 1, 1);
        var uniform_label = new Gtk.Label(_("Uniform Corners"));
        uniform_label.valign = Gtk.Align.CENTER;
        uniform_label.halign = Gtk.Align.START;
        border_options_grid.attach (uniform_label, 1, 1, 1, 1);
        options_box.pack_start (border_options_grid, true, true, 0);

        bind_signals ();
    }

    private void bind_signals () {
        border_radius_scale.value_changed.connect ( () => {
            string border_value = border_radius_scale.get_value ().to_string ();
            border_radius_entry.text = border_value;
        });

        border_radius_entry.changed.connect ( () => {
            double typed_border_radius = double.parse (border_radius_entry.text);
            border_radius_scale.set_value (typed_border_radius);
        });

        uniform_switch.activate.connect ( () => {
            if (uniform_switch.active) {
                string border_value = border_radius_scale.get_value ().to_string ();
                border_radius_bottom_left_entry.text = border_value;
                border_radius_bottom_right_entry.text = border_value;
                border_radius_top_left_entry.text = border_value;
                border_radius_top_right_entry.text = border_value;
            }
        });
    }


}
