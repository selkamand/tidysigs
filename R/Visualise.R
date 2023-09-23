#Combine Visualisation

tidysig_combine_signatures <- function(signature_set, signature_contributions = c("SBS10a" = 0.8, "SBS10b" = 0.2)){
  assertions::assert_names_include(signature_set, names(signature_contributions))

  ls_signatures = purrr::map2(names(signature_contributions), signature_contributions, \(signame, sigcont){

      d = signature_set[[signame]]
      d[["percentage_original"]] = d[["percentage"]]
      d[["percentage_cont"]] = sigcont
      d[["percentage"]] = d[["percentage"]] * sigcont
      return(d)
    })

  df_signatures = do.call("rbind", ls_signatures)
  return(df_signatures)
}


plot_signatures <- function(df_signature_set, limit_y = FALSE, interactive = FALSE){
  df_signature_set[["channel"]] <- forcats::fct_relevel(df_signature_set[["channel"]], levels_snv())

  df_signature_set

  #print(sum(df_signature_set[["percentage"]]))

  ggplot2::ggplot(df_signature_set, ggplot2::aes(x = channel, y = percentage, fill = type, group = identifier)) +
  ggplot2::scale_y_continuous(
    expand = c(0.05, 0),
    limits = if(limit_y) { c(0, 1) } else NULL,
    labels = scales::percent_format()
  ) +
  #ggplot2::scale_x_() +
  ggplot2::facet_wrap(facets = "type", nrow = 1, scales = "free_x") +
  ggiraph::geom_col_interactive(color = "black", linewidth = 0.2, width = 0.7, ggplot2::aes(data_id=identifier, tooltip = identifier)) +
  ggplot2::xlab(NULL) +
  ggplot2::ylab("Percentage") +
  ggplot2::theme_bw() +
  ggplot2::theme(
    axis.text.x = ggplot2::element_text(angle = 90, size = 6),
    panel.grid.major.x = ggplot2::element_blank()
  ) +
  ggplot2::scale_fill_manual(values = palette_snv_type())
}


palette_snv_type = function(){
  c(
    "[C>A]" = "#16AFE9",
    "[C>G]" = "black",
    "[C>T]" = "#D9111E",
    "[T>A]" = "#C1BDBE",
    "[T>C]"= "#92C446",
    "[T>G]" = "#E6B8B9"
  )
}

levels_snv_type = function(){
  c("[C>A]", "[C>G]", "[C>T]", "[T>A]", "[T>C]", "[T>G]")
}

levels_snv = function(){
  # Create a character vector with the mutation signature analysis decomposition channels
  mutation_channels <- c(
    "A[C>A]A", "A[C>A]C", "A[C>A]G", "A[C>A]T", "C[C>A]A", "C[C>A]C", "C[C>A]G", "C[C>A]T",
    "G[C>A]A", "G[C>A]C", "G[C>A]G", "G[C>A]T", "T[C>A]A", "T[C>A]C", "T[C>A]G", "T[C>A]T",

    "A[C>G]A", "A[C>G]C", "A[C>G]G", "A[C>G]T", "C[C>G]A", "C[C>G]C", "C[C>G]G", "C[C>G]T",
    "G[C>G]A", "G[C>G]C", "G[C>G]G", "G[C>G]T", "T[C>G]A", "T[C>G]C", "T[C>G]G", "T[C>G]T",

    "A[C>T]A", "A[C>T]C", "A[C>T]G", "A[C>T]T", "C[C>T]A", "C[C>T]C", "C[C>T]G", "C[C>T]T",
    "G[C>T]A", "G[C>T]C", "G[C>T]G", "G[C>T]T", "T[C>T]A", "T[C>T]C", "T[C>T]G", "T[C>T]T",

    "A[T>A]A", "A[T>A]C", "A[T>A]G", "A[T>A]T", "C[T>A]A", "C[T>A]C", "C[T>A]G", "C[T>A]T",
    "G[T>A]A", "G[T>A]C", "G[T>A]G", "G[T>A]T", "T[T>A]A", "T[T>A]C", "T[T>A]G", "T[T>A]T",

    "A[T>C]A", "A[T>C]C", "A[T>C]G", "A[T>C]T", "C[T>C]A", "C[T>C]C", "C[T>C]G", "C[T>C]T",
    "G[T>C]A", "G[T>C]C", "G[T>C]G", "G[T>C]T", "T[T>C]A", "T[T>C]C", "T[T>C]G", "T[T>C]T",

    "A[T>G]A", "A[T>G]C", "A[T>G]G", "A[T>G]T", "C[T>G]A", "C[T>G]C", "C[T>G]G", "C[T>G]T",
    "G[T>G]A", "G[T>G]C", "G[T>G]G", "G[T>G]T"
  )

  return(mutation_channels)
}
