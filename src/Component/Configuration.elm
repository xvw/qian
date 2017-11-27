module Component.Configuration exposing (render)

{-| The configuration Pan
-}

import Message exposing (Message(..))
import Html.Attributes as Attr
import Html.Events exposing (onClick, onInput)
import Html
    exposing
        ( Html
        , text
        , h2
        , div
        , span
        , input
        , button
        , br
        )


{-| Render the pan to change the default terminal
-}
render : String -> Html Message
render state =
    div []
        [ h2 [] [ text "Configuration" ]
        , div []
            [ span [] [ text "Default Terminal" ]
            , input
                [ Attr.value state
                , Attr.type_ "text"
                , onInput RecordConfigTerminal
                ]
                []
            , button
                [ Attr.class "save-btn"
                , onClick ChangeDefaultTerminal
                ]
                [ text "Save" ]
            , br [] []
            , br [] []
            , button
                [ Attr.class "quit-btn"
                , onClick GoToTree
                ]
                [ text "back" ]
            ]
        ]
