// Delegated coach: discover the engine, call it, and use only the coaching pool.
permit(
  principal is Dome::Agent,
  action == Dome::Action::"mcp:discover",
  resource
);

permit(
  principal is Dome::Agent,
  action == Dome::Action::"mcp:call",
  resource == Dome::MCPTool::"stockfish/chess_engine"
);

permit(
  principal is Dome::Agent,
  action == Dome::Action::"llm:invoke",
  resource is Dome::LLMModel
) when {
  resource.pool == "coach"
};
