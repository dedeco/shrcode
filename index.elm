module Main exposing (Model, Msg(..), add, edit, initModel, main, save, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String



-- model


type alias Snippet =
    { id : Int
    , title : String
    , body : String
    , tags : List Tag
    }


type alias Tag =
    { id : Int
    , name : String
    }


type alias Model =
    { snippets : List Snippet
    , snippet_id : Maybe Int
    , title : String
    , body : String
    , tag_ : String
    }


initModel : Model
initModel =
    { snippets = []
    , snippet_id = Nothing
    , title = ""
    , body = ""
    , tag_ = ""
    }


type Msg
    = InputTitle String
    | InputBody String
    | InputTag String
    | Cancel
    | Save
    | Clear

-- update

update : Msg -> Model -> Model
update msg model =
    case msg of
        InputTitle title ->
            { model | title = title }

        InputBody body ->
            { model | body = body }

        InputTag tag_ ->
            { model | tag_ = tag_ }

        Cancel ->
            { model
                | snippet_id = Nothing
                , title = ""
                , body = ""
                , tag_ = ""
            }

        Save ->
            if String.isEmpty model.title then
                model

            else
                save model

        _ ->
            model


save : Model -> Model
save model =
    case model.snippet_id of
        Just id ->
            edit model id

        Nothing ->
            add model


add : Model -> Model
add model =
    let
        --tag_ =
        --    Tag model.tag_
        --newtags =
        --    tag_ :: []
        snippet =
            Snippet (List.length model.snippets) model.title model.body []

        newSnippets =
            snippet :: model.snippets
    in
    { model
        | snippets = newSnippets
        , title = ""
        , body = ""
        , tag_ = ""
    }


edit : Model -> Int -> Model
edit model id =
    let
        newSnippets =
            List.map
                (\snippet ->
                    if snippet.id == id then
                        { snippet | title = model.title }

                    else
                        snippet
                )
                model.snippets
    in
    { model
        | snippets = newSnippets
    }

-- view

view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Create your snippet" ]
        , snipetForm model
        ]


snipetForm : Model -> Html Msg
snipetForm model =
    Html.form [ onSubmit Save ]
        [ input
            [ type_ "text"
            , onInput InputTitle
            , value model.title
            ]
            []
        , textarea
            [ onInput InputBody
            , value model.body
            ]
            []
        , input
            [ type_ "text"
            , onInput InputTag
            , value model.tag_
            ]
            []
        , button [ type_ "submit" ] [ text "Save" ]
        , button [ type_ "button", onClick Cancel ] [ text "Cancel" ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initModel
        , view = view
        , update = update
        }
