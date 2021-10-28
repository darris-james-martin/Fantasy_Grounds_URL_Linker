--[[
    Use this to add new sidebar containers
]]--

function onInit()
    LibraryData.aRecords["links"] =
    {
        bExport = true,
        aDataMap = { "links", "reference.links" },
        sEditMode = "play",
        aDisplayIcon = { "button_sidebar_dockitem", "button_sidebar_dockitem_down" },
        sRecordDisplayClass = "link_sheet",
    }
    
end