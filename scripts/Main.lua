--[[----------------------------------------------------------------------------

  Application Name:
  BlobFeatureTypes3D

  Description:
  Extracting and visualizing common blobs features on a height map.

  How to Run:
  Starting this sample is possible either by running the app (F5) or
  debugging (F7+F10). Setting a breakpoint on the first row inside the 'main'
  function allows debugging step-by-step after the 'Engine.OnStarted' event.
  Results can be seen in the image viewer on the DevicePage, either with a 3D
  visualization or a 2D visualization.
  Restarting the Sample may be necessary to show images after loading the webpage.
  To run this sample a device with AppEngine >= V2.5.0 and the relevant algorithms
  is necessary. For example TriSpectorP with latest firmware. Alternatively the
  Emulator on AppStudio 2.3 or higher can be used.

  More Information:
  Tutorial "Algorithms - Blob Analysis".

------------------------------------------------------------------------------]]

-- Loading helper decorations and functions, see Helpers.lua
local helpers = require('Helpers')

-- Loading featureType functions, see BlobFeatureTypes3D.lua
local Blob3D = require('BlobFeatureTypes3D')

--Start of Global Scope---------------------------------------------------------
print('AppEngine Version: ' .. Engine.getVersion())

local DELAY = 500 -- ms between each type for demonstration purpose

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

-- Looping through the functions
function RotinaImagem()
  -- Carrega número da imagem a utilizar
  local NumIMG = Parameters.get("NumIMG")
  -- Load image from resources
  local images = Object.load("resources/imagem3D_"..NumIMG..".json")
  local heightMap = images[1]
  local intensityMap = images[2]

  local plane = helpers.getReferencePlane(heightMap, nil)

  -- Blob inspections---------------------------
  -- print('Imagem número: ' .. NumIMG)
  -- Script.sleep(DELAY) -- for demonstration purpose only
  -- print('==== ÁREA ====')
  -- Blob3D.area(heightMap, intensityMap, plane)
  -- Script.sleep(DELAY) -- for demonstration purpose only
  -- print('==== Centroid ====')
  -- Blob3D.centroid(heightMap, intensityMap, plane)
  -- Script.sleep(DELAY) -- for demonstration purpose only
  -- print('==== Elongation ====')
  -- Blob3D.elongation(heightMap, intensityMap, plane)
  -- Script.sleep(DELAY) -- for demonstration purpose only
  -- print('==== Convexity ====')
  -- Blob3D.convexity(heightMap, intensityMap, plane)
  -- Script.sleep(DELAY) -- for demonstration purpose only
  -- print('==== Compactness ====')
  -- Blob3D.compactness(heightMap, intensityMap, plane)
  -- Script.sleep(DELAY) -- for demonstration purpose only
  -- print('==== Perimeter ====')
  -- Blob3D.perimeterLength(heightMap, intensityMap, plane)
  -- Script.sleep(DELAY) -- for demonstration purpose only
  -- print('==== Count Holes ====')
  -- Blob3D.countHoles(heightMap, intensityMap, plane)
  -- Script.sleep(DELAY) -- for demonstration purpose only
  -- print('==== Orientation ====')
  -- Blob3D.orientation(heightMap, intensityMap, plane)
  -- Script.sleep(DELAY) -- for demonstration purpose only



  local scanLength = 4 -- Scan length constant
  local imgWidth, imgHeight = Image.getSize(heightMap)
  local targetVolume = 100000
  
  --Verify if scanLength will scan the entire image
  while Blob3D.verifyScanLength(imgWidth, scanLength) == false do
    scanLength = scanLength - 1
  end

  local target = Blob3D.slicerCoord(targetVolume, heightMap, intensityMap, plane, scanLength)
  print(target)
  Parameters.set("Target", target)

  Parameters.set("Volume", volume)
  
  print('App finished.')
end
-- Registra função de inicio da rotina
Script.serveFunction("Slicer_v0.StartButton", "RotinaImagem")