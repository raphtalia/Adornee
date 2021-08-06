local constructor = require(script.Parent.Parent.constructor)

local Path = {}
function Path:__index(i)
    local container = rawget(self, "_container")
    local props = rawget(self, "_props")

    if i == "Parent" then
        return container.Parent
    elseif i == "Points" then
        return {unpack(props.Points)}
    else
        return Path[i] or props[i]
    end
end
function Path:__newindex(i, v)
    local container = rawget(self, "_container")
    local props = rawget(self, "_props")

    if i == "Parent" then
        container.Parent = v
    elseif i == "Adornee" then
        for _,adronment in ipairs(container.Adornees:GetChildren()) do
            adronment.Adornee = v
        end
        props[i] = v
    elseif i == "AlwaysOnTop" then
        for _,adronment in ipairs(container.Adornees:GetChildren()) do
            adronment.AlwaysOnTop = v
        end
        props[i] = v
    elseif i == "Radius" then
        for _,adronment in ipairs(container.Adornees:GetChildren()) do
            if adronment:IsA("CylinderHandleAdornment") then
                adronment.Radius = v
            end
        end
        props[i] = v
    elseif i == "PointRadius" then
        for _,adronment in ipairs(container.Adornees:GetChildren()) do
            if adronment:IsA("SphereHandleAdornment") then
                adronment.Radius = v
            end
        end
    elseif i == "Visible" then
        for _,adronment in ipairs(container.Adornees:GetChildren()) do
            adronment.Visible = v
        end
        props[i] = v
    elseif i == "Color3" then
        for _,adronment in ipairs(container.Adornees:GetChildren()) do
            adronment.Color3 = v
        end
    elseif i == "PointColor3" then
        for _,adronment in ipairs(container.Adornees:GetChildren()) do
            if adronment:IsA("SphereHandleAdornment") then
                adronment.Color3 = v
            end
        end
    elseif i == "Transparency" then
        for _,adronment in ipairs(container.Adornees:GetChildren()) do
            adronment.Transparency = v
        end
        props[i] = v
    elseif i == "Points" then
        props[i] = v
        self:_render()
    end
end

function Path.new(parent, props)
    props.Points = props.Points or {}
    props.Adornee = props.Adornee or parent
    props.Radius = props.Radius or 0.1
    props.PointRadius = props.PointRadius or props.Radius
    props.Visible = props.Visible or true
    props.Color3 = props.Color3 or Color3.new(0, 0, 1)
    props.PointColor3 = props.PointColor3 or props.Color3
    props.Transparency = props.Transparency or 0

    local path = {}

    local container = Instance.new("Folder")
    container.Name = "PathHandleAdornment"

    path._container = container
    path._props = props

    Path._render(path)

    container.Parent = parent

    return setmetatable(path, Path)
end

function Path:Destroy()
    self._container:Destroy()
end

function Path:_render()
    local container = self._container
    local props = self._props

    container:ClearAllChildren()

    for _,point in ipairs(props.Points) do
        constructor(
            "SphereHandleAdornment",
            container,
            {
                CFrame = CFrame.new(point),
                Adornee = props.Adornee,
                AlwaysOnTop = props.AlwaysOnTop,
                Radius = props.PointRadius,
                Visible = props.Visible,
                Color3 = props.PointColor3,
                Transparency = props.Transparency
            }
        )
    end

    for i = 2, #props.Points do
        local startPoint = props.Points[i]
        local endPoint = props.Points[i - 1]

        local height = (endPoint - startPoint).Magnitude

        constructor(
            "CylinderHandleAdornment",
            container,
            {
                CFrame = CFrame.lookAt(startPoint, endPoint) * CFrame.new(0, 0, -height/2),
                Adornee = props.Adornee,
                AlwaysOnTop = props.AlwaysOnTop,
                Radius = props.Radius,
                Height = height,
                Visible = props.Visible,
                Color3 = props.Color3,
                Transparency = props.Transparency
            }
        )
    end
end

return Path