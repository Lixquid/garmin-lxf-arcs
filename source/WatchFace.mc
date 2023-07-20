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
        var timeInfo = Time.Gregorian.info(now, Time.FORMAT_SHORT);
        var dayProgress = now.subtract(Time.today()).value() / 86400d;
        var sys = System.getSystemStats();
        dc.setColor(Data.Settings.foreground, Data.Settings.background);
        if (dc has :setAntiAlias) {
            dc.setAntiAlias(true);
        }
        dc.clear();

        // Draw hour labels
        for (var i = 1; i <= 12; i++) {
            if (Data.Settings.numericHourMarks) {
                dc.drawText(
                    w / 2 + m * 0.43 * Math.sin((i * 30 * Math.PI) / 180),
                    h / 2 - m * 0.43 * Math.cos((i * 30 * Math.PI) / 180),
                    Graphics.FONT_TINY,
                    i.toString(),
                    Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
                );
            } else {
                dc.setPenWidth(2);
                // dc.drawLine(x1, y1, x2, y2)
                dc.drawLine(
                    w / 2 + m * 0.4 * Math.sin((i * 30 * Math.PI) / 180),
                    h / 2 - m * 0.4 * Math.cos((i * 30 * Math.PI) / 180),
                    w / 2 + m * 0.45 * Math.sin((i * 30 * Math.PI) / 180),
                    h / 2 - m * 0.45 * Math.cos((i * 30 * Math.PI) / 180)
                );
            }
        }

        var p = 0.34;

        // Draw seconds arc
        if (Data.Settings.showSeconds) {
            var secondProgress = timeInfo.sec / 60d;
            dc.setPenWidth(intMin1(m * 0.02));
            arcOrCutout(dc, w / 2, h / 2, m * (p - 0.01), secondProgress, 2);
            p -= 0.04;
        }

        // Draw minutes arc
        var minuteProgress = rem(dayProgress * 24d, 1d);
        dc.setPenWidth(intMin1(m * 0.04));
        arcOrCutout(dc, w / 2, h / 2, m * (p - 0.02), minuteProgress, 3);
        p -= 0.06;

        // Draw hour arc
        var hourProgress = rem(dayProgress * 2d, 1d);
        dc.setPenWidth(intMin1(m * 0.08));
        arcOrCutout(dc, w / 2, h / 2, m * (p - 0.04), hourProgress, 5);
        p -= 0.1;

        // Draw date
        if (Data.Settings.showDate) {
            dc.drawText(
                w / 2,
                h / 2,
                Graphics.FONT_SMALL,
                timeInfo.day.toString(),
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

    private function arcOrCutout(
        dc as Dc,
        x as Number,
        y as Number,
        r as Float,
        a as Double,
        gap as Number
    ) {
        if (Data.Settings.cutoutMode) {
            dc.drawArc(
                x,
                y,
                r,
                Graphics.ARC_CLOCKWISE,
                90 - gap - a * 360,
                90 + gap - a * 360
            );
        } else {
            dc.drawArc(x, y, r, Graphics.ARC_CLOCKWISE, 90, 90 - a * 360);
        }
    }
}
