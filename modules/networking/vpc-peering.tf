
resource "aws_vpc_peering_connection" "just_peer" {
  
  vpc_id        = module.my-internet-vpc.vpc_id
  peer_vpc_id   = module.my-intranet-vpc.vpc_id
  
  auto_accept   =  true


 tags = {

     Name   =   "just_peer"


 }  
  # depends_on =   [aws_vpc.vpc-dev-internet]


}
