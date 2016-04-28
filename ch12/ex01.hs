import Data.Monoid
import qualified Data.Foldable as F

data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show)

--foldMap :: (Monoid m, Foldable t) => (a -> m) -> t a -> m

instance F.Foldable Tree where
    foldMap f EmptyTree = mempty
    foldMap f (Node x l r) = F.foldMap f l `mappend`
                             f x `mappend`
                             F.foldMap f r

testTree = Node 5
                (Node 3
                      (Node 1 EmptyTree EmptyTree)
                      (Node 6 EmptyTree EmptyTree)
                )
                (Node 9
                      (Node 8 EmptyTree EmptyTree)
                      (Node 10 EmptyTree EmptyTree)
                )
                