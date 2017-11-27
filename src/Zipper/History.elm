module Zipper.History
    exposing
        ( History
        , new
        , push
        , backward
        , forward
        , present
        , hasPast
        , hasFuture
        )

{-| This library defines a generic and navigable history.
The implementation is based on a ZipperList.
-}


{-| Represent a current state with a potential past and a
potential future.
-}
type alias History a =
    { present : a
    , past : List a
    , future : List a
    }


{-| Initialize an History, with a current state.
-}
new : a -> History a
new currentState =
    { present = currentState
    , past = []
    , future = []
    }


{-| Add an entry into the history.
-}
push : History a -> a -> History a
push zipper newCurrentData =
    { present = newCurrentData
    , past = zipper.present :: zipper.past
    , future = []
    }


{-| Move left (in the past) in the zipper.
-}
backward : History a -> Maybe (History a)
backward zipper =
    case zipper.past of
        [] ->
            Nothing

        newPresent :: newPast ->
            Just
                { present = newPresent
                , past = newPast
                , future = zipper.present :: zipper.future
                }


{-| Move right (in the future) in the zipper.
-}
forward : History a -> Maybe (History a)
forward zipper =
    case zipper.future of
        [] ->
            Nothing

        newPresent :: newFuture ->
            Just
                { present = newPresent
                , past = zipper.present :: zipper.past
                , future = newFuture
                }


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
present zipper =
    zipper.present
