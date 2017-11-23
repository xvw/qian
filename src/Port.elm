port module Port
    exposing
        ( Terminal
        , getTree
        , retreiveTree
        , treeMutation
        , openFile
        , openInFinder
        , openInTerminal
        )

{-| JavaScript interopt
-}

import File


type alias Terminal =
    { app : String
    , path : File.Path
    }


{-| Get the tree of files from a Path
-}
port getTree : File.Path -> Cmd msg


{-| Retreives the tree as a subscription
-}
port retreiveTree : (File.Tree -> msg) -> Sub msg


{-| Watch the TreeMutation
-}
port treeMutation : (Bool -> msg) -> Sub msg


{-| Open a file with a default program
-}
port openFile : File.Path -> Cmd msg


{-| Open a path in a Finder
-}
port openInFinder : File.Path -> Cmd msg


{-| Open a path in a terminal
-}
port openInTerminal : Terminal -> Cmd msg
