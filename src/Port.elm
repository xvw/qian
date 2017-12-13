port module Port
    exposing
        ( Terminal
        , Configuration
        , getTree
        , retreiveTree
        , treeMutation
        , openFile
        , openInFinder
        , openInTerminal
        , changeTerminal
        , historyNavigation
        , jumpToParent
        )

{-| JavaScript interopt
-}

import File


{-| Represent the configuration of an application
-}
type alias Configuration =
    { terminal : String }


{-| Represent a terminal call
-}
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


{-| Perform a modification on the history from Electron
-}
port historyNavigation : (Bool -> msg) -> Sub msg


{-| Jump to the parent from Electron
-}
port jumpToParent : (Bool -> msg) -> Sub msg


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


{-| Change the current terminal
-}
port changeTerminal : Configuration -> Cmd msg
