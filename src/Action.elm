module Action
    exposing
        ( changeDir
        , navigateHistory
        , changeTree
        , treeMutation
        , openItem
        , openInFinder
        , openInTerminal
        , toggleDisplayHiddenItem
        )

{-| Provide all "action" of the application
-}

import Model exposing (Model)
import Message exposing (Message(..))
import Zipper.History as History exposing (History)
import File
import Port


{-| Compute the "displayed" tree of a Model
-}
computeCurrentTree : Model -> Model
computeCurrentTree model =
    let
        newTree =
            if not model.displayHiddenItem then
                model
                    |> .realTree
                    |> List.filter (\f -> not f.hidden)
            else
                model.realTree
    in
        { model | currentTree = newTree }


{-| Activate/Deactivate the display of Hidden Files/folders
-}
toggleDisplayHiddenItem : Model -> ( Model, Cmd Message )
toggleDisplayHiddenItem model =
    let
        newModel =
            { model | displayHiddenItem = not model.displayHiddenItem }
    in
        ( computeCurrentTree newModel, Cmd.none )


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
                |> computeCurrentTree
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
openItem : Model -> File.Item -> ( Model, Cmd Message )
openItem model file =
    if file.directory then
        changeDir model file.path
    else
        ( model, Port.openFile file.path )


{-| Open current Path into a finder
-}
openInFinder : Model -> ( Model, Cmd Message )
openInFinder model =
    let
        currentPath =
            Model.now model
    in
        ( model, Port.openInFinder currentPath )


{-| Open current Path into a terminal
-}
openInTerminal : Model -> ( Model, Cmd Message )
openInTerminal model =
    let
        currentPath =
            Model.now model

        terminal =
            model.config.terminal

        params =
            { app = terminal
            , path = currentPath
            }
    in
        ( model, Port.openInTerminal params )


{-| Perform a modification in the history using a function
-}
changeHistory : Model -> (History File.Path -> History File.Path) -> ( Model, Cmd Message )
changeHistory model f =
    let
        newModel =
            { model | history = f model.history }
    in
        ( newModel, Port.getTree (Model.now newModel) )
