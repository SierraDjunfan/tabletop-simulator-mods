local bagGUID = nil

function onLoad() 

    self.createButton({
        click_function = "removeObjectsFromBag",
        function_owner = self,
        position = {0, 0.1, 1.2},
        height = 330,
        width = 1200,
        color = {1, 1, 1, 0}
        })

    self.createInput({
        input_function = "handleBagGUIDInput",
        function_owner = self,
        label = "GUID of Bag",
        alignment = 3,
        position = {0.5, 0.1, -0.98},
        width = 800,
        height = 140,
        font_size = 100,
        validation = 4,
    })

end

function removeObjectsFromBag()
    if isAValidGUID(bagGUID) then
        local bag = getObjectFromGUID(bagGUID)
        if bag then
            local count = 0
            local pos = self.getPosition()
            local offset = 2 -- Set the distance each object will be spaced out by
            local angle = 0

            while bag.getQuantity() > 0 do
                local newPos = {
                    x = pos.x + offset * math.cos(math.rad(angle)),
                    y = pos.y,
                    z = pos.z + offset * math.sin(math.rad(angle))
                }

                local obj = bag.takeObject({
                    position = newPos
                })

                count = count + 1
                angle = angle + 45
            end

            print(string.format("Successfully removed %d objects from bag", count))
        else
            print("Could not find a bag with that GUID")
        end
    else
        print("Invalid GUID")
    end
end

function handleBagGUIDInput(obj, color, input, stillEditing) 
    obj.editInput({
        index = 0,
        value = input
    })

    if not stillEditing then
        if isAValidGUID(input) then
            bagGUID = input
            print(string.format("Bag set to GUID: %s", input))
        end
    end
end

function isAValidGUID(string)
    return getObjectFromGUID(string) ~= nil
end