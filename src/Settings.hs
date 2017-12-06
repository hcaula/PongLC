module Settings where
import Graphics.Rendering.OpenGL (GLdouble)

-- Screen resolution in pixels
width = 800 :: Int
height = 600 :: Int

-- Screen resolution converted to double
w = fromIntegral width :: GLdouble
h = fromIntegral height :: GLdouble

-- Bars sprites measures
bar :: [(Double, Double)]
bar = [(-barWidth, -barHeight), (barWidth, -barHeight),(barWidth, barHeight),(-barWidth, barHeight)]

-- Ball sprite measures
ball :: [(Double, Double)]
ball = [(-ballSize, -ballSize), (ballSize, -ballSize), (ballSize, ballSize), (-ballSize, ballSize)]

-- Width of the bar: 2.5% of screen width
barWidth = w/50

-- Height of the bar: 12.5% of screen height
barHeight = h/8

-- Offset (distance between bar and screen horizontal border)
offset = barWidth*2

-- Ball size
ballSize = barWidth;

-- Bar speed
barSpeed = 10 :: GLdouble
