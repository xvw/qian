module Main exposing (..)

import Html exposing (programWithFlags)
import Architecture exposing (Message(..), Model, Flags)
import Action exposing (changeHistory)
import View exposing (global)
import Zipper.History as History
import Port


init : Flags -> ( Model, Cmd Message )
init flags =
    ( { history = History.new flags.pwd
      , home = flags.home
      , tree = []
      }
    , Port.ls flags.pwd
    )


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.batch
        [ Port.getDirTree GetDirTree ]


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        ChangeDirectory newPwd ->
            Action.changeHistory model (\h -> History.push h newPwd)

        Backward ->
            Action.changeHistory model History.backward

        Forward ->
            Action.changeHistory model History.forward

        GetDirTree tree ->
            ( { model | tree = tree }, Cmd.none )


main : Platform.Program Flags Model Message
main =
    programWithFlags
        { init = init
        , update = update
        , view = global
        , subscriptions = subscriptions
        }
