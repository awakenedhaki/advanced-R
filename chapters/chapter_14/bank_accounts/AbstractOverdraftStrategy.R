#' AbstractOverdraftStrategy Class
#'
#' A class representing an abstract overdraft strategy.
#'
#' @format An object of class R6Class.
#' @name AbstractOverdraftStrategy
#'
#' @description
#' The `AbstractOverdraftStrategy` class represents an abstract overdraft strategy.
#' It extends the basic withdrawal strategy and introduces overdraft fees.
#'
#' @section Fields:
#' \describe{
#'   \item{\code{fee}}{A numeric value representing the overdraft fee associated with the strategy (initialized as NA).}
#' }
#'
#' @section Methods:
#' The `AbstractOverdraftStrategy` class provides the following methods:
#' \describe{
#'   \item{\code{initialize}}{Initialize the overdraft strategy with an overdraft fee.}
#' }
#'
#' @details
#' The `AbstractOverdraftStrategy` class inherits from the `AbstractWithdrawalStrategy` class
#' and adds functionality for tracking overdraft fees associated with the strategy.
#'
#' @param fee A numeric value representing the overdraft fee for the strategy.
#'
#' @seealso
#' Subclasses that implement specific overdraft strategies based on different fee policies.
#'
#' @rdname AbstractOverdraftStrategy
AbstractOverdraftStrategy <- R6::R6Class(
  classname = "AbstractOverdraftStrategy",
  
  inherit = AbstractWithdrawalStrategy,
  
  public = list(
    fee = NA_real_,
    
    #' Initialize the overdraft strategy with an overdraft fee.
    #' 
    #' @param fee A numeric value representing the overdraft fee for the strategy.
    initialize = function(fee = double()) {
      self$fee = fee
    }
  ),
  
  private = list(
    incur_overdraft_fee = function(account) {
      if (is.na(account$fees["overdraft"])) {
        account$fees["overdraft"] <- self$fee
      } else {
        account$fees["overdraft"] <- account$fees["overdraft"] + self$fee
      }
    }
  )
)