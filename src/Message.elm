module Message exposing (Message(..))

{-| Describe the messages of the application
-}

import File
import Zipper.History as History exposing (History)


type Message
    = ChangeDir File.Path
    | NavigateHistory (History File.Path)
    | ChangeTree File.Tree
