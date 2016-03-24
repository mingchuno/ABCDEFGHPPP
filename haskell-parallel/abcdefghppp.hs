--by phiSgr

import Data.List
import Text.Printf

import Control.Parallel.Strategies

pss :: [[[Int]]]
pss = map permutations $ map (\i -> filter (/= i) [0..9]) [0..9]

sat :: [Int] -> Bool
sat [a,b,c,d,e,f,g,h,p] =
  a /= 0 && c /= 0 && e /= 0 && g /= 0 && p /= 0 &&
  (10 * a + b) - (10 * c + d) == (10 * e + f) &&
  (10 * e + f) + (10 * g + h) == 111 * p
sat _ = error "wrong length"

toEquationIO :: [Int] -> IO ()
toEquationIO [a,b,c,d,e,f,g,h,p] = do
  printf "%d%d - %d%d = %d%d, " a b c d e f
  printf "%d%d + %d%d = %d%d%d\n" e f g h p p p
toEquationIO _ = error "wrong length"

main =
  let solutionss = map (filter sat) pss
      pSolutionss = solutionss `using` parList rdeepseq in
    sequence $ map toEquationIO $ concat $ pSolutionss
