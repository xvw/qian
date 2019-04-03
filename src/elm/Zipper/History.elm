module Zipper.History exposing
    ( History
    , backward
    , fold
    , forward
    , hasFuture
    , hasPast
    , isSingleton
    , map
    , new
    , present
    , push
    )


type History a
    = History
        { present : a
        , past : List a
        , future : List a
        }


make : a -> List a -> List a -> History a
make current past future =
    History
        { present = current
        , past = past
        , future = future
        }


new : a -> History a
new currentState =
    make
        currentState
        []
        []


push : History a -> a -> History a
push (History zipper) newCurrentData =
    make
        newCurrentData
        (zipper.present :: zipper.past)
        []


backward : History a -> Maybe (History a)
backward (History zipper) =
    case zipper.past of
        [] ->
            Nothing

        newPresent :: newPast ->
            Just
                (make
                    newPresent
                    newPast
                    (zipper.present :: zipper.future)
                )


forward : History a -> Maybe (History a)
forward (History zipper) =
    case zipper.future of
        [] ->
            Nothing

        newPresent :: newFuture ->
            Just
                (make newPresent
                    (zipper.present :: zipper.past)
                    newFuture
                )


hasPast : History a -> Bool
hasPast zipper =
    case backward zipper of
        Nothing ->
            False

        Just _ ->
            True


hasFuture : History a -> Bool
hasFuture zipper =
    case forward zipper of
        Nothing ->
            False

        Just _ ->
            True


present : History a -> a
present (History zipper) =
    zipper.present


isSingleton : History a -> Bool
isSingleton zipper =
    not (hasPast zipper || hasFuture zipper)


map : (a -> b) -> History a -> History b
map f (History zipper) =
    make
        (f zipper.present)
        (List.map f zipper.past)
        (List.map f zipper.future)


fold : (a -> b -> b) -> b -> History a -> b
fold reducer init (History zipper) =
    zipper.past
        |> List.foldr reducer init
        |> reducer zipper.present
        |> (\x -> List.foldl reducer x zipper.future)
