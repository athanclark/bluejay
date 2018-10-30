{-# LANGUAGE
    GeneralizedNewtypeDeriving
  , DeriveGeneric
  , OverloadedStrings
  #-}

module Web.Dependencies.BlueJay.Types where

import Data.Text (Text, intercalate, unpack)
import Data.Hashable (Hashable)
import Data.Aeson (ToJSON (..), FromJSON (..), Value (String))
import Data.Aeson.Attoparsec (attoAeson)
import Data.Attoparsec.Text (Parser, char, sepBy, takeWhile1)
import Control.DeepSeq (NFData)
import GHC.Generics (Generic)



type Server m input output = input -> m (Maybe output)


type Client m input output = (input -> m (Maybe output)) -> m ()



newtype Topic = Topic
  { getTopic :: [Text]
  } deriving (Eq, Ord, Generic, Hashable, NFData)


instance Show Topic where
  show (Topic x) = unpack (intercalate "/" x)

instance FromJSON Topic where
  parseJSON = attoAeson (Topic <$> breaker)
    where
      breaker :: Parser [Text]
      breaker = takeWhile1 (/= '/') `sepBy` char '/'

instance ToJSON Topic where
  toJSON (Topic xs) = String (intercalate "/" xs)


