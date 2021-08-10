local constructor = require(script.Parent.constructor)

local Native = {
    Box = {},
    Cone = {},
    Cylinder = {},
    Line = {},
    Sphere = {},
}

function Native.Box.new(parent, props)
    props = props or {}
    props.Adornee = props.Adornee or parent

    return constructor("BoxHandleAdornment", parent, props)
end

function Native.Cone.new(parent, props)
    props = props or {}
    props.Adornee = props.Adornee or parent

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
    props = props or {}
    props.Adornee = props.Adornee or parent

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
    props = props or {}
    props.Adornee = props.Adornee or parent

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

function Native.Sphere.new(parent, props)
    props = props or {}
    props.Adornee = props.Adornee or parent

    return constructor("SphereHandleAdornment", parent, props)
end

return Native