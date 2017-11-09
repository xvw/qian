module Main exposing (..)

import Html exposing (programWithFlags)
import Architecture exposing (Message(..), Model, Flags)
import Action exposing (changeDirectory)
import View exposing (global)
import Zipper.History as History


init : Flags -> ( Model, Cmd Message )
init flags =
    ( { pwd = flags.pwd
      , history = History.new ()
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.none


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        Cd newPwd ->
            Action.changeDirectory model newPwd


main : Platform.Program Flags Model Message
main =
    programWithFlags
        { init = init
        , update = update
        , view = global
        , subscriptions = subscriptions
        }
