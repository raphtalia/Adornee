--[[
    NOTE: Height refers to only the height of the cylinder. To get the true
    height of the arrow use Height + ConeHeight.
]]

local constructor = require(script.Parent.Parent.constructor)

local Arrow = {}
function Arrow:__index(i)
    local container = rawget(self, "_container")
    local props = rawget(self, "_props")

    if i == "Parent" then
        return container.Parent
    else
        return Arrow[i] or props[i]
    end
end
function Arrow:__newindex(i, v)
    local container = rawget(self, "_container")
    local cylinder = rawget(self, "_cylinder")
    local cone = rawget(self, "_cone")
    local props = rawget(self, "_props")

    if i == "Parent" then
        container.Parent = v
    elseif i == "CFrame" then
        -- Returns the start of the arrow not the center of the arrow
        cylinder.CFrame = v * CFrame.new(0, 0, -cylinder.Height/2)
        cone.CFrame = v * CFrame.new(0, 0, -cylinder.Height)
        props.CFrame = v
    elseif i == "Adornee" then
        cylinder.Adornee = v
        cone.Adornee = v
        props.Adornee = v
    elseif i == "AlwaysOnTop" then
        cylinder.AlwaysOnTop = v
        cone.AlwaysOnTop = v
    elseif i == "Radius" then
        cone.Radius = v
        props.Radius = v
    elseif i == "InnerRadius" then
        cylinder.Radius = v
        props.InnerRadius = v
    elseif i == "Height" then
        local cf = self.CFrame
        cylinder.Height = cone.Height
        self.CFrame = cf
        props.Height = v
    elseif i == "ConeHeight" then
        cone.Height = v
        props.ConeHeight = v
    elseif i == "Visible" then
        cylinder.Visible = v
        cone.Visible = v
        props.Visible = v
    elseif i == "Color3" then
        cylinder.Color3 = v
        cone.Color3 = v
        props.Color3 = v
    elseif i == "Transparency" then
        cylinder.Transparency = v
        cone.Transparency = v
        props.Transparency = v
    end
end

function Arrow.new(parent, props)
    props.CFrame = props.CFrame or CFrame.new()
    props.Adornee = props.Adornee or parent
    props.Radius = props.Radius or 0.2
    props.InnerRadius = props.InnerRadius or 0.1
    props.Height = props.Height or 4
    props.ConeHeight = props.ConeHeight or 1
    props.Visible = props.Visible or true
    props.Color3 = props.Color3 or Color3.new(0, 0, 1)
    props.Transparency = props.Transparency or 0

    local arrow = {}

    local container = Instance.new("Folder")
    container.Name = "ArrowHandleAdornment"

    local cylinder = constructor(
        "CylinderHandleAdornment",
        container,
        {
            CFrame = props.CFrame * CFrame.new(0, 0, -props.Height/2),
            Adornee = props.Adornee,
            AlwaysOnTop = props.AlwaysOnTop,
            Radius = props.InnerRadius,
            Height = props.Height,
            Visible = props.Visible,
            Color3 = props.Color3,
            Transparency = props.Transparency
        }
    )

    local cone = constructor(
        "ConeHandleAdornment",
        container,
        {
            CFrame = props.CFrame * CFrame.new(0, 0, -cylinder.Height),
            Adornee = props.Adornee,
            AlwaysOnTop = props.AlwaysOnTop,
            Radius = props.Radius,
            Height = props.ConeHeight,
            Visible = props.Visible,
            Color3 = props.Color3,
            Transparency = props.Transparency
        }
    )

    container.Parent = parent

    arrow._container = container
    arrow._cylinder = cylinder
    arrow._cone = cone
    arrow._props = props

    return setmetatable(arrow, Arrow)
end

function Arrow:Destroy()
    self._container.Destroy()
end

return Arrow