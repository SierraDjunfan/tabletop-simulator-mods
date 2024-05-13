local bagGUID = nil
local newTag = ""

function onLoad() 

    self.createButton({
        click_function = "tagObjects",
        function_owner = self,
        position = {0, 0.1, 1.2},
        height = 330,
        width = 1200,
        color = {1, 1, 1, 0}
        })

    self.createInput({
        input_function = "handleGUIDInput",
        function_owner = self,
        label = "GUID of Bag",
        alignment = 3,
        position = {0.5, 0.1, -0.98},
        width = 800,
        height = 140,
        font_size = 100,
        validation = 4,
    })

    self.createInput({
        input_function = "handleTagInput",
        function_owner = self,
        label = "Tag",
        alignment = 3,
        position = {0.5, 0.1, 0.07},
        width = 800,
        height = 140,
        font_size = 100,
        validation = 4,
    })
end

function tagObjects() 
    if isAValidGUID(bagGUID) and newTag ~= "" then

        local bag = getObjectFromGUID(bagGUID)

        local objectsToPutBackInBag = {}

        while bag.getQuantity() > 0 do
            local toTake = bag.takeObject()
            toTake.addTag(newTag)
            table.insert(objectsToPutBackInBag, toTake)
        end

        for _, tile in ipairs(objectsToPutBackInBag) do
            bag.putObject(tile)
        end
    end
end

function handleGUIDInput(obj, color, input, stillEditing) 
    obj.editInput({
        index = 0,
        value = input
    })

    if not stillEditing then
        if isAValidGUID(input) then
            bagGUID = input
            print(string.format("Bag GUID set to GUID: %s", input))
        end
    end
end

function handleTagInput(obj, color, input, stillEditing) 

    obj.editInput({
        index = 1,
        value = input
    })

    if not stillEditing then
        if input ~= "" then
            newTag = input
            print(string.format("Tag set to Tag: %s", input))
        end
    end
end

function isAValidGUID(string)
    return getObjectFromGUID(string) ~= nil
end