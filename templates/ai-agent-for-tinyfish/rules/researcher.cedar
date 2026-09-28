// The managed researcher can discover its gateway and use only TinyFish reads.
permit ( principal, action == Dome::Action::"mcp:discover", resource );
permit ( principal, action == Dome::Action::"mcp:call", resource == Dome::MCPTool::"tinyfish/search" );
permit ( principal, action == Dome::Action::"mcp:call", resource == Dome::MCPTool::"tinyfish/fetch_content" );
