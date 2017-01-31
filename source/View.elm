module View exposing (banner, contacts, footer, header, about, eventDescription)

import Html exposing (Html, a, div, img, hr, h2, h3, h4, h5, span, section,  text, p)
import Html.Attributes exposing (class, id, src, href, style, attribute)

import Shared exposing (Model)
import Content exposing (..)
import Header

twelveColumns = "col-xs-12 col-sm-12 col-md-12 col-lg-12"


banner : Html msg
banner =
  section [ id "home", class "row banner" ]
    [ h2 [] [ text "Malta JS" ]
      , h3 [] [ text "Javascript community in Malta" ]
      , p [] [ text "Talks, meetups, coding sessions, ..." ]
    ]


footer : Html msg
footer = 
  Html.footer [ class "footer" ]
    [ div [ class twelveColumns ]
      [ div [ class "leftSide" ]
        [ p [] [ text "Copyright Ⓒ MaltaJs 2017 All Rights Reserved" ] ]
      , div [ class "rightSide" ] []
      ]
    ]


header : Bool -> Maybe Int -> (Bool -> msg) -> Html msg
header headerCollapsed active onNavigation  =
  let
    brand = Header.buildItem "MaltaJS" [ "brand" ]
    logo =
      Header.buildLogo
        (img [ src "images/logo.jpg" ] []) [ "header-logo" ]
    links = []
      {--
        List.map 
            (\(title, url) -> Header.buildActiveItem title url [])
            [ ("Past events", "/") ]
            --}
    config : Header.Config msg
    config = Header.Config (Just logo) (Just brand) links (Just onNavigation)
  in
    Header.view config headerCollapsed active


about : Model -> Html msg
about model =
  section [ id "about", class "row about" ]
    [ div [ class twelveColumns ]
      [ h4 [] [ text "About" ] ]
    , div [ class twelveColumns ]
      [ Content.aboutView ]
    ]

type alias Schedule =
  { start: String
  , end: String
  , title: String
  }
type alias ExtendedSchedule =
  { start: String
  , end: String
  , title: String
  , name: String
  , description: String 
  , links: List (String, String)
  }

type alias Organizer =
  { name : String
  , email : String
  }

viewOrganizer : Organizer -> Html msg
viewOrganizer organizer =
  div [ class "col-xs-12 col-sm-6 col-md-6 col-lg-6" ]
    [ div [ class "organizer" ]
      [ div [ class "name" ]
        [ text organizer.name ]
      , div [ class "position" ]
        [ text "Event Organizer" ]
      , div []
        [ span [ class "glyphicon glyphicon-envelope" ]
          []
        , p [ class "email" ]
          [ text organizer.email ]
        ]
      ]
    ]

renderSchedule : Schedule -> Html msg
renderSchedule schedule =
  div [ class "row scheduleRow" ]
    [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 eventTitle eventBackground" ]
      [ timeSpan schedule.start schedule.end
      , div [ class "col-xs-8 col-sm-8 col-md-8 col-lg-8 textCenter" ]
        [ text schedule.title ]
      ]
    ]

contacts : Html msg
contacts =
  section [ class "row contact", id "contact" ]
    [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12" ]
      [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 textCenter" ]
        [ h4 []
          [ text "Contact" ]
        ]
      , viewOrganizer (Organizer "Andrei Toma" "andrei@maltajs.com")
      , viewOrganizer (Organizer "Bogdan Dumitru" "bogdan@maltajs.com")
      , viewOrganizer (Organizer "Pietro Grandi" "pietro@maltajs.com")
      , viewOrganizer (Organizer "Contact" "contact@maltajs.com")
      ]
    ]

timeSpan : String -> String -> Html msg
timeSpan start end =
  div [ class "col-xs-4 col-sm-2 col-md-2 col-lg-2 eventTimeHolder" ]
    [ span []
      [ text start ]
    , span []
      [ text "-" ]
    , span []
      [ text end ]
    ]


renderExtendedSchedule : ExtendedSchedule -> Html msg
renderExtendedSchedule schedule =
  div [ class "row scheduleRow" ]
    [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 eventTitle" ]
      [ timeSpan schedule.start schedule.end
      , div [ class "col-xs-8 col-sm-10 col-md-10 col-lg-10 eventLine" ]
        [ hr [] [] ]
      ]
    , div [ class "col-xs-12 col-sm-9 col-md-9 col-lg-9 col-sm-offset-3 col-md-offset-3 col-lg-offset-3 eventSpeaker" ]
      [ div
      -- speaker's image
        [ class "speakerImg", attribute "style" "background-image: url(\"/images/speakers/pietro_grandi.jpg\");" ]
        []
      , h5 []
        [ span []
          [ text schedule.title ]
        , span [ class "compute" ]
          [ text "with " ]
        , span []
          [ text schedule.name ]
        ]
      , p []
        [ text schedule.description ]
        -- links (type, link)
        {--
      , a [ class "linkedin" ]
        []
      , a [ class "website", href "http://pietrograndi.com" ]
        []
        ]--}
      ]
    ]



--eventDescription : Html msg
eventDescription =
  section [ class "row schedule", id "schedule" ]

    [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 textCenter" ]
      [ h4 []
        [ text "Schedule" ]
      ]

    , div []
      [ renderSchedule (Schedule "19:00" "19:15" "WELCOME COFFEE & REGISTRATION")

      , renderSchedule (Schedule "19:15" "19:30" "Welcome speech")

      , renderExtendedSchedule
        (ExtendedSchedule
          "19:30" "20:15"
          "Webpack stuff"
          "Peter Bakonyi"
          "Bundling the frontend: wtf is it a mess and I have no idea how to do it. I hope Peter will handle it. Thank you."
          []
        )
      , renderSchedule (Schedule "20:30" "21:00" "Networking")
      ]
    ]
