module Main where

import Prelude

import Data.Maybe (Maybe)
import Effect (Effect)
import Effect.Class.Console (log)
import Foreign (Foreign)
import Simple.JSON as JSON

myRecordJSON :: String
myRecordJSON = """
  {
    "number": 123,
    "string": "hello"
  }
"""

-- works as expected, we can automatically decode this!
result1 :: JSON.E { number :: Number }
result1 = JSON.readJSON myRecordJSON

-- we read into the wrong type, so we'll see an error in the output.
result2 :: JSON.E { number :: String }
result2 = JSON.readJSON myRecordJSON

-- this also works, where we can mark fields as optional because of the encoding of Maybe in Simple-JSON
result3 :: JSON.E { number :: Number, string :: Maybe String }
result3 = JSON.readJSON myRecordJSON

-- we can also get foreign JS values and decode them.
foreign import myRecordForeign :: Foreign

result4 :: JSON.E { number :: Number, string :: String }
result4 = JSON.read myRecordForeign
  
main :: Effect Unit
main = do
  log $ show result1
  log $ show result2
  log $ show result3
  log $ show result4