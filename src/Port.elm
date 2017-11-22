port module Port
    exposing
        ( getTree
        , retreiveTree
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
