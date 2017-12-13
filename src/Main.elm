module Main exposing (..)

{-| Entry point of the Application
-}

import Html
import View
import Action
import Port
import Model exposing (Model, Flags)
import Message exposing (Message(..))


{-| Subscriptions (discretes signals) of the app
-}
subscriptions : Model -> Sub Message
subscriptions model =
    Sub.batch
        [ Port.retreiveTree ChangeTree
        , Port.treeMutation TreeMutation
        , Port.historyNavigation NavigateHistoryFromMenu
        ]


{-| Update process
-}
update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        ToggleDisplayHiddenItem ->
            Action.toggleDisplayHiddenItem model

        ChangeDir newDir ->
            Action.changeDir model newDir

        ChangeTree newTree ->
            Action.changeTree model newTree

        NavigateHistory newHistory ->
            Action.navigateHistory model newHistory

        OpenItem target ->
            Action.openItem model target

        OpenInFinder ->
            Action.openInFinder model

        OpenInTerminal ->
            Action.openInTerminal model

        TreeMutation flag ->
            Action.treeMutation model flag

        RecordSearchState content ->
            Action.recordSearchState model content

        RecordConfigTerminal content ->
            Action.recordConfigTerminal model content

        GoToSettings ->
            Action.goToSettings model

        GoToTree ->
            Action.goToTree model

        NavigateHistoryFromMenu isPast ->
            Action.navigateHistoryFromMenu model isPast

        ChangeDefaultTerminal ->
            Action.changeDefaultTerminal model


{-| Main program
-}
main : Platform.Program Flags Model Message
main =
    Html.programWithFlags
        { init = Model.init
        , update = update
        , view = View.global
        , subscriptions = subscriptions
        }
