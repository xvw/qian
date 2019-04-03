module Util exposing (try)

{-| Usefuls functions for the whole project
-}


{-| Try to fetch data with potential failure. Returns
the "input" if the function fail
-}
try : (a -> Maybe a) -> a -> a
try data f =
    Maybe.withDefault data (f data)
