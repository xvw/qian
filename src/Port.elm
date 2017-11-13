port module Port
    exposing
        ( ls
        , getDirTree
        , openFile
        )

import File exposing (Path, Tree)


port ls : Path -> Cmd msg


port openFile : Path -> Cmd msg


port getDirTree : (Tree -> msg) -> Sub msg
