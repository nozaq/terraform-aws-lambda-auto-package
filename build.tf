#---------------------------------------------------------------------------------------------------
# Build and package the source archive.
#---------------------------------------------------------------------------------------------------
resource "null_resource" "build" {
  count = var.build_command != "" ? 1 : 0

  triggers = var.build_triggers

  provisioner "local-exec" {
    command = var.build_command
  }
}

data "archive_file" "source" {
  count       = var.source_dir != null ? 1 : 0
  type        = "zip"
  source_dir  = var.source_dir
  excludes    = var.exclude_files
  output_path = var.output_path

  depends_on = [
    null_resource.build
  ]
}
