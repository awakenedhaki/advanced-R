#' AbstractCardDeckFactory Class
#'
#' This is an abstract base class for card deck factory implementations. Subclasses should inherit
#' from this class and provide concrete implementations for creating specific types of card decks.
#' 
#' @format
#' An R6 class with public methods.
#'
#' @section Methods:
#' \describe{
#'   \item{createDeck}{Create a new card deck instance. Subclasses should override this method
#'   to provide specific deck implementations.}
#' }
#'
#' @inheritParams R6Class
#' @export
AbstractCardDeckFactory <- R6::R6Class(
  classname = "AbstractCardDeckFactory",
  
  public = list(
    createDeck = function() {
      stop("The `createDeck` function is not implemented.")
    }
  )
)