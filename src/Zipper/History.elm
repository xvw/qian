module Zipper.History
    exposing
        ( History
        , new
        , push
        , present
        , backward
        , forward
        , hasPast
        , hasFuture
        )


type alias History a =
    { past : List a
    , present : a
    , future : List a
    }


new : a -> History a
new data =
    { past = []
    , present = data
    , future = []
    }


push : History a -> a -> History a
push zipper data =
    { past = zipper.present :: zipper.past
    , present = data
    , future = []
    }


rewrite : History a -> a -> History a
rewrite zipper data =
    { zipper
        | past = zipper.present :: zipper.past
        , present = data
    }


present : History a -> a
present zipper =
    zipper.present


backward : History a -> History a
backward zipper =
    case zipper.past of
        [] ->
            zipper

        x :: xs ->
            { past = xs
            , present = x
            , future = zipper.present :: zipper.future
            }


forward : History a -> History a
forward zipper =
    case zipper.future of
        [] ->
            zipper

        x :: xs ->
            { past = zipper.present :: zipper.past
            , present = x
            , future = xs
            }


hasPast : History a -> Bool
hasPast zipper =
    not (List.isEmpty zipper.past)


hasFuture : History a -> Bool
hasFuture zipper =
    not (List.isEmpty zipper.future)
