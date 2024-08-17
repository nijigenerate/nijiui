/*
    Copyright © 2022, nijigenerate Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/
module nijiui.core;
import bindbc.sdl;
import bindbc.imgui;

public import nijiui.core.window;
public import nijiui.core.app;
public import nijiui.core.path;
public import nijiui.core.settings;
public import nijiui.core.utils;
import inmath;
import std.exception;

private {
    double lastTime;
    double currTime;
    version(OSX) {
        enum const(char)*[] SDL_VERSIONS_MACOS = ["libSDL2.dylib", "libSDL2-2.0.dylib", "libSDL2-2.0.0.dylib"];
    }

}

void inInitUI() {
    
    // Load and init SDL2
    // Special case for macOS
    version(OSX) {
        foreach(ver; SDL_VERSIONS_MACOS) {
            auto sdlSupport = loadSDL(ver);

            if (sdlSupport != SDLSupport.noLibrary && 
                sdlSupport != SDLSupport.badLibrary) break;
        }
    }
    else auto sdlSupport = loadSDL();
    enforce(sdlSupport != SDLSupport.noLibrary, "SDL2 library not found!");
    enforce(sdlSupport != SDLSupport.badLibrary, "Bad SDL2 library found!");

    SDL_Init(SDL_INIT_EVERYTHING);

    // Load imgui
    version(BindImGui_Dynamic) loadImGui();

    // Init settings store
    inSettingsLoad();
}

/**
    Updates time, called internally by nijiui
*/
void inUpdateTime() {
    lastTime = currTime;
    if (SDL_GetTicks64) currTime = cast(double)SDL_GetTicks64()*0.001;
    else currTime = cast(double)SDL_GetTicks()*0.001;
}

/**
    Returns the current timestep of the app
*/
double inGetTime() {
    return currTime;
}

/**
    Gets delta time
*/
double inGetDeltaTime() {
    return abs(lastTime-currTime);
}