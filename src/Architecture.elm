module Architecture
    exposing
        ( Message(..)
        , Model
        , Flags
        )

import Zipper.History exposing (History)
import Path exposing (Tree, Path)
import Keyboard exposing (KeyCode)
import Set exposing (Set)


type alias Flags =
    { pwd : Path
    , home : Path
    }


type Message
    = Patch (Model -> ( Model, Cmd Message ))
    | RetreiveTree Tree
    | TreeMutation Bool
    | KeyDown KeyCode
    | KeyUp KeyCode


type alias Model =
    { history : History Path
    , home : Path
    , tree : Tree
    , displayedTree : Tree
    , showHidden : Bool
    , searchState : String
    , keys : Set KeyCode
    }
