module Architecture
    exposing
        ( Message(..)
        , Model
        , Flags
        )

import Zipper.History exposing (History)
import File exposing (Tree, Path)


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


type alias Model =
    { history : History Path
    , home : Path
    , tree : Tree
    , showHidden : Bool
    }
