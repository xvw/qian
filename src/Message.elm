module Message exposing (Message(..))

{-| Describe the messages of the application
-}

import File
import Zipper.History as History exposing (History)


type Message
    = ChangeDir File.Path -- When a "cd" is required
    | NavigateHistory (History File.Path) -- Using the button pred/next
    | ChangeTree File.Tree -- Retreive the file tree via Sub
    | OpenItem File.Item -- Open a file or a folder
    | OpenInFinder -- Open current path into Finder
    | OpenInTerminal -- Open current path into a terminal
    | TreeMutation Bool -- Retreive a Tree mutation via Sub
