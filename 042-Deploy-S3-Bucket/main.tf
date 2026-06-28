
resource "aws_s3_bucket" "lab11-s3-bucket" {
    bucket = var.bucket_name
    acl = "private"
    region = var.aws_region 

    tags {
        Env = "${lookup(var.bucket_tags, "environment")}"
    }
}