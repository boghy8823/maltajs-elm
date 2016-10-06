module Form exposing (..)

import Html exposing (Html, text, button, div, section, article, h1, p, a, header, ol, li, h2, text, form, input, label, fieldset, img, span)

import Html.App as App
import Html.Events exposing (onClick, on, onInput)
import Html.Attributes exposing ( id, type', for, value, class, href, class, required, src, disabled)
import Http
import Task exposing (Task)
import Json.Decode exposing (list, string)
import String exposing (join, isEmpty)
import Regex
import Json.Encode
import Json.Decode 


-- MODEL
type alias Model = 
  { name : String
  , surname : String
  , company : String
  , email : String
  , error : String
  }

initialModel : Model
initialModel =
  { name = ""
  , surname = ""
  , company = ""
  , email = ""
  , error = ""
  }



-- MESSAGES


type Msg
  = Name String
  | Surname String
  | Company String
  | Email String



-- VIEW

formFieldClasses = String.join " " [ "form-group", "col-xs-9" ]

view : Model -> Html Msg
view model =
    form [ id "signup-form", class "container-fluid" ]  
    [ fieldset [ class formFieldClasses ]
      [ label [ for "name" ] [ text "Name: " ]
      , input 
        [ id "name"
        , type' "text"
        , class "form-control"
        , value model.name
        , required True
        , onInput Name
        ] []
      ]
    , fieldset [ class formFieldClasses ]
      [ label [ for "surname" ] [ text "Surname: " ]
      , input 
        [ id "surname"
        , type' "text"
        , class "form-control"
        , value model.surname
        , required True
        , onInput Surname
        ] []
      ]
    , fieldset [ class formFieldClasses ]
      [ label [ for "company" ] [ text "Company: " ]
      , input 
        [ id "company"
        , type' "text"
        , class "form-control"
        , value model.company
        , required True
        , onInput Company
        ] []
      ]
    , fieldset [ class formFieldClasses ]
      [ label [ for "email" ] [ text "Email: " ]
      , input 
        [ id "email"
        , type' "email"
        , class "form-control"
        , value model.email
        , required True
        , onInput Email
        ] []
      ]
   ]

alertView : Model -> Html a
alertView model =
  let
    classes =
      if (isFormInvalid model) then "alert alert-danger small" 
      else "hide"
  in
    div [ class classes ]
      [ span [ class "glyphicon glyphicon-exclamation-sign" ] []
      , p [ class "text-danger form-error-message" ] [ text "please fill in all the required fields" ]  
      ]


-- UTILS

isFormInvalid model = 
  let
    -- from http://emailregex.com/
    regex = "^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]{1,6})+$"
      |> Regex.regex
      |> Regex.caseInsensitive
    isMailOk = Regex.contains regex model.email
  in
    (isEmpty model.name || isEmpty model.surname || isEmpty model.email) || not isMailOk

isFormValid model = not (isFormInvalid model)

formToJson : Model -> Json.Encode.Value
formToJson model = 
  Json.Encode.object 
    [ ("name", Json.Encode.string model.name)
    , ("surname", Json.Encode.string model.surname)
    , ("company", Json.Encode.string model.company)
    , ("email", Json.Encode.string model.email)
    ]

-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
  case message of
    Name name ->
      ( { model | name = name }, Cmd.none )
    Surname surname ->
      ( { model | surname = surname }, Cmd.none )
    Company company ->
      ( { model | company = company }, Cmd.none )
    Email email ->
      ( { model | email = email }, Cmd.none )