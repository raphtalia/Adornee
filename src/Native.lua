local constructor = require(script.Parent.constructor)

local Native = {
    Box = {},
    Cone = {},
    Cylinder = {},
    Line = {},
    Sphere = {},
}

function Native.Box.new(...)
    return constructor("BoxHandleAdornment", ...)
end

function Native.Cone.new(parent, props)
    local startPoint = props.Start
    local endPoint = props.End
    if typeof(startPoint) == "Vector3" and typeof(endPoint) == "Vector3" then
        local length = (endPoint - startPoint).Magnitude
        props.CFrame = CFrame.lookAt(startPoint, endPoint) * CFrame.new(0, 0, -length / 2)
        props.Height = length
        props.Start = nil
        props.End = nil
    end

    return constructor("ConeHandleAdornment", parent, props)
end

function Native.Cylinder.new(parent, props)
    local startPoint = props.Start
    local endPoint = props.End
    if typeof(startPoint) == "Vector3" and typeof(endPoint) == "Vector3" then
        local length = (endPoint - startPoint).Magnitude
        props.CFrame = CFrame.lookAt(startPoint, endPoint) * CFrame.new(0, 0, -length / 2)
        props.Height = length
        props.Start = nil
        props.End = nil
    end

    return constructor("CylinderHandleAdornment", parent, props)
end

function Native.Line.new(parent, props)
    local startPoint = props.Start
    local endPoint = props.End
    if typeof(startPoint) == "Vector3" and typeof(endPoint) == "Vector3" then
        local length = (endPoint - startPoint).Magnitude
        props.CFrame = CFrame.lookAt(startPoint, endPoint) * CFrame.new(0, 0, -length / 2)
        props.Length = length
        props.Start = nil
        props.End = nil
    end

    return constructor("LineHandleAdornment", parent, props)
end

function Native.Sphere.new(...)
    return constructor("SphereHandleAdornment", ...)
end

return Native