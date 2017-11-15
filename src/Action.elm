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
        , keyDown
        , keyUp
        )

import Zipper.History as History exposing (History)
import Architecture exposing (Model, Message(..))
import Path exposing (Path, Tree)
import Port
import Keyboard exposing (KeyCode)
import Set
import Combination


clearSearch : Model -> Model
clearSearch model =
    { model | searchState = "" }


fillSearch : String -> Model -> ( Model, Cmd Message )
fillSearch value model =
    ( { model | searchState = value }, Cmd.none )


backward : Model -> ( Model, Cmd Message )
backward model =
    changeHistory model History.backward


forward : Model -> ( Model, Cmd Message )
forward model =
    changeHistory model History.forward


changeDir : Path -> Model -> ( Model, Cmd Message )
changeDir pwd model =
    changeHistory model (\h -> History.push h pwd)


getDir : Tree -> Model -> ( Model, Cmd Message )
getDir tree model =
    ( { model | tree = tree } |> clearSearch, Cmd.none )


changeHistory : Model -> (History Path -> History Path) -> ( Model, Cmd Message )
changeHistory model f =
    let
        newModel =
            { model | history = f model.history }
    in
        ( clearSearch newModel, Port.ls newModel.history.present )


toggleHidden : Model -> ( Model, Cmd Message )
toggleHidden model =
    ( { model | showHidden = not model.showHidden }, Cmd.none )


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


keyDown : KeyCode -> Model -> ( Model, Cmd Message )
keyDown key model =
    let
        d =
            Debug.log "foo" model.keys
    in
        { model | keys = Set.insert key model.keys }
            |> Combination.handle


keyUp : KeyCode -> Model -> ( Model, Cmd Message )
keyUp key model =
    ( { model | keys = Set.remove key model.keys }, Cmd.none )
