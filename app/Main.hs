module Main where
import Data.List
import Data.Maybe
import System.IO

main :: IO ()
main = do
  putStr "\nTemperatura (°F)  = "
  hFlush stdout
  t <- getLine
  putStr "Pressao (psi)     = "
  hFlush stdout
  p <- getLine
  putStr "CO2/volume        = "
  hFlush stdout
  let t' = read t :: Int
  let p' = read p :: Int
  -- (Temperatura, CO2/vol, Range de pressões)
  let xs = [ (30,    [1.82, 1.92, 2.03, 2.14, 2.23, 2.36, 2.48, 2.60, 2.70, 2.82, 2.93, 3.02],                                        [1..12]),
             (31,    [1.78, 1.88, 2.00, 2.10, 2.20, 2.31, 2.42, 2.54, 2.65, 2.76, 2.86, 2.96],                                        [1..12]),
             (32,    [1.75, 1.85, 1.95, 2.05, 2.16, 2.27, 2.38, 2.48, 2.59, 2.70, 2.80, 2.90, 3.01],                                  [1..13]),
             (33,    [1.81, 1.91, 2.01, 2.12, 2.23, 2.33, 2.43, 2.53, 2.63, 2.74, 2.84, 2.96],                                        [2..13]),
             (34,    [1.78, 1.86, 1.97, 2.07, 2.18, 2.28, 2.38, 2.48, 2.58, 2.79, 2.89, 3.00],                                        [2..14]),
             (35,    [1.83, 1.93, 2.03, 2.14, 2.24, 2.34, 2.43, 2.52, 2.62, 2.73, 2.83, 2.93, 3.02],                                  [3..15]),
             (36,    [1.79, 1.88, 1.99, 2.09, 2.20, 2.29, 2.39, 2.47, 2.57, 2.67, 2.77, 2.86, 2.96],                                  [3..15]),
             (37,    [1.84, 1.94, 2.04, 2.15, 2.24, 2.34, 2.42, 2.52, 2.62, 2.72, 2.80, 2.90, 3.00],                                  [4..16]),
             (38,    [1.80, 1.90, 2.00, 2.10, 2.20, 2.29, 2.38, 2.47, 2.57, 2.67, 2.75, 2.85, 2.94],                                  [4..16]),
             (39,    [1.86, 1.96, 2.05, 2.15, 2.25, 2.34, 2.43, 2.52, 2.61, 2.70, 2.80, 2.89, 2.98],                                  [5..17]),
             (40,    [1.82, 1.92, 2.01, 2.10, 2.20, 2.30, 2.39, 2.47, 2.56, 2.65, 2.75, 2.84, 2.93, 3.01],                            [5..18]),
             (41,    [1.87, 1.97, 2.06, 2.16, 2.25, 2.35, 2.43, 2.52, 2.60, 2.70, 2.79, 2.87, 2.96],                                  [6..18]),
             (42,    [1.83, 1.93, 2.02, 2.12, 2.21, 2.30, 2.39, 2.47, 2.56, 2.65, 2.74, 2.82, 2.91, 3.00],                            [6..19]),
             (43,    [1.80, 1.90, 1.99, 2.08, 2.17, 2.25, 2.34, 2.43, 2.52, 2.60, 2.69, 2.78, 2.86, 2.95],                            [6..19]),
             (44,    [1.86, 1.95, 2.04, 2.13, 2.21, 2.30, 2.39, 2.47, 2.56, 2.64, 2.73, 2.81, 2.90, 2.99],                            [7..20]),
             (45,    [1.82, 1.91, 2.00, 2.08, 2.17, 2.25, 2.34, 2.42, 2.51, 2.60, 2.68, 2.77, 2.85, 2.94, 3.02],                      [7..21]),
             (46,    [1.88, 1.96, 2.04, 2.13, 2.22, 2.36, 2.38, 2.47, 2.55, 2.63, 2.72, 2.80, 2.89, 2.98],                            [8..21]),
             (47,    [1.84, 1.92, 2.00, 2.09, 2.18, 2.25, 2.34, 2.42, 2.50, 2.59, 2.67, 2.75, 2.84, 2.93, 3.02],                      [8..22]),
             (48,    [1.80, 1.88, 1.96, 2.05, 2.14, 2.21, 2.30, 2.38, 2.46, 2.55, 2.62, 2.70, 2.79, 2.87, 2.96],                      [8..22]),
             (49,    [1.85, 1.93, 2.01, 2.10, 2.18, 2.25, 2.34, 2.42, 2.50, 2.66, 2.75, 2.83, 2.91, 2.99],                            [9..23]),
             (50,    [1.82, 1.90, 1.98, 2.06, 2.14, 2.21, 2.30, 2.38, 2.45, 2.54, 2.62, 2.70, 2.78, 2.86, 2.94, 3.02],                [9..24]),
             (51,    [1.87, 1.95, 2.02, 2.10, 2.18, 2.25, 2.34, 2.41, 2.49, 2.57, 2.65, 2.73, 2.81, 2.89, 2.97],                      [10..24]),
             (52,    [1.84, 1.91, 1.99, 2.06, 2.14, 2.22, 2.30, 2.37, 2.45, 2.52, 2.61, 2.69, 2.76, 2.84, 2.93, 3.00],                [10..25]),
             (53,    [1.80, 1.88, 1.96, 2.03, 2.10, 2.18, 2.26, 2.33, 2.41, 2.48, 2.57, 2.64, 2.72, 2.80, 2.88, 2.95],                [10..25]),
             (54,    [1.85, 1.93, 2.00, 2.07, 2.15, 2.22, 2.29, 2.37, 2.44, 2.52, 2.60, 2.67, 2.75, 2.83, 2.90, 2.98],                [11..26]),
             (55,    [1.82, 1.89, 1.97, 2.04, 2.11, 2.19, 2.25, 2.33, 2.40, 2.47, 2.55, 2.63, 2.70, 2.78, 2.85, 2.93, 3.01],          [11..27]),
             (56,    [1.86, 1.93, 2.00, 2.07, 2.15, 2.21, 2.29, 2.36, 2.43, 2.50, 2.58, 2.65, 2.73, 2.80, 2.88, 2.96],                [12..27]),
             (57,    [1.83, 1.90, 1.97, 2.04, 2.11, 2.18, 2.25, 2.33, 2.46, 2.47, 2.54, 2.61, 2.69, 2.76, 2.84, 2.91, 2.99],          [12..28]),
             (58,    [1.80, 1.86, 1.94, 2.00, 2.07, 2.14, 2.21, 2.25, 2.36, 2.43, 2.50, 2.57, 2.64, 2.72, 2.80, 2.86, 2.94, 3.01],    [12..28]),
             (59,    [1.83, 1.90, 1.97, 2.04, 2.11, 2.18, 2.25, 2.32, 2.39, 2.46, 2.53, 2.60, 2.67, 2.75, 2.81, 2.89, 2.96],          [13..29]),
             (60,    [1.80, 1.87, 1.94, 2.01, 2.08, 2.14, 2.21, 2.28, 2.35, 2.42, 2.49, 2.56, 2.63, 2.70, 2.77, 2.84, 2.91, 2.98],    [13..30]) ]
  let triple = extract t' xs
  print $ co2 (t', snd3 triple, trd3 triple) p'
  main

findEl :: Int -> [Int] -> Int
findEl p xs = fromJust $ elemIndex p xs

fst3 :: (a,b,c) -> a
fst3 (x,_,_) = x

snd3 :: (a,b,c) -> b
snd3 (_,x,_) = x

trd3 :: (a,b,c) -> c
trd3 (_,_,x) = x

extract :: (Eq a) => a -> [(a,b,c)] -> (a,b,c)
extract t xs
  | t == fst3 (head xs) = head xs
  | otherwise           = extract t $ tail xs

co2 :: (Int, [Float], [Int]) -> Int -> Float
co2 (t, xs, ps) p
  | t > 29 && t < 61 = xs !! (findEl p ps)
  | otherwise        = -1.0
