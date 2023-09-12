#' NoOverdraftStrategy Class
#'
#' A class representing a withdrawal strategy that disallows overdrafts.
#'
#' @format An object of class R6Class.
#' @name NoOverdraftStrategy
#'
#' @description
#' The `NoOverdraftStrategy` class represents a withdrawal strategy that disallows overdrafts.
#' It ensures that withdrawals cannot exceed the account balance.
#'
#' @section Methods:
#' The `NoOverdraftStrategy` class provides the following methods:
#' \describe{
#'   \item{\code{withdraw}}{Withdraw funds from the account, disallowing overdrafts.}
#' }
#'
#' @details
#' The `NoOverdraftStrategy` class inherits from the `AbstractWithdrawalStrategy` class
#' and implements a withdrawal strategy that checks for sufficient account balance before allowing withdrawals.
#'
#' @param account An object representing the bank account from which to withdraw funds.
#' @param amount A numeric value representing the amount to withdraw.
#'
#' @seealso
#' Subclasses that implement specific withdrawal strategies based on overdraft policies.
#'
#' @rdname NoOverdraftStrategy
NoOverdraftStrategy <- R6::R6Class(
  classname = "NoOverdraftStrategy",
  
  inherit = AbstractWithdrawalStrategy,
  
  public = list(
    #' Withdraw funds from the account, disallowing overdrafts.
    #' 
    #' @param account An object representing the bank account from which to withdraw funds.
    #' @param amount A numeric value representing the amount to withdraw.
    withdraw = function(account, amount) {
      stopifnot(private$validate_withdrawal_amount(amount))
      
      if (account$balance < amount) {
        stop("Insufficient balance for requested withdrawal amount.")
      }
      
      super$withdraw(account = account, amount = amount)
    }
  )
)
