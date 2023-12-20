library(shiny)

vvApp <- function(...) {

  ui <- fluidPage(
    tags$head(
      tags$link(rel = "preconnect",
                href = "https://fonts.googleapis.com"),
      tags$link(
        rel = "preconnect",
        href = "https://fonts.gstatic.com",
        crossorigin = NULL
      ),
      tags$link(href = "https://fonts.googleapis.com/css2?family=Cutive+Mono&display=swap",
                rel = "stylesheet"),
      tags$style(
        HTML(
          "
          body {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            font-family: 'Cutive Mono', monospace;
          }
          #outputText {
            text-align: center;
            font-size: 1.2em;
            background-color: transparent !important;
            border: none !important;
          }
          #refreshButtonContainer {
            margin-top: 10px;
            text-align: center;
          }
          #refreshButton {
            border: none;
            background-color: transparent;
          }
          "
        )
      ),
    ),
  verbatimTextOutput("outputText"),
  div(id = "refreshButtonContainer",
      actionButton("refreshButton", label = icon("refresh"))
      )
  )

  server <- function(input, output, session) {
    output$outputText <- renderText({
      get_verses(beeton)
    })

    observeEvent(input$refreshButton, {
      session$reload()
    })
  }

  shinyApp(ui, server)
}
