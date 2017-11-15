module Combination exposing (keyUp, keyDown)

import Keyboard exposing (KeyCode)
import Architecture exposing (Model, Message)
import Set exposing (Set)
import Action


type Combination
    = Enter
    | CmdEnter
    | CmdShiftEnter
    | CmdLeft
    | CmdRight
    | CmdUp
    | CmdW
    | Void


allowed : List KeyCode
allowed =
    [ 13, 16, 18, 37, 38, 39, 87 ]


enter : Set KeyCode
enter =
    Set.singleton 13


cmdEnter : Set KeyCode
cmdEnter =
    Set.fromList [ 13, 18 ]


cmdShiftEnter : Set KeyCode
cmdShiftEnter =
    Set.fromList [ 13, 16, 18 ]


cmdLeft : Set KeyCode
cmdLeft =
    Set.fromList [ 18, 37 ]


cmdUp : Set KeyCode
cmdUp =
    Set.fromList [ 18, 38 ]


cmdRight : Set KeyCode
cmdRight =
    Set.fromList [ 18, 39 ]


cmdW : Set KeyCode
cmdW =
    Set.fromList [ 18, 87 ]


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
    else if set == cmdEnter then
        CmdEnter
    else if set == cmdShiftEnter then
        CmdShiftEnter
    else if set == cmdLeft then
        CmdLeft
    else if set == cmdRight then
        CmdRight
    else if set == cmdUp then
        CmdUp
    else if set == cmdW then
        CmdW
    else
        Void


handle : Model -> ( Model, Cmd Message )
handle model =
    case dispatch model.keys of
        CmdEnter ->
            Action.openTerminal model.history.present model

        CmdLeft ->
            Action.backward model

        CmdRight ->
            Action.forward model

        CmdUp ->
            Action.toParent model

        CmdW ->
            Action.toggleHidden model

        CmdShiftEnter ->
            Action.openInExplorer model.history.present model

        Enter ->
            if not (String.isEmpty model.searchState) then
                Action.openFirst model
            else
                ( model, Cmd.none )

        _ ->
            ( model, Cmd.none )
