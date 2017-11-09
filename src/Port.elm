port module Port
    exposing
        ( ls
        , getDirTree
        )

import File exposing (Path, Tree)


port ls : Path -> Cmd msg


port getDirTree : (Tree -> msg) -> Sub msg
