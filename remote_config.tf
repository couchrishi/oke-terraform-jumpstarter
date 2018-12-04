terraform {
  backend "http" {
    update_method = "PUT"
    address       = "https://objectstorage.us-ashburn-1.oraclecloud.com/p/IRE1FqRLa6tXQw2xqrNcIGikCd0wu7JcLBKN_7yC77g/n/gse00014373/b/remotetfstate/o/terraform.tfstate"
    skip_cert_verification = "true"
  }
}