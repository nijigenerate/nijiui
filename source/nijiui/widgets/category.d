module nijiui.widgets.category;
import nijiui.widgets;
import bindbc.imgui;
import inmath;

private {
    struct CategoryData {
        bool open;
        bool badColor;
        bool isDark;
        ImVec4 contentBounds;
        UiImCategoryFlags flags;
    }

    ImVec4[ImGuiCol.COUNT][] colorSchemeStack;

    bool uiImGetDarkMode() {
        auto bg = igGetStyle().Colors[ImGuiCol.WindowBg];
        float h, s, v;
        igColorConvertRGBtoHSV(bg.x, bg.y, bg.z, &h, &s, &v);
        return v <= 0.5f;
    }

    void uiImApplyDarkColorScheme(ref ImGuiStyle style) {
        style.Colors[ImGuiCol.Text]                 = ImVec4(1.00f, 1.00f, 1.00f, 1.00f);
        style.Colors[ImGuiCol.TextDisabled]         = ImVec4(0.50f, 0.50f, 0.50f, 1.00f);
        style.Colors[ImGuiCol.WindowBg]             = ImVec4(0.17f, 0.17f, 0.17f, 1.00f);
        style.Colors[ImGuiCol.ChildBg]              = ImVec4(0.00f, 0.00f, 0.00f, 0.00f);
        style.Colors[ImGuiCol.PopupBg]              = ImVec4(0.08f, 0.08f, 0.08f, 0.94f);
        style.Colors[ImGuiCol.Border]               = ImVec4(0.00f, 0.00f, 0.00f, 0.16f);
        style.Colors[ImGuiCol.BorderShadow]         = ImVec4(0.00f, 0.00f, 0.00f, 0.16f);
        style.Colors[ImGuiCol.FrameBg]              = ImVec4(0.12f, 0.12f, 0.12f, 1.00f);
        style.Colors[ImGuiCol.FrameBgHovered]       = ImVec4(0.15f, 0.15f, 0.15f, 0.40f);
        style.Colors[ImGuiCol.FrameBgActive]        = ImVec4(0.22f, 0.22f, 0.22f, 0.67f);
        style.Colors[ImGuiCol.Button]               = ImVec4(0.39f, 0.39f, 0.39f, 0.40f);
        style.Colors[ImGuiCol.ButtonHovered]        = ImVec4(0.44f, 0.44f, 0.44f, 1.00f);
        style.Colors[ImGuiCol.ButtonActive]         = ImVec4(0.50f, 0.50f, 0.50f, 1.00f);
        style.Colors[ImGuiCol.Header]               = ImVec4(0.25f, 0.25f, 0.25f, 1.00f);
        style.Colors[ImGuiCol.HeaderHovered]        = ImVec4(0.28f, 0.28f, 0.28f, 0.80f);
        style.Colors[ImGuiCol.HeaderActive]         = ImVec4(0.44f, 0.44f, 0.44f, 1.00f);
        style.Colors[ImGuiCol.Separator]            = ImVec4(0.00f, 0.00f, 0.00f, 1.00f);
        style.Colors[ImGuiCol.CheckMark]            = ImVec4(0.76f, 0.76f, 0.76f, 1.00f);
        style.Colors[ImGuiCol.ScrollbarBg]          = ImVec4(0.02f, 0.02f, 0.02f, 0.53f);
        style.Colors[ImGuiCol.ScrollbarGrab]        = ImVec4(0.31f, 0.31f, 0.31f, 1.00f);
        style.Colors[ImGuiCol.ScrollbarGrabHovered] = ImVec4(0.41f, 0.41f, 0.41f, 1.00f);
        style.Colors[ImGuiCol.ScrollbarGrabActive]  = ImVec4(0.51f, 0.51f, 0.51f, 1.00f);
    }

    void uiImApplyLightColorScheme(ref ImGuiStyle style) {
        style.Colors[ImGuiCol.Text]                 = ImVec4(0.10f, 0.10f, 0.10f, 1.00f);
        style.Colors[ImGuiCol.TextDisabled]         = ImVec4(0.45f, 0.45f, 0.45f, 1.00f);
        style.Colors[ImGuiCol.WindowBg]             = ImVec4(0.96f, 0.96f, 0.96f, 1.00f);
        style.Colors[ImGuiCol.ChildBg]              = ImVec4(0.00f, 0.00f, 0.00f, 0.00f);
        style.Colors[ImGuiCol.PopupBg]              = ImVec4(0.98f, 0.98f, 0.98f, 0.98f);
        style.Colors[ImGuiCol.Border]               = ImVec4(0.00f, 0.00f, 0.00f, 0.14f);
        style.Colors[ImGuiCol.BorderShadow]         = ImVec4(0.00f, 0.00f, 0.00f, 0.08f);
        style.Colors[ImGuiCol.FrameBg]              = ImVec4(0.97f, 0.97f, 0.97f, 1.00f);
        style.Colors[ImGuiCol.FrameBgHovered]       = ImVec4(1.00f, 1.00f, 1.00f, 1.00f);
        style.Colors[ImGuiCol.FrameBgActive]        = ImVec4(0.90f, 0.90f, 0.90f, 1.00f);
        style.Colors[ImGuiCol.Button]               = ImVec4(0.98f, 0.98f, 0.98f, 1.00f);
        style.Colors[ImGuiCol.ButtonHovered]        = ImVec4(1.00f, 1.00f, 1.00f, 1.00f);
        style.Colors[ImGuiCol.ButtonActive]         = ImVec4(0.88f, 0.88f, 0.88f, 1.00f);
        style.Colors[ImGuiCol.Header]               = ImVec4(0.95f, 0.95f, 0.95f, 1.00f);
        style.Colors[ImGuiCol.HeaderHovered]        = ImVec4(0.98f, 0.98f, 0.98f, 1.00f);
        style.Colors[ImGuiCol.HeaderActive]         = ImVec4(0.90f, 0.90f, 0.90f, 1.00f);
        style.Colors[ImGuiCol.Separator]            = ImVec4(0.00f, 0.00f, 0.00f, 0.24f);
        style.Colors[ImGuiCol.CheckMark]            = ImVec4(0.15f, 0.15f, 0.15f, 1.00f);
        style.Colors[ImGuiCol.ScrollbarBg]          = ImVec4(0.94f, 0.94f, 0.94f, 1.00f);
        style.Colors[ImGuiCol.ScrollbarGrab]        = ImVec4(0.76f, 0.76f, 0.76f, 1.00f);
        style.Colors[ImGuiCol.ScrollbarGrabHovered] = ImVec4(0.68f, 0.68f, 0.68f, 1.00f);
        style.Colors[ImGuiCol.ScrollbarGrabActive]  = ImVec4(0.58f, 0.58f, 0.58f, 1.00f);
    }

    void uiImPushDarkColorScheme() {
        auto ctx = igGetCurrentContext();
        ImVec4[ImGuiCol.COUNT] saved = ctx.Style.Colors;
        colorSchemeStack ~= saved;
        uiImApplyDarkColorScheme(ctx.Style);
    }

    void uiImPushLightColorScheme() {
        auto ctx = igGetCurrentContext();
        ImVec4[ImGuiCol.COUNT] saved = ctx.Style.Colors;
        colorSchemeStack ~= saved;
        uiImApplyLightColorScheme(ctx.Style);
    }

    void uiImPopColorScheme() {
        if (colorSchemeStack.length == 0) return;
        auto ctx = igGetCurrentContext();
        ctx.Style.Colors = colorSchemeStack[$ - 1];
        colorSchemeStack.length -= 1;
    }

    void uiImGetCategoryColors(ImVec4 color, out ImVec4 hoverColor, out ImVec4 activeColor, out ImVec4 bgColor, out ImVec4 shadowColor, ref ImVec4 textColor, ref bool isDark) {
        
        // First get HSV version of color
        float h, s, v;
        hoverColor = color;
        activeColor = color;
        shadowColor = color;
        bgColor = color;

        // Assume all colors are dark and invert them if we're in light mode
        igColorConvertRGBtoHSV(color.x, color.y, color.z, &h, &s, &v);
        isDark = v <= 0.5;
        if (!isDark) textColor = ImVec4(0, 0, 0, 1);
        else textColor = ImVec4(1, 1, 1, 1);

        // Then darken/lighten it the first time for active color
        s -= 0.075*s;
        if (v > 0.5) v -= 0.05;
        else v += 0.15;
        igColorConvertHSVtoRGB(h, s, v, &activeColor.x, &activeColor.y, &activeColor.z);

        // Then darken/lighten it the second time for hover color
        s -= 0.075*s;
        if (v > 0.5) v -= 0.05;
        else v += 0.15;
        igColorConvertHSVtoRGB(h, s, v, &hoverColor.x, &hoverColor.y, &hoverColor.z);
        
        // Then darken it for bg color
        igColorConvertRGBtoHSV(color.x, color.y, color.z, &h, &s, &v);
        s *= 0.90;
        if (v <= 0.15) v = 0.15;
        else v *= 0.80;
        igColorConvertHSVtoRGB(h, s, v, &bgColor.x, &bgColor.y, &bgColor.z);
    
        // Finally the shadow color
        igColorConvertRGBtoHSV(color.x, color.y, color.z, &h, &s, &v);
        s *= 0.85;
        v *= 0.75;
        igColorConvertHSVtoRGB(h, s, v, &shadowColor.x, &shadowColor.y, &shadowColor.z);
        shadowColor.w *= 2;
    }
}

enum UiImCategoryFlags {
    None = 0,
    NoCollapse = 1,
    DefaultClosed = 2,
}

/**
    Begins a category using slightly darkened versions of the main UI colors
    
    Remember to call uiImEndCategory after!
*/
bool uiImBeginCategory(const(char)* title, UiImCategoryFlags flags = UiImCategoryFlags.None, void function(float w, float h) callback = null) {
    ImVec4 col = igGetStyle().Colors[ImGuiCol.WindowBg];
//    col = ImVec4(col.x-0.025, col.y-0.025, col.z-0.025, col.w);
    return uiImBeginCategory(title, col, flags, callback);
}

/**
    Begins a category using the defined color

    Remember to call uiImEndCategory after!
*/
bool uiImBeginCategory(const(char)* title, ImVec4 color, UiImCategoryFlags flags = UiImCategoryFlags.None, void function(float w, float h) callback = null) {
    import inmath : clamp;

    // Preserve incoming alpha so embedded overlays can keep categories translucent.
    float baseAlpha = clamp(color.w, 0.0f, 1.0f);
    color.x = clamp(color.x, 0.15, 1);
    color.y = clamp(color.y, 0.15, 1);
    color.z = clamp(color.z, 0.15, 1);
    
    // Calculate colors for category
    ImVec4 hoverColor;
    ImVec4 activeColor;
    ImVec4 shadowColor;
    ImVec4 bgColor;
    ImVec4 textColor;
    bool isDark;
    uiImGetCategoryColors(color, hoverColor, activeColor, bgColor, shadowColor, textColor, isDark);
    hoverColor.w = baseAlpha;
    activeColor.w = baseAlpha;
    bgColor = ImVec4(color.x, color.y, color.z, max(0.08f, baseAlpha * 0.14f));
    shadowColor.w = max(0.02f, baseAlpha * 0.08f);

    // Push ID of our category
    igPushID(title);
    auto storage = igGetStateStorage();
    auto id = igGetID("CATEGORYDATA");
    auto window = igGetCurrentWindow();    

    // The fun stuff starts
    igPushStyleColor(ImGuiCol.HeaderHovered, hoverColor);
    igPushStyleColor(ImGuiCol.HeaderActive, activeColor);
    igPushStyleColor(ImGuiCol.Text, textColor);
    CategoryData* data = cast(CategoryData*)ImGuiStorage_GetVoidPtr(storage, id);
    if (!data) {
        data = cast(CategoryData*)igMemAlloc(CategoryData.sizeof);
        data.open = false;
        data.contentBounds = ImVec4(
            0, 0, 0, 0
        );
        ImGuiStorage_SetVoidPtr(storage, id, data);
    }

    // Calculate some values for drawing our background color.
    data.flags = flags;
    data.badColor = isDark != uiImGetDarkMode();
    data.isDark = isDark;
    data.contentBounds.x = igGetCursorPosX();
    data.contentBounds.y = igGetCursorPosY();
    data.contentBounds.z = uiImAvailableSpace().x;

    ImVec2 cursor;
    igGetCursorScreenPos(&cursor);

    // Draw background color
    ImDrawList_AddRectFilled(
        igGetWindowDrawList(),
        ImVec2(cursor.x, cursor.y),
        ImVec2(cursor.x+data.contentBounds.z, cursor.y+data.contentBounds.w+1),
        igGetColorU32(bgColor), 6.0
    );
    
    // Draw "shadow" underneath
    ImDrawList_AddRectFilled(
        igGetWindowDrawList(),
        ImVec2(cursor.x, cursor.y+data.contentBounds.w-1),
        ImVec2(cursor.x+data.contentBounds.z, cursor.y+data.contentBounds.w+1),
        igGetColorU32(shadowColor), 6.0
    );

    // Our fancy tree node which will be used to open/close the category.
    uiImDummy(vec2(0, 2));

    float paddingX = igGetStyle().WindowPadding.x/2;
    window.ContentRegionRect.Min.x -= paddingX;
    window.WorkRect.Min.x -= paddingX;
    igSetCursorPosX(igGetCursorPosX()+paddingX);

    if (data.open) {
        ImVec2 newCursor;
        igGetCursorScreenPos(&newCursor);

        float diffY = newCursor.y-cursor.y;

        // Draw lighter fill color for contents when open
        ImDrawList_AddRectFilled(
            igGetWindowDrawList(),
            ImVec2(cursor.x+1, cursor.y+1),
            ImVec2(cursor.x+data.contentBounds.z-1, newCursor.y+data.contentBounds.w-diffY),
            igGetColorU32(ImVec4(color.x, color.y, color.z, max(0.12f, baseAlpha * 0.30f))), 6.0
        );
    }

    if (callback !is null)
        callback(data.contentBounds.z, data.contentBounds.w);

    window.ContentRegionRect.Min.x += paddingX;
    window.WorkRect.Min.x += paddingX;

    if ((data.flags & UiImCategoryFlags.NoCollapse) == UiImCategoryFlags.NoCollapse) {
        data.open = true;
        igIndent();
            igText(title);
        igUnindent();
    } else {
        bool defaultClosed = (data.flags & UiImCategoryFlags.DefaultClosed) == UiImCategoryFlags.DefaultClosed;
        data.open = igTreeNodeEx(title, defaultClosed ? 
            ImGuiTreeNodeFlags.NoTreePushOnOpen | ImGuiTreeNodeFlags.SpanAvailWidth | ImGuiTreeNodeFlags.AllowItemOverlap:
            ImGuiTreeNodeFlags.DefaultOpen | ImGuiTreeNodeFlags.NoTreePushOnOpen | ImGuiTreeNodeFlags.SpanAvailWidth | ImGuiTreeNodeFlags.AllowItemOverlap
        );
    }

    // NOTE: We use these instead of uiImDummy suiIme otherwise you can't drag
    // the tree node via drag/drop.
    igSetCursorPosY(igGetCursorPosY()+2);

    if (data.open) {
        igSetCursorPosY(igGetCursorPosY()+2);
        igIndent();
    }


    igPopStyleColor(3);

    // We force our childrens' content to fit better within ourselves
    // This gets undone after uiImEndCategory is called.
    float indentSpacing = igGetStyle().IndentSpacing;
    window.ContentRegionRect.Min.x -= indentSpacing;
    window.WorkRect.Min.x -= indentSpacing;

    if (data.badColor && data.isDark) uiImPushDarkColorScheme();
    else if (data.badColor && !data.isDark) uiImPushLightColorScheme();

    return data.open;
}

/**
    Ends a category
*/
void uiImEndCategory() {
    auto window = igGetCurrentWindow();

    // Undo our fancy content fit math.
    // This needs to be here otherwise the usable size of the child
    // window will continue to shrink
    window.ContentRegionRect.Min.x += igGetStyle().IndentSpacing;
    window.WorkRect.Min.x += igGetStyle().IndentSpacing;

    auto storage = igGetStateStorage();
    auto id = igGetID("CATEGORYDATA");
    if (CategoryData* data = cast(CategoryData*)ImGuiStorage_GetVoidPtr(storage, id)) {
        if (data.badColor) uiImPopColorScheme();
        if (data.open) {
            igUnindent();
            uiImDummy(vec2(0, 2));
        }

        data.contentBounds.w = igGetCursorPosY()-data.contentBounds.y;

        igSpacing();
        igSpacing();
    }

    igPopID();
}
