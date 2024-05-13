local bagAGUID = nil
local bagBGUID = nil

function onLoad() 

    self.createButton({
        click_function = "moveObjects",
        function_owner = self,
        position = {0, 0.1, 1.2},
        height = 330,
        width = 1200,
        color = {1, 1, 1, 0}
        })

    self.createInput({
        input_function = "handleBagAInput",
        function_owner = self,
        label = "GUID of Bag A",
        alignment = 3,
        position = {0.5, 0.1, -0.98},
        width = 800,
        height = 140,
        font_size = 100,
        validation = 4,
    })

    self.createInput({
        input_function = "handleBagBInput",
        function_owner = self,
        label = "GUID of Bag B",
        alignment = 3,
        position = {0.5, 0.1, 0.07},
        width = 800,
        height = 140,
        font_size = 100,
        validation = 4,
    })
end

function moveObjects() 

    if isAValidGUID(bagAGUID) and isAValidGUID(bagBGUID) then

        local bagA = getObjectFromGUID(bagAGUID)
        local bagB = getObjectFromGUID(bagBGUID)

        local count = 0

        while bagA.getQuantity() > 0 do
            local obj = bagA.takeObject()
            bagB.putObject(obj)
            count = count + 1
        end
        
        print(string.format("Successfully transferred %d objects", count))

    end
end

function handleBagAInput(obj, color, input, stillEditing) 
    obj.editInput({
        index = 0,
        value = input
    })

    if not stillEditing then
        if isAValidGUID(input) then
            bagAGUID = input
            print(string.format("Bag A set to GUID: %s", input))
        end
    end
end

function handleBagBInput(obj, color, input, stillEditing) 

    obj.editInput({
        index = 1,
        value = input
    })

    if not stillEditing then
        if isAValidGUID(input) then
            bagBGUID = input
            print(string.format("Bag B set to GUID: %s", input))
        end
    end
end

function isAValidGUID(string)
    return getObjectFromGUID(string) ~= nil
end