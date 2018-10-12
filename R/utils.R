
#' Tidy a matrix returned by deSolve
#' @noRd
tidy_fn <- function(mat, col_names) {

  out <- as.data.frame(mat)
  names(out) <- col_names

  return(out)
}


#' Simple version of tidyr::gather
#' @noRd
gather_fn <- function(df, key, value, cols, key_levs) {
  out <- do.call(
    rbind.data.frame,
    replicate(length(cols), df[-cols], simplify = FALSE)
  )

  out[[key]] <- rep(names(df)[cols], each = nrow(df))
  out[[key]] <- factor(out[[key]], levels = key_levs)
  out[[value]] <- as.numeric(unlist(df[cols]))

  return(out)
}

