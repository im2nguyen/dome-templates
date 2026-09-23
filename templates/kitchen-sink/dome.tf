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

resource "dome_gateway" "kitchen_sink" {
  workspace_id        = var.workspace_id
  name                = "kitchen-sink"
  description         = "Gateway created by the kitchen-sink template"
  is_default          = true
}

resource "dome_mcp_connection" "domedocs" {
  workspace_id        = var.workspace_id
  name                = "domedocs"
  protocol            = "streamable-http"
  url                 = "https://docs.domesystems.ai/mcp"
  auth_method         = "none"
}

resource "dome_gateway_tool" "domedocs_search" {
  workspace_id        = var.workspace_id
  gateway             = dome_gateway.kitchen_sink.name
  mcp_connection      = dome_mcp_connection.domedocs.name
  tool                = "search"
}

resource "dome_gateway_tool" "domedocs_get_page" {
  workspace_id        = var.workspace_id
  gateway             = dome_gateway.kitchen_sink.name
  mcp_connection      = dome_mcp_connection.domedocs.name
  tool                = "get_page"
}

resource "dome_gateway_tool" "domedocs_list_pages" {
  workspace_id        = var.workspace_id
  gateway             = dome_gateway.kitchen_sink.name
  mcp_connection      = dome_mcp_connection.domedocs.name
  tool                = "list_pages"
}

resource "dome_llm_connection" "haiku" {
  workspace_id        = var.workspace_id
  name                = "haiku"
  provider_id         = "anthropic"
  provider_config     = jsonencode({ model = "claude-haiku-4-5-20251001" })
  auth_method         = "api-key"
  credential_type     = "shared"
  managed_header_name = "x-api-key"
  secret_values       = { "x-api-key" = var.anthropic_api_key }
}

resource "dome_llm_pool" "kitchen_sink_pool" {
  workspace_id        = var.workspace_id
  name                = "kitchen-sink-pool"
  is_default          = false
}

resource "dome_llm_pool_member" "haiku" {
  workspace_id        = var.workspace_id
  pool                = dome_llm_pool.kitchen_sink_pool.name
  llm_connection      = dome_llm_connection.haiku.name
}

resource "dome_gateway_llm_pool" "kitchen_sink_pool" {
  workspace_id        = var.workspace_id
  gateway             = dome_gateway.kitchen_sink.name
  llm_pool            = dome_llm_pool.kitchen_sink_pool.name
}

resource "dome_agent" "kitchen_sink_agent" {
  workspace_id        = var.workspace_id
  name                = "kitchen-sink-agent"
  allowed_gateways    = [dome_gateway.kitchen_sink.name]
}

resource "dome_agent_rules_bundle" "kitchen_sink_agent" {
  workspace_id        = var.workspace_id
  agent               = dome_agent.kitchen_sink_agent.name
  files = {
    "agent.cedar" = <<-CEDAR
    permit ( principal, action == Dome::Action::"mcp:discover", resource );
    
    permit (
      principal,
      action == Dome::Action::"mcp:call",
      resource == Dome::MCPTool::"domedocs/search"
    );
    
    permit (
      principal,
      action == Dome::Action::"mcp:call",
      resource == Dome::MCPTool::"domedocs/get_page"
    );
    
    forbid (
      principal,
      action == Dome::Action::"mcp:call",
      resource == Dome::MCPTool::"domedocs/list_pages"
    );
    CEDAR
  }
}

resource "dome_filter" "redact_ssn" {
  workspace_id        = var.workspace_id
  name                = "redact-ssn"
  description         = "Redact US Social Security number patterns from model requests"
  config              = jsonencode({ text = { components = [{ action = "FILTER_ACTION_REDACT", matchers = [{ ssn = {} }] }] } })
}

resource "dome_llm_connection_filters" "haiku_request" {
  workspace_id        = var.workspace_id
  llm_connection      = dome_llm_connection.haiku.name
  direction           = "request"
  filters             = [dome_filter.redact_ssn.name]
}

resource "dome_quota" "kitchen_sink_agent_daily_spend" {
  workspace_id        = var.workspace_id
  dimension           = "llm"
  unit                = "dome_usd"
  subject_type        = "agent"
  subject             = dome_agent.kitchen_sink_agent.name
  scope               = "total"
  window              = "daily"
  limit_amount        = 5000000
  name                = "kitchen-sink-agent-daily-spend"
}

resource "dome_agent_key" "runtime" {
  workspace_id        = var.workspace_id
  agent               = dome_agent.kitchen_sink_agent.name
  name                = "runtime"
}

output "kitchen_sink_agent_token" {
  value     = dome_agent_key.runtime.token
  sensitive = true
}
