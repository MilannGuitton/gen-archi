# --- Website Section --- #

# ----------------------------------------------------------------- Upload --- #
#
locals {
  folder_files = flatten([for d in flatten(fileset("${path.module}/${var.static_website_path}/*", "*")) : trim(d, "../")])
}

resource "aws_s3_object" "websitefiles" {
  for_each = { for idx, file in local.folder_files : idx => file }
  bucket   = aws_s3_bucket.website.id

  key    = "/${var.static_website_path}/${each.value}"
  source = "${path.module}/${var.static_website_path}/${each.value}"
  etag   = "${path.module}/${var.static_website_path}/${each.value}"
}
