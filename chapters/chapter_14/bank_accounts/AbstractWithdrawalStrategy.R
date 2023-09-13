#' AbstractWithdrawalStrategy Class
#'
#' A class representing an abstract withdrawal strategy.
#'
#' @format An object of class R6Class.
#' @name AbstractWithdrawalStrategy
#'
#' @description
#' The `AbstractWithdrawalStrategy` class represents an abstract withdrawal strategy.
#' It provides a basic framework for implementing custom withdrawal strategies for bank accounts.
#' Subclasses can inherit from this abstract class and implement their specific withdrawal logic.
#'
#' @section Methods:
#' The `AbstractWithdrawalStrategy` class provides the following methods:
#' \describe{
#'   \item{\code{withdraw}}{Withdraw funds from the account using the strategy's logic.}
#' }
#'
#' @details
#' The `AbstractWithdrawalStrategy` class defines the basic structure for withdrawal strategies.
#' Subclasses should implement the `withdraw` method according to their specific logic.
#'
#' @param account An object representing the bank account from which to withdraw funds.
#' @param amount A numeric value representing the amount to withdraw.
#' @param callback A callback function (optional) to handle overdraft situations.
#'
#' @seealso
#' Subclasses that implement specific withdrawal strategies should inherit from this class.
#'
#' @rdname AbstractWithdrawalStrategy
AbstractWithdrawalStrategy <- R6::R6Class(
  classname = "AbstractWithdrawalStrategy",
  
  public = list(
    #' Withdraw funds from the account using the strategy's logic.
    #' 
    #' @param account An object representing the bank account from which to withdraw funds.
    #' @param amount A numeric value representing the amount to withdraw.
    #' @param callback A callback function (optional) to handle overdraft situations.
    withdraw = function(account, amount = double(), callback = NULL) {
      stopifnot(private$validate_withdrawal_amount(amount))
      
      remaining_balance <- account$balance - amount
      if (remaining_balance >= 0) {
        account$balance <- remaining_balance
      } else if (!is.null(callback)) {
        callback(account, remaining_balance)
      } else {
        cat("Withdrawal was not completed. Balance remains intact.")
      }
    }
  ),
  
  private = list(
    validate_withdrawal_amount = function(amount) {
      is.double(amount) && amount > 0
    }
  )
)
