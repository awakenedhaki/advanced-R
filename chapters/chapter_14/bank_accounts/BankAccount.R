#' BankAccount Class
#'
#' A class representing a basic bank account with balance and withdrawal strategy.
#'
#' @format An object of class R6Class.
#' @name BankAccount
#' @field balance A numeric value representing the account balance.
#' @field fees A numeric value representing fees associated with the account.
#' @field withdrawal_strategy An object representing the withdrawal strategy.
#'
#' @description
#' The `BankAccount` class represents a basic bank account with a balance and withdrawal strategy.
#' You can initialize an account with an initial balance and set a withdrawal strategy. It allows you to
#' withdraw, deposit, and change the withdrawal strategy as needed.
#'
#' @section Fields:
#' \describe{
#'   \item{\code{balance}}{A numeric value representing the account balance.}
#'   \item{\code{fees}}{A numeric value representing fees associated with the account.}
#'   \item{\code{withdrawal_strategy}}{An object representing the withdrawal strategy.}
#' }
#'
#' @section Methods:
#' The `BankAccount` class provides the following methods:
#' \describe{
#'   \item{\code{initialize}}{Initialize a new bank account with an initial balance and withdrawal strategy.}
#'   \item{\code{withdraw}}{Withdraw funds from the account using the assigned withdrawal strategy.}
#'   \item{\code{deposit}}{Deposit funds into the account.}
#'   \item{\code{set_withdrawal_strategy}}{Set the withdrawal strategy for the account.}
#' }
#'
#' @examples
#' # Create a bank account with an initial balance of $100 and no withdrawal strategy.
#' my_account <- BankAccount$new(initial_balance = 100)
#' 
#' # Set a withdrawal strategy for the account.
#' strategy <- NoOverdraftStrategy$new()
#' my_account$set_withdrawal_strategy(strategy)
#' 
#' # Withdraw funds using the assigned strategy.
#' my_account$withdraw(50)
#' 
#' # Deposit funds into the account.
#' my_account$deposit(200)
#'
#' @seealso
#' Other classes that may be relevant:
#' \code{\link{NoOverdraftStrategy}}
#'
#' @rdname BankAccount
BankAccount <- R6::R6Class(
  classname = "BankAccount",
  
  public = list(
    balance = NA_real_,
    fees = NA_real_,
    withdrawal_strategy = NULL,
    
    #' Initialize a new bank account with an initial balance and withdrawal strategy.
    #' 
    #' @param initial_balance A numeric value representing the initial account balance.
    #' @param withdrawal_strategy An object representing the withdrawal strategy (optional).
    initialize = function(initial_balance = double(), withdrawal_strategy) {
      self$balance <- initial_balance
      self$withdrawal_strategy <- withdrawal_strategy
      self$fees <- double()
    },
    
    #' Withdraw funds from the account using the assigned withdrawal strategy.
    #' 
    #' @param amount A numeric value representing the amount to withdraw.
    withdraw = function(amount = double()) {
      self$withdrawal_strategy$withdraw(self, amount)
    },
    
    #' Deposit funds into the account.
    #' 
    #' @param amount A numeric value representing the amount to deposit.
    deposit = function(amount = double()) {
      self$balance <- self$balance + amount
    },
    
    #' Set the withdrawal strategy for the account.
    #' 
    #' @param strategy An object representing the withdrawal strategy.
    set_withdrawal_strategy = function(strategy) {
      self$withdrawal_strategy <- strategy
    }
  ),
  
  private = list(
    validate_deposit_amount = function(amount) {
      is.double(amount) && amount > 0
    }
  )
)
