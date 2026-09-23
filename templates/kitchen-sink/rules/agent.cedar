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
