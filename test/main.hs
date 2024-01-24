import System.Environment
import GHC.Real

-- constants
c = 29979245.0 -- speed of light in m/s
g = 6.67408e-11 -- gravitational constant in m^3 kg^-1 s^-2
sol = 1.98855e30 -- solar mass in kg

radius:: Float -> Float
radius a = g * a * sol / c^2

main :: IO ()
main = do
    args <- getArgs
    case args of
        [input] -> do
            let a = read input :: Int
            let r = radius $ fromIntegral a
            -- divide by 1000 to get km
            putStrLn $  show (r / 1000)
        _ -> putStrLn "Please provide a single integer argument."
