local NativeAdornees = require(script.Native)
local CustomAdornees = script.Custom

return {
    Box = NativeAdornees.Box,
    Cone = NativeAdornees.Cone,
    Cylinder = NativeAdornees.Cylinder,
    Line = NativeAdornees.Line,
    Sphere = NativeAdornees.Sphere,

    Arrow = require(CustomAdornees.Arrow),
    Path = require(CustomAdornees.Path),
}