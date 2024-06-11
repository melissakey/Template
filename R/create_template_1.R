# This function showcases how one might write a function to be used as an
# RStudio project template. This function will be called when the user invokes
# the New Project wizard using the project template defined in the template file
# at:
#
#   inst/rstudio/templates/project/create_project.dcf
#
# The function copies the files in inst/template_directory/ into the new project directory.
create_template_1 <- function(path, ...) {

  # ensure path exists
  dir.create(path, recursive = TRUE, showWarnings = FALSE)


  inputs <- list(...)


  # If no template is selected, we are done.
  if(inputs$template == "None") return()

  # If there is a template selected, we need turn a "text-based/human readable" description into a path to a template directory
  # Select template directory

  template <- switch(inputs$template,
    "Default" = "default",
    "Custom text" = "custom_template1"  # add additional options here as needed
  )

  original_file_path <- paste0(.libPaths(), "/Template/templates/", template)

  files <- list.files(paste0(original_file_path, "/"), include.dirs = TRUE, full.names = TRUE, no.. = TRUE)
  file.copy(from = files, to = path, recursive = TRUE, copy.date = FALSE, copy.mode = FALSE)

  ## Code for troubleshooting

  if(inputs$verbose) {
    contents <- paste(
      "Template Selected",
      template,
      "\nTemplate Directory",
      original_file_path,
      "\nFile List:",
      paste(files, collapse = "\n"),
      "\nDestination:",
      file.path(path),
      sep = "\n"
    )

    writeLines(contents, con = file.path(path, "INDEX"))
  }

}
