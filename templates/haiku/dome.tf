terraform {
  required_providers {
    dome = { source = "dome-systems/dome", version = ">= 0.1.0" }
  }
}

variable "workspace_id" { type = string }

variable "anthropic_api_key" {
  type      = string
  sensitive = true
}

resource "dome_gateway" "haiku" {
  workspace_id = var.workspace_id
  name         = "motivational-haiku"
  description  = "Gateway for the Motivational Haiku template"
  is_default   = true
}

resource "dome_llm_connection" "haiku" {
  workspace_id        = var.workspace_id
  name                = "motivational-haiku-haiku"
  provider_id         = "anthropic"
  provider_config     = jsonencode({ model = "claude-haiku-4-5-20251001" })
  auth_method         = "api-key"
  credential_type     = "shared"
  managed_header_name = "x-api-key"
  secret_values       = { "x-api-key" = var.anthropic_api_key }
}

resource "dome_llm_pool" "haiku" {
  workspace_id = var.workspace_id
  name         = "motivational-haiku-pool"
  is_default   = true
}

resource "dome_llm_pool_member" "haiku" {
  workspace_id   = var.workspace_id
  pool           = dome_llm_pool.haiku.name
  llm_connection = dome_llm_connection.haiku.name
}

resource "dome_gateway_llm_pool" "haiku" {
  workspace_id = var.workspace_id
  gateway      = dome_gateway.haiku.name
  llm_pool     = dome_llm_pool.haiku.name
}

resource "dome_agent" "haiku" {
  workspace_id     = var.workspace_id
  name             = "motivational-haiku"
  allowed_gateways = [dome_gateway.haiku.name]
}

resource "dome_agent_key" "runtime" {
  workspace_id = var.workspace_id
  agent        = dome_agent.haiku.name
  name         = "runtime"
}

output "motivational_haiku_token" {
  value     = dome_agent_key.runtime.token
  sensitive = true
}
