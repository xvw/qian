module Architecture
    exposing
        ( Message(..)
        , Model
        , Flags
        )

import Zipper.History exposing (History)
import File exposing (Tree, Path)
import Keyboard


type alias Flags =
    { pwd : Path
    , home : Path
    }


type Message
    = ChangeDirectory Path
    | Backward
    | Forward
    | ToggleHidden
    | GetDirTree Tree
    | OpenFile Path
    | OpenInFinder Path
    | RecordSearchState String
    | HandlePress Keyboard.KeyCode
    | HandleDown Keyboard.KeyCode
    | HandleUp Keyboard.KeyCode


type alias Model =
    { history : History Path
    , home : Path
    , tree : Tree
    , showHidden : Bool
    , searchState : String
    , cmdPressed : Bool
    }
