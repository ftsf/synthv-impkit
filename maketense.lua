function getClientInfo()
    return {
        name = "Make Tense",
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
    local param = group:getParameter("tension")
    local def = param:getDefinition()
    local default = def.defaultValue
    for i=1,#selectedNotes do
        local startPos = selectedNotes[i]:getOnset()
        local endPos = selectedNotes[i]:getEnd()
        local startValue = param:get(startPos)
        local postValue = param:get(endPos+1)
        param:add(startPos, startValue)
        param:add(startPos+1, def.range[2])
        param:add(endPos, postValue)
    end
    SV:finish()
end

