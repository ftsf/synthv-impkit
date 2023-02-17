function getClientInfo()
    return {
        name = "Fade Off",
        author = "impbox",
        versionNumber = 1,
        minEditorVersion = 0
    }
end

function main()
    local selectedNotes = SV:getMainEditor():getSelection():getSelectedNotes()
    if #selectedNotes == 0 then
        return
    end
    local group = selectedNotes[1]:getParent()
    local param = group:getParameter("voicing")
    local startPos = selectedNotes[1]:getOnset()
    local endPos = selectedNotes[#selectedNotes]:getEnd()
    local def = param:getDefinition()
    local default = def.defaultValue
    local startValue = param:get(startPos)
    local postValue = param:get(endPos+1)
    param:add(startPos, startValue)
    param:add(endPos, def.range[1])
    param:add(endPos+1, startValue)
    SV:finish()
end

