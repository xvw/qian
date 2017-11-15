module Action
    exposing
        ( changeDir
        , toggleHidden
        , clearSearch
        , fillSearch
        , backward
        , forward
        , getDir
        , openFile
        , openInExplorer
        , openTerminal
        , treeMutation
        , toParent
        , openFirst
        )

import Zipper.History as History exposing (History)
import Architecture exposing (Model, Message(..))
import Path exposing (Path, Tree, Parent(..))
import Port


processFilter : Model -> Model
processFilter model =
    let
        f =
            (Path.purgeHidden model.showHidden)
                >> (Path.filterBy model.searchState)
    in
        { model | displayedTree = f model.tree }


clearSearch : Model -> Model
clearSearch model =
    { model | searchState = "" }


fillSearch : String -> Model -> ( Model, Cmd Message )
fillSearch value model =
    ( { model | searchState = value }
        |> processFilter
    , Cmd.none
    )


backward : Model -> ( Model, Cmd Message )
backward model =
    changeHistory model History.backward


forward : Model -> ( Model, Cmd Message )
forward model =
    changeHistory model History.forward


toParent : Model -> ( Model, Cmd Message )
toParent model =
    case Path.parent model.history.present of
        Root ->
            changeDir "" model

        Folder f ->
            changeDir f model

        AtRoot ->
            ( model, Cmd.none )


changeDir : Path -> Model -> ( Model, Cmd Message )
changeDir pwd model =
    changeHistory model (\h -> History.push h pwd)


getDir : Tree -> Model -> ( Model, Cmd Message )
getDir tree model =
    ( { model | tree = tree }
        |> processFilter
        |> clearSearch
    , Cmd.none
    )


changeHistory : Model -> (History Path -> History Path) -> ( Model, Cmd Message )
changeHistory model f =
    let
        newModel =
            { model | history = f model.history }
    in
        ( clearSearch newModel, Port.ls newModel.history.present )


toggleHidden : Model -> ( Model, Cmd Message )
toggleHidden model =
    ( { model | showHidden = not model.showHidden }
        |> processFilter
    , Cmd.none
    )


openFile : Path -> Model -> ( Model, Cmd Message )
openFile path model =
    ( model, Port.openFile path )


openInExplorer : Path -> Model -> ( Model, Cmd Message )
openInExplorer path model =
    ( model, Port.openInExplorer path )


openTerminal : Path -> Model -> ( Model, Cmd Message )
openTerminal path model =
    ( model, Port.openTerminal path )


treeMutation : Bool -> Model -> ( Model, Cmd Message )
treeMutation bool model =
    if bool then
        ( model, Port.ls model.history.present )
    else
        ( model, Cmd.none )


openFirst : Model -> ( Model, Cmd Message )
openFirst model =
    case model.displayedTree.entries of
        x :: _ ->
            let
                path =
                    Path.join [ model.tree.path, x.name ]
            in
                if x.isDirectory then
                    changeDir path model
                else
                    openFile path model

        _ ->
            ( model, Cmd.none )
