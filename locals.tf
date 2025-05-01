locals {
    region = try(data.aws_region.this.name, "foo")
}