# Agent Templates

This directory contains 8 customizable agent templates that you can adapt for your specific needs. Each template provides a framework with placeholders for you to fill in.

## Available Templates

1. **blank-agent.md** - Completely blank slate for custom agents
2. **domain-expert.md** - Template for industry/domain-specific expert agents
3. **workflow-automation.md** - Template for task automation agents
4. **research-analyst.md** - Template for research and analysis agents
5. **creative-specialist.md** - Template for creative and content agents
6. **technical-specialist.md** - Template for technical/engineering agents
7. **advisor-consultant.md** - Template for advisory and consulting agents
8. **project-manager.md** - Template for project-specific management agents

## How to Use Templates

### Step 1: Choose a Template
Select the template that most closely matches your needs.

### Step 2: Copy to Your Agents Directory
```bash
cp ~/.claude/templates/starlight-intelligence-system/templates/[template-name].md \
   ~/.claude/agents/my-custom-agent.md
```

### Step 3: Customize the Template
Edit the file and replace all `[PLACEHOLDER]` values with your specific information:

- `[AGENT_NAME]` - Name of your agent
- `[DESCRIPTION]` - Brief description of what the agent does
- `[EXPERTISE_AREA]` - Main domain or expertise
- `[MCP_SERVERS]` - Which MCP servers this agent needs
- etc.

### Step 4: Activate Your Agent
Use a slash command or launch directly:
```bash
claude --agent my-custom-agent
```

## Customization Tips

### Choosing MCP Servers
Only include the MCP servers your agent actually needs. Available options:
- `github` - Code repositories and version control
- `linear-server` - Project management and issue tracking
- `notion` - Documentation and knowledge management
- `slack` - Team communication
- `figma-remote-mcp` - Design files and prototypes
- `playwright` - Browser automation and testing
- `nano-banana` - Image generation
- `lyric-genius` - Creative writing and lyrics

### Setting the Model
Choose the right model for your agent's complexity:
- `opus` - Most capable, for complex reasoning (Tier 1 orchestrators)
- `sonnet` - Balanced performance and cost (Tier 2 specialists)
- `haiku` - Fast and lightweight (simple tasks)

### Agent Tiers
- **Tier 1**: Universal orchestrators with broad expertise, minimal MCP usage
- **Tier 2**: Domain specialists with deep expertise, full MCP suite access

## Example Customization

Starting with `domain-expert.md`:

```markdown
---
name: [AGENT_NAME]
description: [DESCRIPTION]
mcpServers: [MCP_SERVERS_LIST]
model: [MODEL]
tier: [1_OR_2]
category: [CATEGORY]
---
```

Becomes:

```markdown
---
name: Healthcare AI Expert
description: Medical AI and healthcare technology specialist
mcpServers:
  - notion
  - linear-server
model: opus
tier: 1
category: domain-expert
---
```

## Template Structure

All templates follow this structure:

1. **Frontmatter** (YAML) - Agent metadata
2. **Agent Identity** - Who this agent is
3. **Core Expertise** - What they know
4. **Communication Style** - How they interact
5. **Typical Use Cases** - Examples of what they do
6. **MCP Tools Available** - How they use tools
7. **Best Practices** - Built-in quality standards
8. **Integration** - How they work with other agents
9. **Deliverables** - What to expect
10. **Success Metrics** - How to measure effectiveness

## Need Help?

- Check existing pre-built agents for inspiration
- See the Agent Reference in the main documentation
- Join the community Discord for template sharing
- Email support@starlight-intelligence.com

## Contributing Templates

Created an awesome custom agent? Share it with the community!
1. Anonymize any proprietary information
2. Document your use case
3. Submit via GitHub or Discord
4. We may feature it in future releases!
