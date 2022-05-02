local viewer3D = View.create()
viewer3D:setID('viewer3D')

local viewer2D = View.create()
viewer2D:setID('viewer2D')

-- Create decoration objects
local imgDecoration = View.ImageDecoration.create()
imgDecoration:setRange(190, 250)

local decRectangles = View.PixelRegionDecoration.create()
View.PixelRegionDecoration.setColor(decRectangles, 250, 0, 0, 150) -- RGBA values

local regionDecoration = View.PixelRegionDecoration.create()
regionDecoration:setColor(0, 255, 0, 150) -- Green with transparency

local borderDecoration = View.PixelRegionDecoration.create()
borderDecoration:setColor(255, 0, 0) -- Red

local lineDecoration2D = View.ShapeDecoration.create()
lineDecoration2D:setLineColor(230, 0, 0)
lineDecoration2D:setLineWidth(0.2) -- Green

local lineDecoration3D = View.ShapeDecoration.create()
lineDecoration3D:setLineColor(230, 0, 0)
lineDecoration3D:setLineWidth(3) -- Green

local pointDecoration2D = View.ShapeDecoration.create()
pointDecoration2D:setLineColor(0, 230, 0) -- Green
pointDecoration2D:setPointSize(3)
pointDecoration2D:setPointType('DOT')

local pointDecoration3D = View.ShapeDecoration.create()
pointDecoration3D:setLineColor(0, 230, 0) -- Green
pointDecoration3D:setPointSize(10)
pointDecoration3D:setPointType('DOT')

local planeDeco = View.ShapeDecoration.create()
planeDeco:setLineColor(0, 0, 240)
planeDeco:setFillColor(0, 0, 240, 10)
planeDeco:setLineWidth(2)

-- Help function to print feature values for each blob
local function featureText(x, y, z, strg, parent3D, parent2D)
  local textDeco = View.TextDecoration.create()
  textDeco:setColor(0, 0, 240)
  textDeco:setSize(4)
  textDeco:setPosition(x, y, z)

  viewer3D:addText(strg, textDeco, nil, parent3D)
  viewer2D:addText(strg, textDeco, nil, parent2D)
  print(strg)
end

-- Help function to find a reference plane
--@getReferencePlane(heightMap:Image, region:Image.PixelRegion):Shape3D
local function getReferencePlane(heightMap, region)
  -- Fit a plane inside the region to get a reference height
  local surfaceFitter = Image.SurfaceFitter.create()
  surfaceFitter:setFitMode('RANSAC')
  surfaceFitter:setIterations(50)
  surfaceFitter:setReductionFactor(5)

  -- Fit a rectangle for easier visualization in the GUI
  local plane
  if region == nil then -- Use entire image
    plane = surfaceFitter:fitRectangle(heightMap)
  else -- Only fit inside a specific region
    plane = surfaceFitter:fitRectangle(heightMap, region)
  end

  -- Convert the rectangle to a full plane
  plane = plane:toPlane()
  return plane
end

-- Help function to round a value
local function round(num, numDecimalPlaces)
  return tonumber(string.format('%.' .. (numDecimalPlaces or 0) .. 'f', num))
end

local helper = {}
helper.viewer3D = viewer3D
helper.viewer2D = viewer2D
helper.imgDecoration = imgDecoration
helper.decRectangles = decRectangles
helper.regionDecoration = regionDecoration
helper.borderDecoration = borderDecoration
helper.lineDecoration2D = lineDecoration2D
helper.lineDecoration3D = lineDecoration3D
helper.pointDecoration2D = pointDecoration2D
helper.pointDecoration3D = pointDecoration3D
helper.planeDeco = planeDeco
helper.featureText = featureText
helper.getReferencePlane = getReferencePlane
helper.findSlopeRegion = findSlopeRegion
helper.round = round
return helper
