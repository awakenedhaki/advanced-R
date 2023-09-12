#' AuthorizedOverdraftStrategy Class
#'
#' A class representing an authorized overdraft strategy.
#'
#' @format An object of class R6Class.
#' @name AuthorizedOverdraftStrategy
#'
#' @description
#' The `AuthorizedOverdraftStrategy` class represents an authorized overdraft strategy.
#' It extends the overdraft strategy and handles overdrafts within an authorized limit by applying fees
#' and adjusting the account balance accordingly.
#'
#' @section Fields:
#' \describe{
#'   \item{\code{authorized_limit}}{A numeric value representing the authorized overdraft limit for the strategy.}
#' }
#'
#' @section Methods:
#' The `AuthorizedOverdraftStrategy` class provides the following methods:
#' \describe{
#'   \item{\code{initialize}}{Initialize the authorized overdraft strategy with a fee and authorized limit.}
#'   \item{\code{withdraw}}{Withdraw funds from the account, handling authorized overdrafts.}
#' }
#'
#' @details
#' The `AuthorizedOverdraftStrategy` class inherits from the `AbstractOverdraftStrategy` class
#' and implements a withdrawal strategy that handles overdrafts within an authorized limit by applying fees
#' and adjusting the account balance accordingly.
#'
#' @param fee A numeric value representing the overdraft fee for the strategy.
#' @param authorized_limit An integer representing the maximum authorized overdraft limit.
#'
#' @seealso
#' Other classes that implement specific overdraft strategies based on different policies.
#'
#' @rdname AuthorizedOverdraftStrategy
AuthorizedOverdraftStrategy <- R6::R6Class(
  classname = "AuthorizedOverdraftStrategy",
  
  inherit = AbstractOverdraftStrategy,
  
  public = list(
    authorized_limit = NA_real_,
    
    #' Initialize the authorized overdraft strategy with a fee and authorized limit.
    #' 
    #' @param fee A numeric value representing the overdraft fee for the strategy.
    #' @param authorized_limit An numeric representing the maximum authorized overdraft limit.
    initialize = function(fee = double(), authorized_limit = doublt()) {
      super$initialize(fee = fee)
      self$authorized_limit = authorized_limit
    },
    
    #' Withdraw funds from the account, handling authorized overdrafts.
    #' 
    #' @param account An object representing the bank account from which to withdraw funds.
    #' @param amount A numeric value representing the amount to withdraw.
    withdraw = function(account, amount = double()) {
      super$withdraw(account = account, amount = amount, callback = private$authorized_overdraft)
    }
  ),
  
  private = list(
    authorized_overdraft = function(account, remaining_balance) {
      if (abs(remaining_balance) > self$authorized_limit) {
        stop("Amount exceeds available balance + authorized overdraft limit.")
      } else {
        account$balance <- remaining_balance
        private$incur_overdraft_fee(account)
      }
    }
  )
)
