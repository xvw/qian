port module Port
    exposing
        ( ls
        , getDirTree
        , openFile
        , openInExplorer
        , treeMutation
        , openTerminal
        )

import Path exposing (Path, Tree)


port ls : Path -> Cmd msg


port openFile : Path -> Cmd msg


port openInExplorer : Path -> Cmd msg


port openTerminal : Path -> Cmd msg


port getDirTree : (Tree -> msg) -> Sub msg


port treeMutation : (Bool -> msg) -> Sub msg
