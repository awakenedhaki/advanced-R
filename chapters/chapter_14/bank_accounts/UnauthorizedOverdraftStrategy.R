#' UnauthorizedOverdraftStrategy Class
#'
#' A class representing an unauthorized overdraft strategy.
#'
#' @format An object of class R6Class.
#' @name UnauthorizedOverdraftStrategy
#'
#' @description
#' The `UnauthorizedOverdraftStrategy` class represents an unauthorized overdraft strategy.
#' It extends the overdraft strategy and handles unauthorized overdrafts by applying fees.
#'
#' @section Methods:
#' The `UnauthorizedOverdraftStrategy` class provides the following methods:
#' \describe{
#'   \item{\code{withdraw}}{Withdraw funds from the account, handling unauthorized overdrafts.}
#' }
#'
#' @details
#' The `UnauthorizedOverdraftStrategy` class inherits from the `AbstractOverdraftStrategy` class
#' and implements a withdrawal strategy that handles unauthorized overdrafts by applying fees
#' and adjusting the account balance accordingly.
#'
#' @param account An object representing the bank account from which to withdraw funds.
#' @param amount A numeric value representing the amount to withdraw.
#'
#' @seealso
#' Other classes that implement specific overdraft strategies based on different policies.
#'
#' @rdname UnauthorizedOverdraftStrategy
UnauthorizedOverdraftStrategy <- R6::R6Class(
  classname = "UnauthorizedOverdraftStrategy",
  
  inherit = AbstractOverdraftStrategy,
  
  public = list(
    #' Withdraw funds from the account, handling unauthorized overdrafts.
    #' 
    #' @param account An object representing the bank account from which to withdraw funds.
    #' @param amount A numeric value representing the amount to withdraw.
    withdraw = function(account, amount = double()) {
      super$withdraw(account = account, amount = amount, callback = private$unauthorized_overdraft)
      invisible(self)
    }
  ),
  
  private = list(
    unauthorized_overdraft = function(account, remaining_balance = double()) {
      account$balance <- remaining_balance
      private$incur_overdraft_fee(account)
    }
  )
)
