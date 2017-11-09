module Architecture
    exposing
        ( Message(..)
        , Model
        , Flags
        , Pwd
        )

import Zipper.History exposing (History)


type alias Pwd =
    List String


type alias Flags =
    { pwd : Pwd }


type Message
    = Cd Pwd


type alias Model =
    { pwd : Pwd
    , history : History Pwd
    }
