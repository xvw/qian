module Model
    exposing
        ( Model
        , Configuration
        , Flags
        , init
        )

{-| Describe the model and this relation
-}

import Message exposing (Message(..))
import Zipper.History as History exposing (History)


{-| Describe the model of the Application
-}
type alias Model =
    { config : Configuration
    , history : History String
    }


{-| Describe the configuration of the Application
-}
type alias Configuration =
    { terminal : String }


{-| Describe the input from JavaScript
-}
type alias Flags =
    { current : String
    , config : Configuration
    , home : String
    , root : String
    }


{-| Initialize the model using JavaScript's input
-}
init : Flags -> ( Model, Cmd Message )
init flags =
    ( { config = flags.config
      , history = History.new flags.current
      }
    , Cmd.none
    )
