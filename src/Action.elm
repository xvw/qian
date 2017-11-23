module Action
    exposing
        ( changeDir
        , navigateHistory
        , changeTree
        , treeMutation
        , openItem
        )

{-| Provide all "action" of the application
-}

import Model exposing (Model)
import Message exposing (Message(..))
import Zipper.History as History exposing (History)
import File
import Port


{-| Perform a "dir changement"
-}
changeDir : Model -> File.Path -> ( Model, Cmd Message )
changeDir model newPath =
    changeHistory model (\history -> History.push history newPath)


navigateHistory : Model -> History File.Path -> ( Model, Cmd Message )
navigateHistory model newHistory =
    let
        newModel =
            { model | history = newHistory }
    in
        ( newModel, Port.getTree (Model.now newModel) )


{-| Change the current tree
-}
changeTree : Model -> File.Tree -> ( Model, Cmd Message )
changeTree model tree =
    let
        newModel =
            { model | realTree = tree, currentTree = tree }
    in
        ( newModel, Cmd.none )


{-| Change the current Tree if the file System watch an update
-}
treeMutation : Model -> Bool -> ( Model, Cmd Message )
treeMutation model flag =
    if flag then
        ( model, Port.getTree (Model.now model) )
    else
        ( model, Cmd.none )


{-| Open a folder or a file
-}
openItem : Model -> File.FromFinder -> ( Model, Cmd Message )
openItem model file =
    if file.directory then
        changeDir model file.path
    else
        ( model, Port.openFile file.path )


{-| Perform a modification in the history using a function
-}
changeHistory : Model -> (History File.Path -> History File.Path) -> ( Model, Cmd Message )
changeHistory model f =
    let
        newModel =
            { model | history = f model.history }
    in
        ( newModel, Port.getTree (Model.now newModel) )
