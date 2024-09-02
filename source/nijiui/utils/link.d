/*
    Copyright © 2022, Inochi2D Project
    Copyright © 2024, nijigenerate Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/
module nijiui.utils.link;
import std.process;

/**
    Opens a link with the user's preferred webbrowser
*/
void uiOpenLink(string link) {
    version(Windows) {
        spawnShell("start " ~ link);
    } else version(OSX) {
        spawnShell("open " ~ link);
    } else version(Posix) {
        spawnShell("xdg-open " ~ link);
    }
}
