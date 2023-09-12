#' FrenchCardDeckFactory Class
#'
#' A class representing a factory for creating French card decks.
#'
#' @format An object of class R6Class.
#' @name FrenchCardDeckFactory
#'
#' @description
#' The `FrenchCardDeckFactory` class serves as a factory for creating French card decks.
#' It inherits from the abstract `AbstractCardDeckFactory` class and provides a concrete
#' implementation of the `createDeck` method to create French card decks.
#'
#' @section Fields:
#' \describe{
#'   \item{\code{SUIT}}{A character vector representing the suits in a French card deck.}
#'   \item{\code{VALUE}}{A character vector representing the card values in a French card deck.}
#' }
#'
#' @section Methods:
#' The `FrenchCardDeckFactory` class provides the following public method:
#' \describe{
#'   \item{\code{createDeck()}}{Create a new French card deck instance.}
#' }
#'
#' @details
#' The `FrenchCardDeckFactory` class allows you to create French card decks with 4 suits
#' (♠, ♥, ♦, ♣) and 13 card values (A, 2-10, J, Q, K).
#'
#' The `createDeck` method in this class generates a French card deck and returns it as an instance
#' of the `CardDeck` class.
#'
#' @seealso
#' The `CardDeck` class for representing decks of cards.
#'
#' @inheritParams AbstractCardDeckFactory
#'
#' @rdname FrenchCardDeckFactory
FrenchCardDeckFactory <- R6::R6Class(
  classname = "FrenchCardDeckFactory",
  inherit = AbstractCardDeckFactory,
  
  public = list(
    SUIT = c("♠", "♥", "♦", "♣"),
    VALUE = c("A", 2:10, "J", "Q", "K"),
    
    createDeck = function() {
      deck <- expand.grid(self$SUIT, self$VALUE)
      return(CardDeck$new(cards = deck))
    }
  )
)
