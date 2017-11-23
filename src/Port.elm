port module Port
    exposing
        ( getTree
        , retreiveTree
        , treeMutation
        , openFile
        , openInFinder
        )

{-| JavaScript interopt
-}

import File


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
