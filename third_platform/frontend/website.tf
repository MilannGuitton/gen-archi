# --- Website Section --- #

# ----------------------------------------------------------------- Upload --- #

resource "aws_s3_object" "website_files" {
  for_each    = fileset("${var.static_website_path}/", "**/*.*")
  bucket      = aws_s3_bucket.website.id
  key         = replace(each.value, "${var.static_website_path}/", "")
  source      = "${var.static_website_path}/${each.value}"
  source_hash = filemd5("${var.static_website_path}/${each.value}")
}

resource "aws_s3_object" "index" {
  bucket      = aws_s3_bucket.website.id
  key         = "index.html"
  source      = "${var.static_website_path}/index.html"
  source_hash = filemd5("${var.static_website_path}/index.html")

  content_type = "text/html"

  depends_on = [aws_s3_object.website_files]
}
