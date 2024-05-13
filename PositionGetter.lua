local allPositions = {}
local rotationIsOn = false

function onLoad()

    self.createInput({
        input_function = "handleTableInput",
        function_owner = self,
        label = "Position Table Output Area",
        alignment = 3,
        position = {0, 0.1, 1},
        width = 1430,
        height = 500,
        font_size = 40,
        validation = 1,
        lineType = "MultiLineNewLine",
        tooltip = "This is where the code will output."
    })

self.createButton({
    click_function = "toggleRotation",
    function_owner = self,
    position = {-0.72, 0.1, 0.02},
    height = 310,
    width = 600,
    color = { 1, 1, 1, 0 },
    tooltip = "Toggles whether or not rotation values will be included in the table output"
    })

self.createButton({
    click_function = "printPositionTable",
    function_owner = self,
    position = {0.72, 0.1, 0.02},
    height = 310,
    width = 600,
    color = { 1, 1, 1, 0 },
    tooltip = "This will generate the code in the position table output area."
    })

self.createButton({
    click_function = "clearAll",
    function_owner = self,
    position = {0, 0.1, 1.8},
    height = 280,
    width = 590,
    color = { 1, 1, 1, 0 },
    tooltip = "Remove all previously saved positions."
    })

end

function clearAll()
    allPositions = {}
end

function printPositionAndRotationTable()
    local str = "{\n"
    for _, position in ipairs(allPositions) do
        str = str .. string.format("    { position = { x = %.2f, y = %.2f, z = %.2f }, rotation = { x = %.2f, y = %.2f, z = %.2f } },\n", 
                                    position.position.x, position.position.y, position.position.z,
                                    position.rotation.x, position.rotation.y, position.rotation.z)
    end
    str = str .. "}"
    self.editInput({index=0, value=str})
end

function printPositionTable()

    if rotationIsOn then 
        printPositionAndRotationTable() else

        local str = "{\n"
        for _, data in ipairs(allPositions) do
            str = str .. string.format("    { x = %.2f, y = %.2f, z = %.2f },\n", data.position.x, data.position.y, data.position.z)
        end
        str = str .. "}"
        self.editInput({index=0, value=str})
    end
end

function capturePositionOfObject(playercolor, object)

    local positionOfObject = object.getPosition() or print("Could not get the position of object")
    local rotationOfObject = object.getRotation() or print("Could not get the rotation of object")
    table.insert(allPositions, {position = positionOfObject, rotation = rotationOfObject})
    local guid = object.getGUID()
    print(string.format("Successfully captured position of object with GUID: %s", guid))
end

function capturePositionOfSelected(playercolor, object) 

    for _, obj in ipairs(Player[playercolor].getSelectedObjects()) do 
        local positionOfObject = obj.getPosition() or print("Could not get the position of object")
        local rotationOfObject = obj.getRotation() or print("Could not get the rotation of object")
        table.insert(allPositions, {position = positionOfObject, rotation = rotationOfObject})
        local guid = obj.getGUID()
        print(string.format("Successfully captured position of object with GUID: %s", guid))
    end
end

function handleTableInput() end

function toggleRotation()
    rotationIsOn = not rotationIsOn

    print(rotationIsOn and "Table will include rotation values" or "Table will not include rotation values")

end

addHotkey("Capture position/rotation of object", capturePositionOfObject)
addHotkey("Capture positions/rotation of all selected", capturePositionOfSelected)