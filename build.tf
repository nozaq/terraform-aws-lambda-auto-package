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

# Trick to run the build command before archiving.
# See below for more detail.
# https://github.com/terraform-providers/terraform-provider-archive/issues/11
data "null_data_source" "build_dep" {
  inputs = {
    build_id   = length(null_resource.build) > 0 ? null_resource.build[0].id : ""
    source_dir = var.source_dir
  }
}

data "archive_file" "source" {
  type        = "zip"
  source_dir  = data.null_data_source.build_dep.outputs.source_dir
  output_path = var.output_path
}
