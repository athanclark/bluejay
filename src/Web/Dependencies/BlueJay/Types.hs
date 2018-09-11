{-# LANGUAGE
    GeneralizedNewtypeDeriving
  , DeriveGeneric
  #-}

module Web.Dependencies.BlueJay.Types where

import Data.Text (Text)
import Data.Hashable (Hashable)
import Control.DeepSeq (NFData)
import GHC.Generics (Generic)



type Server m input output = input -> m (Maybe output)


type Client m input output = (input -> m (Maybe output)) -> m ()



newtype Topic = Topic
  { getTopic :: [Text]
  } deriving (Eq, Ord, Generic, Hashable, NFData)
