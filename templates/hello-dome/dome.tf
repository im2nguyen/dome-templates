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

resource "dome_gateway" "hello" {
  workspace_id    = var.workspace_id
  name            = "hello-dome"
  description     = "Gateway for the Hello Dome template"
  is_default      = true
  safe_tool_names = true
}

resource "dome_llm_connection" "haiku" {
  workspace_id        = var.workspace_id
  name                = "hello-dome-haiku"
  provider_id         = "anthropic"
  provider_config     = jsonencode({ model = "claude-haiku-4-5-20251001" })
  auth_method         = "api-key"
  credential_type     = "shared"
  managed_header_name = "x-api-key"
  secret_values       = { "x-api-key" = var.anthropic_api_key }
}

resource "dome_llm_pool" "hello" {
  workspace_id = var.workspace_id
  name         = "hello-dome-pool"
  is_default   = true
}

resource "dome_llm_pool_member" "haiku" {
  workspace_id   = var.workspace_id
  pool           = dome_llm_pool.hello.name
  llm_connection = dome_llm_connection.haiku.name
}

resource "dome_gateway_llm_pool" "hello" {
  workspace_id = var.workspace_id
  gateway      = dome_gateway.hello.name
  llm_pool     = dome_llm_pool.hello.name
}

resource "dome_agent" "hello" {
  workspace_id     = var.workspace_id
  name             = "hello-dome"
  allowed_gateways = [dome_gateway.hello.name]
}

resource "dome_agent_key" "runtime" {
  workspace_id = var.workspace_id
  agent        = dome_agent.hello.name
  name         = "runtime"
}

output "hello_dome_token" {
  value     = dome_agent_key.runtime.token
  sensitive = true
}
