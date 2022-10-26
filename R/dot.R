.helper <- function()
{
  if(is.null(thisfile()))
  {
    getwd()
  } else {
    normalizePath(dirname(thisfile()))
  }
}

#' @rdname dot
#' @export
dot <- function(target)
{
  if (substr(target, 0, 1) %in% c('~', '/')) {
    p <- system2('realpath', c('-m', target), stdout=T)
  } else {
    p <- system2('realpath', c('-m', paste(.helper(), target, sep='/')), stdout=T)
  }
  p
}

#' @rdname dot.source
#' @export
dot.source <- function(fn)
{
  path <- dot(fn)
  if (!file.exists(path)) {
    cat(sprintf('dot.source(%s) file not found\n', path))
    stop()
  }
  source(path)
}


#' @rdname thisfile
#' @export
thisfile_source <- function() {
  for (i in -(1:sys.nframe())) {
    if (identical(args(sys.function(i)), args(base::source)))
      return (normalizePath(sys.frame(i)$ofile))
  }

  NULL
}

#' @rdname thisfile
#' @export
thisfile_rscript <- function() {
  cmd_args <- commandArgs(trailingOnly = FALSE)
  cmd_args_trailing <- commandArgs(trailingOnly = TRUE)
  leading_idx <-
    seq.int(from=1, length.out=length(cmd_args) - length(cmd_args_trailing))
  cmd_args <- cmd_args[leading_idx]
  res <- gsub("^(?:--file=(.*)|.*)$", "\\1", cmd_args)

  # If multiple --file arguments are given, R uses the last one
  res <- tail(res[res != ""], 1)
  if (length(res) > 0)
    return (res)

  NULL
}

