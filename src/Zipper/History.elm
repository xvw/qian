module Zipper.History exposing
    ( History
    , backward
    , forward
    , hasFuture
    , hasPast
    , isSingleton
    , new
    , present
    , push
    )

{-| This library defines a generic and navigable history.
The implementation is based on a ZipperList.

This "structure" is useful to manage "history".

-}


{-| Represent a current state with a potential past and a
potential future.
-}
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


{-| Initialize an History, with a current state.
-}
new : a -> History a
new currentState =
    make
        currentState
        []
        []


{-| Add an entry into the history.
-}
push : History a -> a -> History a
push (History zipper) newCurrentData =
    make
        newCurrentData
        (zipper.present :: zipper.past)
        []


{-| Move left (in the past) in the zipper.
-}
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


{-| Move right (in the future) in the zipper.
-}
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


{-| Return `True` if the zipper has a past, `False` otherwise.
-}
hasPast : History a -> Bool
hasPast zipper =
    case backward zipper of
        Nothing ->
            False

        Just _ ->
            True


{-| Return `True` if the zipper has a future, `False` otherwise.
-}
hasFuture : History a -> Bool
hasFuture zipper =
    case forward zipper of
        Nothing ->
            False

        Just _ ->
            True


{-| Return the current state of the Zipper.
-}
present : History a -> a
present (History zipper) =
    zipper.present


{-| Return `True` if the zipper contains one values, `False` otherwise.
-}
isSingleton : History a -> Bool
isSingleton zipper =
    not (hasPast zipper || hasFuture zipper)
