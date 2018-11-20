terraform {
  backend "http" {
    update_method = "PUT"
    address       = "https://objectstorage.us-ashburn-1.oraclecloud.com/p/BzWpUzUkJ51A35VmeauLzYPiotok1CRDyMDtl9u07Is/n/gse00014954/b/smartoffers-test/o/"
  }
}