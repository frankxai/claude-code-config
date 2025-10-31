# 🧠 Skills Guide

Complete guide to understanding and using Claude Code skills.

## What are Skills?

Skills are reusable knowledge modules that give Claude deep expertise in specific domains. Think of them as specialized expert consultants that Claude can invoke when needed.

## Available Skills

### 🤖 AI/ML Development

#### **claude-sdk**
Build autonomous AI agents using Claude Agent SDK with computer use, tool calling, MCP integration, and production best practices.

```bash
# Invoke with Skill tool
Skill: claude-sdk
```

**Use when:**
- Building Claude-powered applications
- Implementing computer use
- Creating MCP servers
- Agent orchestration patterns

#### **langgraph-patterns**
Build production-grade agentic workflows with LangGraph using graph-based orchestration, state machines, and human-in-the-loop.

**Use when:**
- Complex multi-agent workflows
- State management in agents
- Human-in-the-loop patterns
- Advanced control flow

#### **openai-agentkit**
Build production-ready multi-agent systems using OpenAI AgentKit and Agents SDK.

**Use when:**
- OpenAI agent development
- Multi-agent coordination
- Agent handoffs and routines

#### **oracle-adk**
Build production agentic applications on OCI using Oracle Agent Development Kit.

**Use when:**
- Oracle Cloud AI development
- Enterprise agent systems
- OCI integration patterns

#### **oracle-agent-spec**
Design framework-agnostic AI agents using Oracle's Open Agent Specification.

**Use when:**
- Platform-agnostic agent design
- Agent interoperability
- Standardized agent definitions

#### **mcp-architecture**
Design and implement Model Context Protocol servers for standardized AI-to-data integration.

**Use when:**
- Building MCP servers
- Integrating data sources with AI
- Protocol design patterns

### ☁️ Cloud & Infrastructure

#### **oci-services-expert**
Expert guidance on Oracle Cloud Infrastructure services, architecture patterns, and cost optimization.

**Use when:**
- OCI architecture design
- Cloud deployment strategies
- Cost optimization
- Enterprise cloud solutions

#### **oracle-database-expert**
Oracle Database expertise including SQL, PL/SQL, performance tuning, and cloud database services.

**Use when:**
- Database design and optimization
- PL/SQL development
- Autonomous Database setup
- Performance tuning

### 🎨 Design & Development

#### **framer-expert**
Expert in Framer design and development - from interactive prototypes to production sites with Framer Motion and CMS integration.

**Use when:**
- Framer site development
- Interactive prototypes
- Framer Motion animations
- CMS integration

#### **ui-ux-design-expert**
Expert guidance on UI/UX design, design systems, accessibility, and user research.

**Use when:**
- UI/UX design decisions
- Design system creation
- Accessibility (WCAG 2.2)
- User research and testing

### 💪 Personal Development

#### **gym-training-expert**
Apply cutting-edge exercise science from 2025 research on hypertrophy, progressive overload, and evidence-based training.

**Use when:**
- Workout program design
- Exercise science questions
- Strength and muscle building
- Training optimization

#### **health-nutrition-expert**
Apply cutting-edge 2025 nutrition science on longevity, metabolic health, gut microbiome, and evidence-based diets.

**Use when:**
- Nutrition planning
- Health optimization
- Longevity strategies
- Metabolic health

#### **suno-ai-mastery**
Expert prompt engineering and music generation with Suno AI v4/v4.5 for professional-quality songs.

**Use when:**
- Music generation with Suno
- Lyric writing
- Genre-specific composition
- Advanced music prompts

### 🏛️ Philosophy & Mindset

#### **greek-philosopher**
Channel ancient wisdom through Socratic questioning, Stoic principles, and philosophical inquiry.

**Use when:**
- Philosophical exploration
- Ethical dilemmas
- Deep thinking and reflection
- Life wisdom

#### **spartan-warrior**
Embody the unbreakable Spartan ethos of discipline, courage, and relentless excellence.

**Use when:**
- Motivation and discipline
- Overcoming challenges
- Building mental toughness
- Peak performance mindset

## How to Use Skills

### Method 1: Skill Tool (Explicit Invocation)

```bash
# In Claude Code, use the Skill tool
Skill: mcp-architecture
```

Claude will load the skill and apply its expertise to your conversation.

### Method 2: Natural Language (Implicit)

Skills are automatically invoked when Claude detects relevant tasks:

```
"Help me build an MCP server for my database"
→ Automatically uses mcp-architecture skill

"Design an Oracle Cloud architecture for my app"
→ Automatically uses oci-services-expert skill

"Create a workout program for muscle gain"
→ Automatically uses gym-training-expert skill
```

### Method 3: In Agent Prompts

Reference skills in custom agents:

```markdown
# My Custom Agent

You are an expert developer. Use the following skills:
- claude-sdk for AI agent development
- mcp-architecture for building MCP servers
- langgraph-patterns for complex workflows
```

## Creating Your Own Skills

### 1. Create Skill Directory

```bash
mkdir -p ~/.claude/skills/my-skill
```

### 2. Create SKILL.md

```bash
nano ~/.claude/skills/my-skill/SKILL.md
```

### 3. Skill Template

```markdown
# My Skill Name

[Brief description of what this skill provides]

## Knowledge Domain

Expertise in:
- Domain area 1
- Domain area 2
- Domain area 3

## When to Use This Skill

Use this skill when:
- Scenario 1
- Scenario 2
- Scenario 3

## Core Concepts

### Concept 1
Detailed explanation...

### Concept 2
Detailed explanation...

## Practical Examples

### Example 1: [Task Description]

\`\`\`language
Code example...
\`\`\`

Explanation...

### Example 2: [Task Description]

\`\`\`language
Code example...
\`\`\`

Explanation...

## Best Practices

1. **Best Practice 1**
   - Guideline
   - Guideline

2. **Best Practice 2**
   - Guideline
   - Guideline

## Common Patterns

Pattern 1: [Name]
- Description
- When to use
- Example

Pattern 2: [Name]
- Description
- When to use
- Example

## Troubleshooting

**Problem:** Common issue
**Solution:** How to fix it

**Problem:** Another issue
**Solution:** Resolution steps

## Resources

- [Resource 1](url)
- [Resource 2](url)
- Documentation references

## Related Skills

This skill works well with:
- related-skill-1
- related-skill-2
```

### 4. Add Knowledge Files (Optional)

```bash
# Add supporting files
nano ~/.claude/skills/my-skill/examples.md
nano ~/.claude/skills/my-skill/reference.md
nano ~/.claude/skills/my-skill/patterns.md
```

### 5. Test Your Skill

```bash
# In Claude Code
Skill: my-skill
```

Then ask Claude to help with tasks in that domain.

## Skill Design Best Practices

### 1. **Clear Scope**
Define exactly what the skill covers and what it doesn't.

### 2. **Actionable Content**
Include practical examples, code samples, and step-by-step guides.

### 3. **Current Information**
Keep skills updated with latest patterns and best practices.

### 4. **Cross-References**
Link to related skills and external resources.

### 5. **Troubleshooting**
Include common problems and solutions.

### 6. **Real Examples**
Use actual code and scenarios, not abstract descriptions.

## Combining Skills

Skills can be combined for complex tasks:

```
"Build an MCP server for Oracle Cloud using Claude SDK"
→ Uses: mcp-architecture + oci-services-expert + claude-sdk

"Design a Framer site with accessible UI/UX"
→ Uses: framer-expert + ui-ux-design-expert

"Create a workout and nutrition plan"
→ Uses: gym-training-expert + health-nutrition-expert
```

## Skill Organization

### Project-Specific Skills

Keep in project directory:
```
my-project/.claude/skills/
└── project-specific-skill/
    └── SKILL.md
```

### Global Skills

Keep in global config:
```
~/.claude/skills/
└── general-skill/
    └── SKILL.md
```

### Shared Skills (This Repo)

Contribute to the community:
```
claude-code-config/public/skills/
└── your-skill/
    └── SKILL.md
```

## Advanced Techniques

### Skill Inheritance

Reference other skills:

```markdown
# Advanced Skill

This skill builds on:
- base-skill-1
- base-skill-2

Additional expertise:
...
```

### Conditional Skills

Skills with prerequisites:

```markdown
# Deployment Skill

Prerequisites:
- Skill: cloud-architecture
- Skill: security-best-practices

Then apply deployment patterns...
```

### Meta-Skills

Skills about using skills:

```markdown
# Skill Orchestrator

How to combine multiple skills effectively:
1. Identify task requirements
2. Select relevant skills
3. Apply in correct order
4. Validate results
```

## Skill Performance

### Load Time
Skills are loaded on-demand, so there's no performance penalty for having many skills.

### Token Usage
Larger skills use more context tokens. Keep skills focused and concise.

### Caching
Claude may cache skill content for repeated use in a session.

## Community Skills

### Contributing

1. Create your skill
2. Test thoroughly
3. Document clearly
4. Submit PR to this repo

### Guidelines

- **Unique value**: Skill should provide clear expertise
- **Well-documented**: Examples, use cases, troubleshooting
- **Tested**: Verify skill works as expected
- **Maintained**: Keep updated with latest practices

## Troubleshooting Skills

### Skill Not Loading

```bash
# Check file exists
ls -la ~/.claude/skills/your-skill/SKILL.md

# Check file permissions
chmod 644 ~/.claude/skills/your-skill/SKILL.md

# Restart Claude Code
```

### Skill Not Working as Expected

1. Review SKILL.md content
2. Check for markdown formatting errors
3. Verify examples are current
4. Test with simple tasks first

### Conflicts Between Skills

If two skills have conflicting advice:
- Specify which skill to prioritize
- Create a meta-skill that resolves conflicts
- Use explicit Skill tool invocation

## Next Steps

1. **Explore existing skills**: Try each skill with relevant tasks
2. **Create your first skill**: Document your expertise
3. **Combine skills**: Use multiple skills for complex projects
4. **Share with community**: Submit useful skills via PR

---

[← Back to README](../README.md) | [Agents Guide →](./AGENTS_GUIDE.md) | [Customization →](./CUSTOMIZATION.md)
