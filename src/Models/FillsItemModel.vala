/*
* Copyright (c) 2019 Alecaddd (http://alecaddd.com)
*
* This file is part of Akira.
*
* Akira is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.

* Akira is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.

* You should have received a copy of the GNU General Public License
* along with Akira.  If not, see <https://www.gnu.org/licenses/>.
*
* Authored by: Giacomo "giacomoalbe" Alberini <giacomoalbe@gmail.com>
*/

public class Akira.Models.FillsItemModel : GLib.Object {
    public string color {
        owned get {
            debug ("get color %u", item.fill_color_rgba);
            string s = "rgba(%d,%d,%d,%f)"
            .printf((int)(Math.round(item.fill_color_rgba >> 24 & 0xFF)),
                    (int)(Math.round(item.fill_color_rgba >> 16 & 0xFF)),
                    (int)(Math.round(item.fill_color_rgba >>  8 & 0xFF)),
                                    (item.fill_color_rgba >>  0 & 0xFF) / 255);
            debug ("get int to rgba %s", s);
            //return s;
            return "#%02x%02x%02x"
            .printf((int)(Math.round(item.fill_color_rgba >> 24 & 0xFF)),
                    (int)(Math.round(item.fill_color_rgba >> 16 & 0xFF)),
                    (int)(Math.round(item.fill_color_rgba >>  8 & 0xFF)));
        } set {
            debug ("set color: %s", value);
            var newRGBA = Gdk.RGBA ();
            newRGBA.parse (value);
            debug ("color choosed: %f,%f,%f,%f", newRGBA.red, newRGBA.green, newRGBA.blue, newRGBA.alpha);
            uint rgba = (uint)Math.round(newRGBA.red * 255);
            rgba = (rgba << 8) + (uint)Math.round(newRGBA.green * 255);
            rgba = (rgba << 8) + (uint)Math.round(newRGBA.blue * 255);
            rgba = (rgba << 8) + (uint)Math.round(newRGBA.alpha * 255);
            debug ("set hex2int %u\n", rgba);
            item.fill_color_rgba = rgba;
        }
    }
    public double alpha {
        get {
            return item.fill_color_rgba >> 0 & 0xFF;
        }
        set {
            var rgba = item.fill_color_rgba;
            rgba = (item.fill_color_rgba >> 8 << 8) + (uint)Math.round(value * 255);
        }
    }
    public bool hidden { get; set; }
    public Akira.Utils.BlendingMode blending_mode { get; set; }
    public Akira.Models.FillsListModel list_model { get; set; }
    public Goo.CanvasItemSimple item { get; construct; }

    public FillsItemModel(Goo.CanvasItemSimple item_simple,
                          int opacity,
                           double alpha,
                           bool hidden,
                           Akira.Utils.BlendingMode blending_mode,
                           Akira.Models.FillsListModel list_model) {
        Object (
            alpha: alpha,
            hidden: hidden,
            blending_mode: blending_mode,
            list_model: list_model,
            item: item_simple
        );
    }

    public string to_string () {
        return "Color: %s\nAlpha: %f\nHidden: %s\nBlendingMode: %s".printf (
            color, alpha, (hidden ? "1" : "0"), blending_mode.to_string ());
    }
}
