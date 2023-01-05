# --- Website Section --- #

# ----------------------------------------------------------------- Upload --- #


resource "aws_s3_object" "website_files" {
  for_each = fileset("${var.static_website_path}/", "**/*.*")
  bucket   = aws_s3_bucket.website.id
  key      = replace(each.value, "${var.static_website_path}/", "")
  source   = "${var.static_website_path}/${each.value}"
  etag     = filemd5("${var.static_website_path}/${each.value}")
}
