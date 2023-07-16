import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;
import Toybox.WatchUi;

class WatchFace extends WatchUi.WatchFace {
    function initialize() {
        WatchFace.initialize();
    }

    function onUpdate(dc as Dc) {
        WatchFace.onUpdate(dc);

        var w = dc.getWidth();
        var h = dc.getHeight();
        var m = min(w, h);
        var now = Time.now();
        var dayProgress = now.subtract(Time.today()).value() / 86400d;
        var sys = System.getSystemStats();
        dc.setColor(Data.Settings.foreground, Data.Settings.background);
        dc.clear();

        // Draw hour labels
        for (var i = 1; i <= 12; i++) {
            dc.drawText(
                w / 2 + m * 0.43 * Math.sin((i * 30 * Math.PI) / 180),
                h / 2 - m * 0.43 * Math.cos((i * 30 * Math.PI) / 180),
                Graphics.FONT_TINY,
                i.toString(),
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
            );
        }

        // Draw hour arc
        var hourProgress = rem(dayProgress * 2d, 1d);
        dc.setPenWidth(intMin1(m * 0.08));
        dc.drawArc(
            w / 2,
            h / 2,
            m * 0.2,
            Graphics.ARC_CLOCKWISE,
            90,
            90 - hourProgress * 360
        );

        // Draw minutes arc
        var minuteProgress = rem(dayProgress * 24d, 1d);
        dc.setPenWidth(intMin1(m * 0.04));
        dc.drawArc(
            w / 2,
            h / 2,
            m * 0.28,
            Graphics.ARC_CLOCKWISE,
            90,
            90 - minuteProgress * 360
        );

        // Draw seconds arc
        var secondProgress = rem(dayProgress * 1440d, 1d);
        dc.setPenWidth(intMin1(m * 0.02));
        dc.drawArc(
            w / 2,
            h / 2,
            m * 0.33,
            Graphics.ARC_CLOCKWISE,
            90,
            90 - secondProgress * 360
        );

        // Draw date
        if (Data.Settings.showDate) {
            var day = Time.Gregorian.info(now, Time.FORMAT_SHORT).day;
            dc.drawText(
                w / 2,
                h / 2,
                Graphics.FONT_SMALL,
                day.toString(),
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
            );
        }

        // Draw battery level
        if (Data.Settings.showBattery) {
            dc.setPenWidth(1);
            dc.drawArc(w / 2, h / 2, m * 0.1, Graphics.ARC_CLOCKWISE, 0, 180);
            dc.setPenWidth(intMin1(m * 0.02));
            dc.drawArc(
                w / 2,
                h / 2,
                m * 0.1,
                Graphics.ARC_CLOCKWISE,
                0,
                sys.battery * -1.8
            );

            // Draw battery dot if charging
            dc.fillCircle(w / 2 + m * 0.1, h / 2, m * 0.025);
        }
    }

    private function rem(a as Double, b as Double) as Double {
        return a - Math.floor(a / b) * b;
    }

    private function intMin1(a as Float) as Number {
        var v = a.toNumber();
        return v < 1 ? 1 : v;
    }

    private function min(a as Number, b as Number) as Number {
        return a < b ? a : b;
    }
}
