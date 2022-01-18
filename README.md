# Fantasy_Grounds_URL_Linker 
URL Container extension created for Fantasy Grounds VTT  

Fantasy Grounds is owned by SmiteWorks and is a virtual table top application for players of tabletop role-playing games like Dungeons and Dragons.  

Using XML and LUA I created a URL Linker. An intro video can be viewed here.</br> 
https://www.youtube.com/watch?v=PStYjyGk4qs&t=7s&ab_channel=frostbyte000jm 

Download this for your own use from the Forge:</br> 
https://forge.fantasygrounds.com/shop/items/318/view 

![image](https://user-images.githubusercontent.com/93277335/149854704-27255dca-91e6-43bc-951c-31bb684386f2.png)

## Extension Code
Adding a sidebar item is fairly easy, just need to add it to the LibraryData object
```lua
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
```

The container is built in XML with LUA underline code and I created a template to keep the containers standardized. I developed this Frame and Header template to use in all of my container creations for FG.  
```xml
<?xml version="1.0" encoding="iso-8859-1"?>

<!-- 
  Template for Containers
  
-->

<root>
	<!-- Container -->
	<windowclass name="link_sheet">
		<frame>referencepage</frame>
		<placement>
			<size width="355" height="350" />
		</placement>
		<sizelimits>
			<minimum width="355" height="350" />
			<dynamic />
		</sizelimits>
		<tooltip field="name" />
		<!-- <minimize>minimized_npc</minimize>
		<nodelete /> -->
		
		<script file="campaign/containers/link_sheets/scripts/linksheet.lua" />

		<!-- subwindows -->
		<sheetdata>
			<sub_record_header name="header">
				<class>link_sheet_header</class>
			</sub_record_header>
			
			<subwindow name="content">
				<bounds>10,55,-10,-10</bounds> <!-- <bounds>10,55,-10,284</bounds> -->
				<class>link_sheet_content</class>
				<activate />
			</subwindow>
			<!-- <scrollbarcontrol name="ScrollBar1">
				<frame>
					<name>scrollbar_base</name>
					<offset>0,12,0,12</offset>
				</frame>
					<bounds>-25,65,20,245</bounds>
				<target>content</target>
				<normal name="scrollbutton_normal">
					<minimum height="scrollbutton_normal" />
				</normal>
			</scrollbarcontrol> -->
			
			<resize_recordsheet />
			<close_recordsheet />
		</sheetdata>
	</windowclass>

	<!-- Header -->
	<windowclass name="link_sheet_header">
		<margins control="0,0,0,7" />
		<script file="campaign/containers/link_sheets/scripts/linksheet_header.lua" />
		
		<!-- Objects: link on left, then right anchor, then go backwards. -->
		<sheetdata>
			<link_record_header_id name="link">
				<class>link_sheet</class>				
			</link_record_header_id>

			<anchor_record_header_right name="rightanchor" />			
			<!-- <button_record_isidentified name="isidentified" /> -->
			
			<icon_record_locked />
			<button_record_locked />
			<string_record_name_id name="name" />
			<!--<string_record_name_id name="nonid_name">
				<empty textres="library_recordtype_empty_nonid_link" />
				<invisible />
			</string_record_name_id> -->
		</sheetdata>
	</windowclass>
</root>
```

The content section is unique and I store it in a different xml file. This file is usually a mix of XML and LUA, depending on how complicated it is the LUA can either be in the same file as the XML or in its own file. 
```xml
<?xml version="1.0" encoding="iso-8859-1"?>
<root>
  <windowclass name="link_sheet_content">
    <placement>
      <size height="280" width="330" />
    </placement>
    <script>
function onInit()
    update();
end
function update()
    local bReadOnly = WindowManager.getReadOnlyState(getDatabaseNode());
    url_desc.setReadOnly(bReadOnly);
    url_string.setReadOnly(bReadOnly);
end
</script>
    <sheetdata>
      <stringcontrol name="Label3">
        <bounds>23,0,108,20</bounds>
        <static textres="link_sheet_content_Label3_LabelCaption" />
        <readonly />
      </stringcontrol>
      <stringcontrol name="Label1">
        <bounds>10,136,100,20</bounds>
        <static textres="link_sheet_content_Label1_LabelCaption" />
        <readonly />
      </stringcontrol>
      <stringcontrol name="Label4">
        <bounds>-110,-22,100,20</bounds>
        <center />
        <static textres="link_sheet_content_Label4_LabelCaption" />
        <readonly />
      </stringcontrol>
      <genericcontrol name="IconControl2">
        <frame>
          <name>groupbox</name>
        </frame>
        <bounds>21,21,-26,105</bounds>
      </genericcontrol>
      <buttoncontrol name="btn_create">
        <frame>
          <name>buttonup</name>
        </frame>
        <bounds>15,-47,80,30</bounds>
        <state textres="link_sheet_content_btn_create_ButtonCaption" />
        <stateframe>
          <pressed name="buttonup" offset="-1,-1,-1,-1" nobaseframe="true" />
        </stateframe>
        <font>button-white</font>
        <script>

function onButtonPress()
    --declaration 
    local bHost = User.isHost();
    local sName = window.parentcontrol.window.header.subwindow.name.getValue();
    local sDesc = window.url_desc.getValue();
    local sUrl = window.url_string.getValue();
    
    --Debug.chat("bHost: ",bHost," sName: ",sName," sDesc: ",sDesc," sUrl: ",sUrl);
    
--    --Create Message
--    local msg = 
--    {
--        text=sName;
--        shortcuts=
--        {
--            {description=sDesc,
--            class="url",
--            recordname=sUrl,
--            secret=bHost}
--        }
--    }
--    Comm.addChatMessage(msg);
    
    window.url_link.setValue("url", sUrl);
    --window.url_link.setTooltipText("Test Test");
end

</script>
      </buttoncontrol>
      <stringfield name="url_desc">
        <bounds>38,32,249,82</bounds>
        <multilinespacing>20</multilinespacing>
      </stringfield>
      <stringfield name="url_string">
        <frame>
          <name>fielddark</name>
          <offset>7,5,7,5</offset>
        </frame>
        <bounds>15,161,-15,59</bounds>
        <multilinespacing>20</multilinespacing>
      </stringfield>
      <buttoncontrol name="btn_chat">
        <frame>
          <name>buttonup</name>
        </frame>
        <bounds>125,-47,-125,30</bounds>
        <state textres="link_sheet_content_btn_chat_ButtonCaption" />
        <stateframe>
          <pressed name="buttonup" offset="-1,-1,-1,-1" nobaseframe="true" />
        </stateframe>
        <font>button-white</font>
        <script>

function onButtonPress()
    --declaration 
    local sName = window.parentcontrol.window.header.subwindow.name.getValue();
    local sDesc = window.url_desc.getValue();
    local sUrl = window.url_string.getValue();
    local sUrlDisplay = string.gsub(sUrl,"://","__");
    
    --Debug.chat("bHost: ",bHost," sName: ",sName," sDesc: ",sDesc," sUrl: ",sUrl);
    
    --Create Message
    local msg = 
    {
        text="Warning: This is a URL Link: that is named: "..sName.."\n\nYou should not trust links from unknown sources. \nurl:"..sUrlDisplay;
        shortcuts=
        {
            {description=sDesc,
            class="url",
            recordname=sUrl,
            }
        }
    }
    Comm.deliverChatMessage(msg);
end

</script>
      </buttoncontrol>
      <linkfield name="url_link">
        <bounds>-73,-41,20,20</bounds>
        <description>
          <field>url_desc</field>
        </description>
        <allowdrop />
      </linkfield>
    </sheetdata>
  </windowclass>
</root>

```
