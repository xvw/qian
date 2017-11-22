module Message exposing (Message(..))

{-| Describe the messages of the application
-}

import File


type Message
    = ChangeDir File.Path
