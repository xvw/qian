module Model
    exposing
        ( Model
        , Flags
        , State(..)
        , init
        , now
        )

{-| Describe the model and this relation
-}

import Message exposing (Message(..))
import Zipper.History as History exposing (History)
import File
import Port exposing (Configuration)


{-| A Poor RemoteData
-}
type State
    = Explore
    | Configure { inputState : String }


{-| Describe the model of the Application
-}
type alias Model =
    { config : Configuration -- Configuration
    , history : History File.Path -- History and current Path
    , realTree : File.Tree -- The real current file tree
    , currentTree : File.Tree -- The tree to be filtered (and displayed)
    , displayHiddenItem : Bool -- Show (or not) the hidden files
    , searchState : String -- The state of the search bar !
    , homePath : File.Path -- The home path
    , state : State
    }


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
      , realTree = []
      , currentTree = []
      , displayHiddenItem = False
      , searchState = ""
      , homePath = flags.home
      , state = Explore
      }
    , Port.getTree flags.current
    )


{-| Get the current state of the navigation
-}
now : Model -> String
now model =
    model.history.present
