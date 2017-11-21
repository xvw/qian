module Model
    exposing
        ( Model
        , Configuration
        , Flags
        , init
        , now
        )

{-| Describe the model and this relation
-}

import Message exposing (Message(..))
import Zipper.History as History exposing (History)
import File


{-| Describe the model of the Application
-}
type alias Model =
    { config : Configuration
    , history : History File.Path
    }


{-| Describe the configuration of the Application
-}
type alias Configuration =
    { terminal : String }


{-| Describe the input from JavaScript
-}
type alias Flags =
    { current : File.Path
    , config : Configuration
    , home : File.Path
    , root : File.Path
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


{-| Get the current state of the navigation
-}
now : Model -> String
now model =
    model.history.present
