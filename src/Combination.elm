module Combination exposing (keyUp, keyDown)

import Keyboard exposing (KeyCode)
import Architecture exposing (Model, Message)
import Set exposing (Set)
import Action


type Combination
    = Enter
    | AltEnter
    | AltLeft
    | AltRight
    | AltUp
    | Void


allowed : List KeyCode
allowed =
    [ 13, 18, 37, 38, 39 ]


enter : Set KeyCode
enter =
    Set.singleton 13


altEnter : Set KeyCode
altEnter =
    Set.fromList [ 13, 18 ]


altLeft : Set KeyCode
altLeft =
    Set.fromList [ 18, 37 ]


altUp : Set KeyCode
altUp =
    Set.fromList [ 18, 38 ]


altRight : Set KeyCode
altRight =
    Set.fromList [ 18, 39 ]


keyUp : KeyCode -> Model -> ( Model, Cmd Message )
keyUp key model =
    ( { model | keys = Set.remove key model.keys }, Cmd.none )


keyDown : KeyCode -> Model -> ( Model, Cmd Message )
keyDown key model =
    if List.member key allowed then
        { model | keys = Set.insert key model.keys }
            |> handle
    else
        ( model, Cmd.none )


dispatch : Set KeyCode -> Combination
dispatch set =
    if set == enter then
        Enter
    else if set == altEnter then
        AltEnter
    else if set == altLeft then
        AltLeft
    else if set == altRight then
        AltRight
    else if set == altUp then
        AltUp
    else
        Void


handle : Model -> ( Model, Cmd Message )
handle model =
    case dispatch model.keys of
        AltEnter ->
            Action.openTerminal model.history.present model

        AltLeft ->
            Action.backward model

        AltRight ->
            Action.forward model

        AltUp ->
            Action.toParent model

        _ ->
            ( model, Cmd.none )
