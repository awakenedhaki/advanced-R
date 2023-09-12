#' CardDeck Class
#'
#' A class representing a deck of cards.
#'
#' @format An object of class R6Class.
#' @name CardDeck
#'
#' @description
#' The `CardDeck` class represents a deck of cards. It allows you to shuffle the deck,
#' draw cards from it, reshuffle the drawn cards back into the deck, and more.
#'
#' @section Fields:
#' \describe{
#'   \item{\code{cards}}{A data frame representing the cards in the deck (initialized as NA).}
#'   \item{\code{drawn}}{A data frame representing the cards drawn from the deck (initialized as NA).}
#' }
#'
#' @section Methods:
#' The `CardDeck` class provides the following methods:
#' \describe{
#'   \item{\code{initialize(cards)}}{Initialize the deck with a set of cards (data frame).}
#'   \item{\code{shuffle()}}{Shuffle the cards in the deck randomly.}
#'   \item{\code{reshuffle()}}{Put the drawn cards back into the deck and shuffle.}
#'   \item{\code{pop_draw(n)}}{Draw and remove a specified number of cards from the top of the deck.}
#' }
#'
#' @details
#' The `CardDeck` class represents a deck of cards, and you can perform various operations
#' such as shuffling, drawing, and reshuffling cards. It uses data frames to store both the
#' cards in the deck and the cards that have been drawn.
#'
#' @param cards A data frame representing the initial cards in the deck.
#'
#' @seealso
#' Other classes or functions that may be related to card games or simulations.
#'
#' @rdname CardDeck
CardDeck <- R6::R6Class(
  classname = "CardDeck",
  
  public = list(
    cards = NA,
    drawn = NA,
    
    #' Initialize the deck with a set of cards.
    #' 
    #' @param cards A data frame representing the initial cards in the deck.
    initialize = function(cards) {
      self$cards <- cards
      self$drawn <- private$create_empty_data_frame()
      colnames(self$drawn) <- colnames(self$cards)
    },
    
    #' Shuffle the cards in the deck randomly.
    shuffle = function() {
      rearranged_indices <- sample(1:nrow(self$cards))
      self$cards <- self$cards[rearranged_indices, ]
      
      invisible(self)
    },
    
    #' Put the drawn cards back into the deck and shuffle.
    reshuffle = function() {
      self$cards <- rbind(self$cards, self$drawn)
      self$drawn <- private$create_empty_data_frame()
      self$shuffle()
      
      invisible(self)
    },
    
    #' Draw and remove a specified number of cards from the top of the deck.
    #' 
    #' @param n The number of cards to draw and remove.
    #' @return A data frame representing the drawn cards.
    draw = function(n) {
      selected <- self$cards[1:n, ]
      self$cards <- self$cards[-1:n, ]
      
      self$drawn <- rbind(self$drawn, selected)
      
      return(selected)
    }
  ),
  
  private = list(
    create_empty_data_frame = function() {
      data.frame(matrix(nrow = 0, ncol = length(self$cards)))
    }
  )
)
