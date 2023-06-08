data "azurerm_client_config" "current" {}

module "resource_group" {    
  source    = "../modules/resource_group"
  rg_name   = var.rg_name
  location  = var.location  
  tags      = var.tags
}

module "key_vault" {    
  source    = "../modules/key_vault"
  depends_on = [ module.resource_group ]
  kv_name   = var.kv_name
  rg_name   = var.rg_name
  location  = var.location  
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id
}


module "kubernetes_cluster" {    
  source    = "../modules/kubernetes_cluster"
  depends_on = [ module.resource_group ]
  rg_name   = var.rg_name
  location  = var.location  
}

module "cosmos_db" {    
  source    = "../modules/cosmos_db"
  depends_on = [ module.key_vault ]
  rg_name   = var.rg_name
  location  = var.location  
}








