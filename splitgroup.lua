function getClientInfo()
    return {
        name = "Split Group",
        author = "impbox",
        versionNumber = 1,
        minEditorVersion = 0
    }
end

function getTranslations(langCode)
    -- please help add translations <3
    return {}
end

function main()
    -- takes selected notes and selects all their parameters and makes a new group
    -- should work even inside a group, making a new group
    local sel = SV:getMainEditor():getSelection()
    if sel ~= nil then
        local notes = sel:getSelectedNotes()
        if #notes > 0 then
            -- create a new group
            -- add selected notes and remove the starting offset
            local group = notes[1]:getParent()
            local newGroup = SV:create("NoteGroup")
            local name = ""
            local startOffset = notes[1]:getOnset()
            for i=1, #notes do
                local note = notes[i]
                local newNote = note:clone()
                newNote:setOnset(newNote:getOnset() - startOffset)
                newGroup:addNote(newNote)
                local lyrics = newNote:getLyrics()
                if not (lyrics == "+" or lyrics == "-") then
                    name = name .. newNote:getLyrics()
                    if i ~= #notes then
                        name = name .. " "
                    end
                end
            end
            newGroup:setName(name)
            -- delete notes from old group
            for i=1, #notes do
                local note = notes[i]
                local index = note:getIndexInParent()
                group:removeNote(index)
            end
            -- TODO: recalculate old group offset in case stuff was deleted from start

            local project = SV:getProject()
            project:addNoteGroup(newGroup)
            -- add note group reference
            local ngr = SV:getMainEditor():getCurrentGroup()
            local newNgr = SV:create("NoteGroupReference")
            newNgr:setPitchOffset(ngr:getPitchOffset())
            --[[ -- currently broken https://forum.synthesizerv.com/t/topic/6182
            local voice = ngr:getVoice()
            newNgr:setVoice(voice)
            --]]
            newNgr:setTimeOffset(ngr:getOnset() + startOffset)
            newNgr:setTarget(newGroup)
            SV:getMainEditor():getCurrentTrack():addGroupReference(newNgr)
        end
    end
    SV:finish()
end
