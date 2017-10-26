library(rfigshare)

update_fs_article <-
  function(fs.id,
           zip.name,
           files.to.ignore,
           publish = FALSE) {
    files_to_zip <- list.files()
    files_to_zip <- setdiff(files_to_zip, files.to.ignore)
    
    my_deposit <- fs_details(fs.id)
    my_files <- data.frame(t(sapply(my_deposit$files, `[`)))
    
    # delete current files
    
    lapply(unlist(my_files$id), function(id) {
      fs_delete(fs.id, id)
    })
    
    # make new zip
    zip(zip.name, files_to_zip)
    fs_upload(fs.id, zip.name)
    
    if (publish == TRUE) {
      fs_make_public(fs.id)
    }
    unlink(zip.name)
  }

update_fs_article(
  5217316,
  "Preferences_for_truth-telling_visualisations.zip",
  files.to.ignore = c(
    "rsconnect",
    ".httr-oauth",
    "deposit-on-figshare.R",
    "economy_preferences_for_truth_telling.Rproj",
    "Meeting-Notes.Rmd",
    "requirements"
  )
)


