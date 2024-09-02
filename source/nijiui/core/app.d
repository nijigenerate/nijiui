/*
    Copyright © 2022, Inochi2D Project
    Copyright © 2024, nijigenerate Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/
module nijiui.core.app;

private {
    __gshared InApplication APP_INFO;
}

struct InApplication {
    /**
        App name in Fully Qualified Domain Name Notation
    */
    string name;

    /**
        Name of the config file directory
    */
    string configDirName;

    /**
        App name in human readable form
    */
    string humanName;
}

void inSetApplication(InApplication app) {
    APP_INFO = app;
}

ref InApplication inGetApplication() {
    return APP_INFO;
}
