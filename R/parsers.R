cosmic_signatures_dataframe <- function(){
  read.csv(system.file("COSMIC_v3.3.1_SBS_GRCh38.tidy.csv", package = "tidysigs"))
}

#' Cosmic Signatures
#'
#' @return signature dataframe
#'
#' @export
#'
#' @examples
#' cosmic_signatures_list()
tidysig_cosmic_signatures <- function(){
  df_cosmic = cosmic_signatures_dataframe()

  ls_cosmic = split(df_cosmic, df_cosmic[["identifier"]])

  return(ls_cosmic)
}


check_sig_df <- function(x){
  if(!is.data.frame(x)){
    return(paste0('Not a valid signature dataframe. Must be a dataframe not a ', class(x)))
  }

  colname = colnames(x)
  required_cols = c('channel', 'percentage', 'type')

  if(!all(required_cols %in% colname)){
    return(paste0("Not a valid signature dataframe. Missing Columns: ", paste0(required_cols[!required_cols %in% colname], collapse = ", ")))
  }

}

#' Assert Signature Dataframe
#'
#' @return signature dataframe
#'
#'
assert_signature_dataframe <- assertions::assert_create(check_sig_df)

