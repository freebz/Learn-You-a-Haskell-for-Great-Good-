import Data.Monoid
import Control.Monad.Writer

newtype DiffList a = DiffList { getDiffList :: [a] -> [a] }

toDiffList :: [a] -> DiffList a
toDiffList xs = DiffList (xs++)

fromDiffList :: DiffList a -> [a]
fromDiffList (DiffList f) = f []

instance Monoid (DiffList a) where
    mempty = DiffList (\xs -> [] ++ xs)
    (DiffList f) `mappend` (DiffList g) = DiffList (\xs -> f (g xs))


finalCountDown :: Int -> Writer [String] ()
finalCountDown 0 = do
    tell ["0"]
finalCountDown x = do
    finalCountDown (x-1)
    tell [show x]

finalCountDownDiffList :: Int -> Writer (DiffList String) ()
finalCountDownDiffList 0 = do
    tell (toDiffList ["0"])
finalCountDownDiffList x = do
    finalCountDownDiffList (x-1)
    tell (toDiffList [show x])
