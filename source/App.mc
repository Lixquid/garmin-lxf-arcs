import Toybox.Application;
import Toybox.Application.Properties;
import Toybox.WatchUi;

class App extends Application.AppBase {
    function initialize() {
        AppBase.initialize();
        Data.Settings.load();
    }

    function getInitialView() {
        return [new WatchFace()];
    }

    function onSettingsChanged() {
        Data.Settings.load();
        WatchUi.requestUpdate();
    }

    function getSettingsView() {
        var menu = SettingsMenu.create();
        return [menu, new SettingsMenu.Delegate(menu)];
    }
}
