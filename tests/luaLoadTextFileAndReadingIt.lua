-- Open the file in read mode
local file = io.open("example.txt", "r")

-- Check if the file was successfully opened
if file then
    -- Read the entire contents of the file
    local contents = file:read("*all")
    
    -- Print the contents to the console
    print(contents)
    
    -- Close the file
    file:close()
else
    print("Could not open the file.")
end
