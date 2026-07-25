import QtQuick
import Quickshell
import Quickshell.Io

Item {
  id: root

  // Plugin API provided by PluginService
  property var pluginApi: null

  // Provider metadata
  property string name: "Visual Novels"
  property var launcher: null
  property bool handleSearch: false
  property string supportedLayouts: "grid"
  property bool supportsAutoPaste: false

  // Program list: [{name, art}]
  property var games: []
  property bool loaded: false

  readonly property string jpBin: "vn"

  function init() {
    gameListProcess.running = true;
  }

  // Refresh every time the launcher opens (cheap: two small YAML reads).
  function onOpened() {
    gameListProcess.running = true;
  }

  // Read the bottle's registered programs from bottle.yml (authoritative list,
  // Textractor excluded), and resolve each program's cover art via library.yml,
  // whose entries map a program `id` to `thumbnail: grid:<file>` under the
  // bottle's grids/ dir. PyYAML decodes unicode titles correctly. Emits one
  // `name<TAB>coverPath` line per VN (coverPath empty if none / file missing).
  Process {
    id: gameListProcess
    command: ["vn-list"]
    stdout: StdioCollector {
      onStreamFinished: {
        var seen = {};
        var list = [];
        var lines = this.text.split("\n");
        for (var i = 0; i < lines.length; i++) {
          var parts = lines[i].split("\t");
          var n = (parts[0] || "").trim();
          if (!n || seen[n])
            continue;
          seen[n] = true;
          list.push({ name: n, art: (parts[1] || "").trim() });
        }
        root.games = list;
        root.loaded = true;
        if (root.launcher) {
          root.launcher.updateResults();
        }
      }
    }
  }

  // Launcher command prefix is "vn" (set in manifest metadata.commandPrefix).
  function handleCommand(searchText) {
    return searchText.startsWith(">vn");
  }

  function commands() {
    return [{
      "name": ">vn",
      "description": "Launch a visual novel reading session",
      "icon": "device-gamepad-2",
      "isTablerIcon": true,
      "isImage": false,
      "onActivate": function() {
        launcher.setSearchText(">vn ");
      }
    }];
  }

  // Called by launcher delegates for entries with isImage: true.
  function getImageUrl(entry) {
    return entry.art ? "file://" + entry.art : "";
  }

  function getResults(searchText) {
    if (!searchText.startsWith(">vn")) {
      return [];
    }

    if (!loaded) {
      return [{
        "name": "Loading…",
        "description": "Reading Bottles program list",
        "icon": "refresh",
        "isTablerIcon": true,
        "isImage": false,
        "onActivate": function() {}
      }];
    }

    if (games.length === 0) {
      return [{
        "name": "No programs found",
        "description": "Bottle 'Visual Novels' has no VN entries",
        "icon": "alert-circle",
        "isTablerIcon": true,
        "isImage": false,
        "onActivate": function() {}
      }];
    }

    var query = searchText.slice(3).trim().toLowerCase();
    var results = [];
    for (var i = 0; i < games.length; i++) {
      var g = games[i];
      if (query !== "" && g.name.toLowerCase().indexOf(query) === -1)
        continue;
      results.push(makeEntry(g));
    }
    return results;
  }

  // Separate helper so each entry captures its own program name (loop-closure).
  function makeEntry(g) {
    var progName = g.name;
    return {
      "name": progName,
      "description": "Launch VN session via Bottles",
      "icon": "device-gamepad-2",
      "isTablerIcon": true,
      "isImage": g.art !== "",
      "art": g.art,
      "provider": root,
      "onActivate": function() {
        launcher.closeImmediately();
        Qt.callLater(function() {
          Quickshell.execDetached([root.jpBin, progName]);
        });
      }
    };
  }
}
