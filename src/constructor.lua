local function errorInvalidType(argNum, expectedType, receivedType)
    error(("invalid argument #%d (%s expected, got %s)"):format(argNum, expectedType, receivedType), 3)
end

return function(className, parent, props)
    if type(className) ~= "string" then
        errorInvalidType(1, "string", typeof(className))
    end
    if typeof(parent) ~= "Instance" then
        errorInvalidType(2, "Instance", typeof(parent))
    end
    if type(props) ~= "table" then
        errorInvalidType(3, "table", typeof(props))
    end

    local instance = Instance.new(className)
    for i,v in pairs(props) do
        instance[i] = v
    end
    instance.Parent = parent

    return instance
end