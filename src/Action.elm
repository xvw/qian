module Action
    exposing
        ( changeDir
        )

{-| Provide all "action" of the application
-}

import Model exposing (Model)
import Message exposing (Message(..))
import Zipper.History as History exposing (History)
import File


{-| Perform a "dir changement"
-}
changeDir : Model -> File.Path -> ( Model, Cmd Message )
changeDir model newPath =
    changeHistory model (\history -> History.push history newPath)


{-| Perform a modification in the history using a function
-}
changeHistory : Model -> (History File.Path -> History File.Path) -> ( Model, Cmd Message )
changeHistory model f =
    let
        newModel =
            { model | history = f model.history }
    in
        ( newModel, Cmd.none )
