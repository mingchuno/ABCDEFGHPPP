-- http://m2.hkgolden.com/view.aspx?message=6307521&type=SW&page=2
-- 阿拉瓜巴拉巴
unique :: Eq a => [a] -> [a] 

unique [] = []

unique (x:xs)

  | elem x xs = unique xs

  | otherwise = x:(unique xs) 



permutation :: [Int] -> Int -> [[Int]]

permutation xs 0 = [[]]

permutation xs n = concat(map (\x-> (map ( x: ) (permutation xs (n-1)))) xs) 



formNumber :: [Int] -> Int 

formNumber [x] = x 

formNumber (x:xs) = x*(10^(length xs)) + formNumber xs



evalEquation :: Int -> Int -> Int -> Int -> Int -> Int -> Int 

evalEquation a b c d g h = formNumber [a,b] - formNumber [c,d] + formNumber [g,h]



satisfyEquation :: Int -> Int -> Int -> Int -> Int -> Int -> Int -> Bool

satisfyEquation a b c d g h p 

  = evalEquation a b c d g h == formNumber [p,p,p] &&

    length (unique [a,b,c,d,e,f,g,h,p]) == 9

      where

        s = formNumber [a,b] - formNumber[c,d]

        e = s `div` 10

        f = s `mod` 10



possibilitiesForABCDGH :: [[Int]]

possibilitiesForABCDGH = permutation [1..9] 6)



findAnswer :: Int -> [[Int]]

findAnswer p = findAnswer' possibilitiesForABCDGH p

  where

    findAnswer' :: [[Int]] -> Int -> [[Int]]

    findAnswer' [] p = []

    findAnswer' (abcdgh@[a, b, c, d, g, h]:rest) p

      | satisfyEquation a b c d g h p = abcdgh:(findAnswer' rest p)

      | otherwise                     = findAnswer' rest p