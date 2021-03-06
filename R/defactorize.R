#' @title Defactorize
#'
#' @description The function attempts to change vector
#'   \code{\link[base]{class}} from \code{\link[base]{factor}} to
#'   \code{\link[base]{integer}}, \code{\link[base]{double}} or
#'   \code{\link[base]{character}}.
#'
#' @details The function tries to handle factors of unknown content by
#'   attempting to apply different classes and looking for warnings.
#'
#' @section Warning:
#' The function disregards \code{\link[base]{levels}} information available in
#'   vectors of the \code{\link[base]{factor}} class.
#'
#' @param x A factor.
#'
#' @return A vector of equivalent length of class numeric, integer or
#'   character.
#'
#' @importFrom checkmate assert_class assert_vector
#' @export
#'
#' @examples
#' defactorize(as.factor(c("a", "b")))
#' defactorize(as.factor(c("a", "b", runif(n = 10))))
#'
defactorize <- function(x) {
    # Check if provided variable is a factor vector
    assert_class(x = x,
                 classes = "factor",
                 null.ok = FALSE)
    assert_vector(x = x,
                  all.missing = FALSE,
                  null.ok = FALSE)

    # Guess vector content using provided Rcpp function
    vector_contet <- guess_vector_type(x = x)

    # Convert
    res <- switch(EXPR = vector_contet,
                  character = as.character(x),
                  double = as.numeric(x),
                  integer = as.integer(x))

    # Return resuls
    return(res)
}
