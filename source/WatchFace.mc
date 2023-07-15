import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class WatchFace extends WatchUi.WatchFace {
    function initialize() {
        WatchFace.initialize();
    }

    function onUpdate(dc as Dc) {
        WatchFace.onUpdate(dc);

        var w = dc.getWidth();
        var h = dc.getHeight();
        var time = System.getClockTime();
        dc.setColor(Data.Settings.foreground, Data.Settings.background);
        dc.clear();

        // Draw hour pips
        for (var i = 0; i < 12; i++) {
            dc.fillCircle(
                w / 2 + Math.sin((i * 30 * Math.PI) / 180) * w * 0.45,
                h / 2 - Math.cos((i * 30 * Math.PI) / 180) * h * 0.45,
                5
            );
        }
    }
}
