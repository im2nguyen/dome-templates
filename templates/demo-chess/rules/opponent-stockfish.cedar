// Standing opponent: discover the engine and choose only an opponent pool.
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
  resource has pool &&
  resource.pool in ["chess-fast", "chess-balanced", "chess-strong"]
};
