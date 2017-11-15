module Main exposing (..)

import Action
import Combination
import Html exposing (programWithFlags)
import Architecture exposing (Message(..), Model, Flags)
import View exposing (global)
import Zipper.History as History
import Port
import Keyboard
import Set


init : Flags -> ( Model, Cmd Message )
init flags =
    ( { history = History.new flags.pwd
      , home = flags.home
      , tree = { path = "", entries = [] }
      , showHidden = False
      , searchState = ""
      , keys = Set.empty
      }
    , Port.ls flags.pwd
    )


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.batch
        [ Port.getDirTree RetreiveTree
        , Port.treeMutation TreeMutation
        , Keyboard.downs KeyDown
        , Keyboard.ups KeyUp
        ]


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        Patch f ->
            f model

        RetreiveTree tree ->
            Action.getDir tree model

        TreeMutation flag ->
            Action.treeMutation flag model

        KeyUp k ->
            Combination.keyUp k model

        KeyDown k ->
            Combination.keyDown k model


main : Platform.Program Flags Model Message
main =
    programWithFlags
        { init = init
        , update = update
        , view = global
        , subscriptions = subscriptions
        }
