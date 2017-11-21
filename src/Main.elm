module Main exposing (..)

{-| Entry point of the Application
-}

import Html
import View
import Model exposing (Model, Flags)
import Message exposing (Message)
import File


{-| Subscriptions (discretes signals) of the app
-}
subscriptions : Model -> Sub Message
subscriptions model =
    Sub.batch []


{-| Update
-}
update : Message -> Model -> ( Model, Cmd Message )
update message model =
    ( model, Cmd.none )


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
