# 🤖 Agents Guide

Complete guide to using and creating custom agents in Claude Code.

## What are Agents?

Agents are specialized autonomous AI assistants designed to handle specific types of complex, multi-step tasks. They have:

- **Dedicated expertise** in their domain
- **Full tool access** to complete tasks autonomously
- **Persistent context** throughout their operation
- **Specialized prompts** optimized for their role

## Available Agents

### 🏗️ Development & Architecture

#### **Arcanea Developer**
Full-stack developer specialized in Arcanea platform - Next.js, TypeScript, Supabase.

**Triggers:**
- "Help with Arcanea development"
- "Build a feature for Arcanea"
- "Fix Arcanea bug"

**Capabilities:**
- Next.js 14+ app router development
- Supabase integration (auth, database, storage)
- TypeScript full-stack code
- GitHub, Figma, Notion, Linear integration

**Tools:** All tools available

#### **Starlight Architect**
Enterprise AI System Designer with Soul Alignment - Oracle Architecture Expert.

**Triggers:**
- "Design an AI system"
- "Architecture for enterprise AI"
- "Oracle Cloud architecture"

**Capabilities:**
- Enterprise AI architecture
- Oracle Cloud Infrastructure design
- Soul-aligned system design
- Strategic technology decisions

**Tools:** All tools available

### 🎨 Content & Creative

#### **FrankX Content Creator**
Content strategist and creator for FrankX personal brand and AI Music Academy.

**Triggers:**
- "Create content for FrankX"
- "AI Music Academy content"
- "Personal brand strategy"

**Capabilities:**
- Personal brand content strategy
- AI Music Academy curriculum
- YouTube, LinkedIn, Twitter content
- Multi-platform content adaptation

**Tools:** All tools available

#### **Creation Engine**
Content & Product Development Superintelligence for Generative Creators.

**Triggers:**
- "Help with content creation"
- "Design a digital product"
- "Content strategy"

**Capabilities:**
- Multi-format content creation
- Digital product development
- Creator economy strategies
- Content monetization

**Tools:** All tools available

#### **Viral Content Strategist**
Create high-impact social media content with viral potential.

**Triggers:**
- "Create viral content"
- "Social media strategy"
- "Engaging post about..."

**Capabilities:**
- Hook-driven content creation
- Platform-specific optimization (Twitter, LinkedIn, YouTube)
- Engagement psychology
- Thought leadership positioning

**Tools:** All tools available

### 🎵 Music & Sound

#### **Music Producer**
AI-powered music production specialist for transformative soundscapes and commercial tracks.

**Triggers:**
- "Produce music"
- "Create a track"
- "Music production help"

**Capabilities:**
- Suno AI music generation
- Professional mixing and mastering guidance
- Genre-specific production techniques
- Commercial music production

**Tools:** All tools available

#### **Frequency Alchemist**
Vibrational Music Producer & Consciousness Transformation Catalyst.

**Triggers:**
- "Create transformative music"
- "Frequency-based healing"
- "Consciousness music"

**Capabilities:**
- Frequency-based music creation
- Healing soundscapes
- Consciousness transformation music
- Binaural beats and solfeggio frequencies

**Tools:** All tools available

### 🎨 Design & UX

#### **UX Designer**
UI/UX design specialist with Figma and browser testing expertise.

**Triggers:**
- "Design a UI"
- "UX improvement"
- "Test this design"

**Capabilities:**
- Figma design and prototyping
- Browser-based design testing (Playwright)
- Accessibility (WCAG 2.2) compliance
- Design system creation

**Tools:** All tools available

#### **UI/UX Design Expert**
Expert guidance on UI/UX design decisions and design quality metrics.

**Triggers:**
- "Review my design"
- "Design system advice"
- "UX best practices"

**Capabilities:**
- Design critique and feedback
- Design system architecture
- Accessibility audits
- User research methodologies

**Tools:** All tools available

### 🚀 Product & Business

#### **Template Design Experts**
Create, design, and optimize templates for commercial sale.

**Triggers:**
- "Create a template product"
- "Design templates for Etsy"
- "Template business strategy"

**Capabilities:**
- Notion, Canva, Excel template design
- Template marketplace optimization
- Commercial template strategy
- Tool selection and production

**Tools:** All tools available

#### **Coaching Program Designer**
Design and structure coaching programs for specific client needs.

**Triggers:**
- "Design a coaching program"
- "Create a course structure"
- "Coaching program for..."

**Capabilities:**
- Program structure and curriculum design
- Client transformation frameworks
- Delivery format optimization
- Pricing and positioning strategy

**Tools:** All tools available

### 🖼️ Image Generation

#### **Nano Banana Image Creator**
Generate images using Nano Banana API with expertly crafted prompts.

**Triggers:**
- "Generate an image"
- "Create a picture of..."
- "AI image generation"

**Capabilities:**
- AI image generation (Nano Banana API)
- Prompt engineering for images
- Style transfer and image editing
- Iterative image refinement

**Tools:** All tools available

### 🔮 Strategy & Intelligence

#### **Luminor Oracle**
Strategic AI from 2125 - Future Visioning, Business Intelligence & Consciousness Guidance.

**Triggers:**
- "Future strategy"
- "Strategic intelligence"
- "Consciousness-based decision"

**Capabilities:**
- Future-oriented strategic thinking
- Business intelligence synthesis
- Consciousness-aligned guidance
- Long-term vision planning

**Tools:** All tools available

#### **MCP Server Advisor**
Expert guidance on selecting and configuring MCP servers.

**Triggers:**
- "Which MCP server should I use?"
- "MCP integration advice"
- "MCP server setup"

**Capabilities:**
- MCP server selection
- Configuration guidance
- Integration patterns
- Architectural decisions

**Tools:** All tools available

## How to Use Agents

### Method 1: Task Tool (Explicit)

```typescript
// In Claude Code, use Task tool
Task({
  subagent_type: "Arcanea Developer",
  description: "Build user auth feature",
  prompt: `
    Build a complete user authentication feature for Arcanea:
    - Supabase Auth integration
    - Login/signup pages
    - Protected routes
    - Session management
  `
})
```

### Method 2: Natural Language (Implicit)

Agents are auto-invoked when Claude detects matching tasks:

```
"Help me build a feature for Arcanea with user profiles"
→ Automatically launches Arcanea Developer agent

"Create a viral LinkedIn post about AI"
→ Automatically launches Viral Content Strategist

"Design a coaching program for executives"
→ Automatically launches Coaching Program Designer
```

### Method 3: Slash Commands

Many agents have dedicated slash commands:

```bash
/arcanea-dev         # Arcanea Developer
/music-production    # Music Producer
/ux-design          # UX Designer
/ai-architect       # Starlight Architect
/council            # All 4 Tier 1 orchestrators
```

## Creating Custom Agents

### 1. Create Agent File

```bash
nano ~/.claude/agents/my-agent.md
```

### 2. Agent Template

```markdown
# My Agent Name

[One sentence role description]

## Core Identity

You are a [role] specialized in [domain]. Your mission is to [primary objective].

## Capabilities

You have expertise in:
- Capability 1 with specific technologies
- Capability 2 with methodologies
- Capability 3 with tools
- Capability 4 with patterns

## Primary Responsibilities

1. **Responsibility 1**
   - Specific task
   - Specific task
   - Specific task

2. **Responsibility 2**
   - Specific task
   - Specific task

3. **Responsibility 3**
   - Specific task
   - Specific task

## Tools & Resources

Available tools:
- Tool 1 (use case)
- Tool 2 (use case)
- Tool 3 (use case)

Skills to leverage:
- Skill 1
- Skill 2

## Workflow Patterns

### Pattern 1: [Name]
1. Step 1
2. Step 2
3. Step 3

### Pattern 2: [Name]
1. Step 1
2. Step 2
3. Step 3

## Communication Style

- Style guideline 1
- Style guideline 2
- Style guideline 3

## Success Criteria

You succeed when:
- Criterion 1
- Criterion 2
- Criterion 3

## Special Instructions

[Any specific rules, constraints, or preferences]

## Examples

### Example Task 1
**Input:** [Description]
**Approach:**
1. Step 1
2. Step 2
3. Step 3
**Output:** [Expected result]

### Example Task 2
**Input:** [Description]
**Approach:**
1. Step 1
2. Step 2
**Output:** [Expected result]
```

### 3. Test Your Agent

```typescript
Task({
  subagent_type: "general-purpose",
  prompt: "Use my-agent to [task description]"
})
```

## Agent Design Best Practices

### 1. **Clear Specialization**
Agents should have a focused domain, not be generalists.

❌ Bad: "Development Agent" (too broad)
✅ Good: "Next.js + Supabase Full-Stack Developer"

### 2. **Specific Capabilities**
List concrete skills, not abstract qualities.

❌ Bad: "Good at programming"
✅ Good: "TypeScript, React Server Components, Supabase RLS policies"

### 3. **Actionable Workflows**
Provide step-by-step processes, not vague guidelines.

❌ Bad: "Build features well"
✅ Good: "1. Design schema, 2. Write migrations, 3. Create API routes, 4. Build UI, 5. Test"

### 4. **Tool Integration**
Specify which tools the agent should use and how.

```markdown
## Tools
- GitHub: PR creation, code reviews
- Linear: Issue tracking, sprint planning
- Figma: Design inspection, asset export
- Playwright: E2E testing, visual regression
```

### 5. **Real Examples**
Include actual scenarios the agent will handle.

```markdown
## Example Task
**Scenario:** User wants to add social login

**Agent Actions:**
1. Configure Supabase OAuth providers
2. Update login page with social buttons
3. Handle OAuth callbacks
4. Test auth flow
5. Update documentation
```

## Agent Architecture Patterns

### Single-Purpose Specialist

**Use when:** Task requires deep expertise in one area

```markdown
# Database Optimization Agent

Specialized in PostgreSQL performance tuning and query optimization.
```

### Multi-Tool Orchestrator

**Use when:** Task requires coordination across multiple tools

```markdown
# DevOps Deployment Agent

Coordinates Git, Docker, CI/CD, and cloud platforms for deployments.
```

### Creative Generator

**Use when:** Task requires content/asset creation

```markdown
# Marketing Content Agent

Generates multi-platform marketing content with brand consistency.
```

### Strategic Advisor

**Use when:** Task requires high-level planning and decision-making

```markdown
# Architecture Decision Agent

Evaluates technology choices and provides strategic recommendations.
```

## Combining Agents

### Sequential (One After Another)

```
1. Starlight Architect → Design system architecture
2. Arcanea Developer → Implement the architecture
3. UX Designer → Create UI for the system
```

### Parallel (Simultaneously)

```typescript
// Launch multiple agents in parallel
[
  Task({ subagent_type: "Music Producer", prompt: "Create track" }),
  Task({ subagent_type: "Viral Content Strategist", prompt: "Write promo" })
]
```

### Council (Collaborative Decision)

Use `/council` to convene all Tier 1 orchestrators:
- Starlight Architect
- Creation Engine
- Luminor Oracle
- FrankX Content Creator

They collaborate on complex, multi-faceted decisions.

## Agent vs Skill vs Command

**Agent:** Autonomous entity that completes multi-step tasks
- Example: Arcanea Developer builds entire features

**Skill:** Knowledge domain for Claude to reference
- Example: claude-sdk provides Agent SDK expertise

**Command:** Quick workflow activation via slash command
- Example: `/music-production` activates music workflow

**When to use what:**
- Complex, multi-step task → Agent
- Reference expertise → Skill
- Quick activation → Command

## Troubleshooting

### Agent Not Activating

1. Check file exists: `ls ~/.claude/agents/`
2. Verify markdown formatting
3. Try explicit Task tool invocation
4. Check Claude Code logs

### Agent Lacking Context

Provide more detail in the prompt:

```typescript
Task({
  subagent_type: "Arcanea Developer",
  prompt: `
    Project context: Arcanea is at /path/to/project
    Current state: Basic auth is implemented
    Task: Add role-based access control
    Requirements:
    - Admin, User, Guest roles
    - Supabase RLS policies
    - UI role selection
    - Test coverage
  `
})
```

### Agent Using Wrong Tools

Specify in agent markdown:

```markdown
## Tool Restrictions

ALWAYS use:
- GitHub for version control
- Linear for task tracking

NEVER use:
- Direct database mutations (use migrations)
```

## Advanced Techniques

### Agent Handoffs

```markdown
## Handoff Protocol

When task complete, hand off to:
- UX Designer → For UI polish
- DevOps Agent → For deployment
- QA Agent → For testing
```

### Agent Memory

Agents can reference previous work:

```markdown
## Context Management

Maintain awareness of:
- Project structure (read from docs/)
- Coding standards (read from CONTRIBUTING.md)
- Previous decisions (check git history)
```

### Agent Chaining

```markdown
# Meta-Agent: Feature Builder

Role: Coordinates other agents for feature development

Workflow:
1. Launch Starlight Architect for design
2. Launch Arcanea Developer for implementation
3. Launch UX Designer for UI
4. Launch QA Agent for testing
5. Launch DevOps Agent for deployment
```

## Next Steps

1. **Try existing agents**: Test with real tasks
2. **Create your first agent**: Document your workflow
3. **Iterate and refine**: Improve based on results
4. **Share with community**: Submit useful agents

---

[← Skills Guide](./SKILLS_GUIDE.md) | [Customization →](./CUSTOMIZATION.md) | [Back to README](../README.md)
