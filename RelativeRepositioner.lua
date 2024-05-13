local objectAGUID = nil
local objectBGUID = nil

local xInput = 0
local yInput = 0
local zInput = 0

function onLoad() 

    self.createButton({
        click_function = "copy",
        function_owner = self,
        position = {0, 0.1, 1.7},
        height = 240,
        width = 550,
        color = {1, 1, 1, 0}
        })

    self.createInput({
        input_function = "handleInputA",
        function_owner = self,
        label = "Object A GUID",
        alignment = 3,
        position = {-0.6, 0.1, 1.18},
        width = 500,
        height = 130,
        font_size = 60,
        validation = 4,
    })

    self.createInput({
        input_function = "handleInputB",
        function_owner = self,
        label = "Object B GUID",
        alignment = 3,
        position = {0.6, 0.1, 1.18},
        width = 500,
        height = 130,
        font_size = 60,
        validation = 4,
    })

    self.createInput({
        input_function = "handleInputX",
        function_owner = self,
        label = "X Offset",
        alignment = 3,
        position = {-0.95, 0.1, 0.05},
        width = 260,
        height = 130,
        font_size = 60
    })

    self.createInput({
        input_function = "handleInputY",
        function_owner = self,
        label = "Y Offset",
        alignment = 3,
        position = {0, 0.1, 0.05},
        width = 260,
        height = 130,
        font_size = 60
    })

    self.createInput({
        input_function = "handleInputZ",
        function_owner = self,
        label = "Z Offset",
        alignment = 3,
        position = {0.95, 0.1, 0.05},
        width = 260,
        height = 130,
        font_size = 60
    })

end

function copy() 

    if isAValidGUID(objectAGUID) and isAValidGUID(objectBGUID) then
        local objectAPosition = getObjectFromGUID(objectAGUID).getPosition()
        local newX = objectAPosition.x + xInput
        local newY = objectAPosition.y + yInput
        local newZ = objectAPosition.z + zInput
        getObjectFromGUID(objectBGUID).setPosition({newX, newY, newZ})
    end
end

function handleInputA(obj, color, input, stillEditing)

    obj.editInput({
        index = 0,
        value = input
    })

    if not stillEditing then
        if isAValidGUID(input) then
            objectAGUID = input
            print(string.format("Object A set to GUID: %s", input))
        end
    end
end


function isAValidGUID(string)
    return getObjectFromGUID(string) ~= nil
end

function handleInputB(obj, color, input, stillEditing)

    obj.editInput({
        index = 1,
        value = input
    })

    if not stillEditing then
        if isAValidGUID(input) then
            objectBGUID = input
            print(string.format("Object B set to GUID: %s", input))
        end
    end
end

function isADecimal(string)
    local test = tonumber(string)
    return test ~= nil
end

function handleInputX(obj, color, input, stillEditing) 
    obj.editInput({
        index = 2,
        value = input
    })

    if not stillEditing then
        if isADecimal(input) then
            local tempX = tonumber(input)
            xInput = tempX
            print(string.format("X Offset set to %d", xInput))
        end
    end
end

function handleInputY(obj, color, input, stillEditing) 
    obj.editInput({
        index = 3,
        value = input
    })

    if not stillEditing then
        if isADecimal(input) then
            local tempY = tonumber(input)
            yInput = tempY
            print(string.format("Y Offset set to %d", yInput))
        end
    end
end

function handleInputZ(obj, color, input, stillEditing) 
    obj.editInput({
        index = 4,
        value = input
    })

    if not stillEditing then
        if isADecimal(input) then
            local tempZ = tonumber(input)
            zInput = tempZ
            print(string.format("Z Offset set to %d", zInput))
        end
    end
end

function hotkeySetObjectA(playercolor, object) 
    if isAValidGUID(object.getGUID()) then
        objectAGUID = object.getGUID()
        print(string.format("Object A set to GUID: %s", object.getGUID()))
    end
end

function hotkeySetObjectB(playercolor, object) 
    if isAValidGUID(object.getGUID()) then
        objectBGUID = object.getGUID()
        print(string.format("Object B set to GUID: %s", object.getGUID()))
    end
end

addHotkey("Set Object A", hotkeySetObjectA)
addHotkey("Set Object B", hotkeySetObjectB)