provider "azurerm" {
    subscription_id = local.subscription_id
    # version         = "~> 2.0"
    features {}
}

resource "azurerm_resource_group" "this" {
    name = "${local.service_name}-rg"
    location = local.region
}

resource "azurerm_app_service_plan" "this" {
    name = "${local.service_name}-asp"
    location = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name
    kind = "app"

    sku {
        size = "B1"
        tier = "Basic"
    }
}

resource "azurerm_app_service" "this" {
    name = "${local.service_name}-as"
    location = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name
    app_service_plan_id  = azurerm_app_service_plan.this.id
}

