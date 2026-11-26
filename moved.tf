moved {
  from = aws_vpc.main
  to   = module.networking.aws_vpc.main
}

moved {
  from = aws_subnet.public
  to   = module.networking.aws_subnet.public
}

moved {
  from = aws_subnet.private
  to   = module.networking.aws_subnet.private
}

moved {
  from = aws_internet_gateway.main
  to   = module.networking.aws_internet_gateway.main
}

moved {
  from = aws_route_table.public
  to   = module.networking.aws_route_table.public
}

moved {
  from = aws_route_table.private
  to   = module.networking.aws_route_table.private
}

moved {
  from = aws_route_table_association.public
  to   = module.networking.aws_route_table_association.public
}

moved {
  from = aws_route_table_association.private
  to   = module.networking.aws_route_table_association.private
}

moved {
  from = aws_security_group.web
  to   = module.security.aws_security_group.web
}

moved {
  from = aws_key_pair.resume
  to   = module.security.aws_key_pair.resume
}

moved {
  from = aws_instance.resume
  to   = module.compute.aws_instance.resume
}

moved {
  from = aws_s3_bucket.resume_storage
  to   = module.storage.aws_s3_bucket.resume_storage
}

moved {
  from = aws_s3_bucket_public_access_block.resume_storage_security
  to   = module.storage.aws_s3_bucket_public_access_block.resume_storage_security
}
