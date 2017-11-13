module Main exposing (..)

import Html exposing (programWithFlags)
import Architecture exposing (Message(..), Model, Flags)
import Action exposing (changeHistory)
import View exposing (global)
import Zipper.History as History
import Port
import Keyboard
import Interactive


init : Flags -> ( Model, Cmd Message )
init flags =
    ( { history = History.new flags.pwd
      , home = flags.home
      , tree = []
      , showHidden = False
      , searchState = ""
      }
    , Port.ls flags.pwd
    )


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.batch
        [ Port.getDirTree GetDirTree
        , Keyboard.downs HandleInput
        ]


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        ChangeDirectory newPwd ->
            Action.changeHistory model (\h -> History.push h newPwd)

        Backward ->
            Action.changeHistory model History.backward

        Forward ->
            Action.changeHistory model History.forward

        ToggleHidden ->
            Action.toggleHidden model

        GetDirTree tree ->
            ( Action.patchSearch { model | tree = tree }, Cmd.none )

        RecordSearchState value ->
            ( { model | searchState = value }, Cmd.none )

        OpenFile file ->
            ( model, Port.openFile file )

        OpenInFinder path ->
            ( model, Port.openInFinder path )

        HandleInput keycode ->
            Interactive.update model keycode


main : Platform.Program Flags Model Message
main =
    programWithFlags
        { init = init
        , update = update
        , view = global
        , subscriptions = subscriptions
        }
