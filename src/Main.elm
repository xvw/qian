module Main exposing (..)

import Action
import Html exposing (programWithFlags)
import Architecture exposing (Message(..), Model, Flags)
import View exposing (global)
import Zipper.History as History
import Port


init : Flags -> ( Model, Cmd Message )
init flags =
    ( { history = History.new flags.pwd
      , home = flags.home
      , tree = []
      , showHidden = False
      , searchState = ""
      , cmdPressed = False
      }
    , Port.ls flags.pwd
    )


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.batch
        [ Port.getDirTree RetreiveTree
        ]


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        Patch f ->
            f model

        RetreiveTree tree ->
            Action.getDir tree model


main : Platform.Program Flags Model Message
main =
    programWithFlags
        { init = init
        , update = update
        , view = global
        , subscriptions = subscriptions
        }
