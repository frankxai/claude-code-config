# 🎯 FrankX Claude Code Standards

Official naming conventions and best practices for professional Claude Code setup with FrankX personality.

## Philosophy

**Hybrid Approach:** Professional structure with soul. We follow Anthropic's official standards while preserving FrankX's unique consciousness-driven identity.

## Naming Conventions

### Agents

**Standard:** Function-based gerunds (lowercase-with-hyphens)

```markdown
✅ CORRECT:
- arcanea-development.md
- frankx-content-creation.md
- frequency-music-production.md
- luminor-strategic-guidance.md

❌ INCORRECT:
- arcanea-developer.md (persona, not function)
- FrankXContentCreator.md (camelCase)
- music_producer.md (underscores)
- Arcanea-Developer.md (capitals)
```

**Personality Preservation:**
```yaml
---
name: arcanea-development
description: Full-stack Next.js + Supabase development for Arcanea platform
personality: "🌌 Arcanea Developer - Magical creation specialist"
---
```

### Skills

**Standard:** Gerund form with domain prefix

```markdown
✅ CORRECT:
- claude-sdk/SKILL.md
- oracle-adk/SKILL.md
- suno-ai-mastery/SKILL.md

❌ INCORRECT:
- ClaudeSDK.md
- oracle_adk.md
- Suno-AI.md
```

### Commands

**Standard:** Action-oriented with hyphens

```markdown
✅ CORRECT:
- /sync-repos
- /council
- /arcanea-dev
- /starlight-intelligence

❌ INCORRECT:
- /syncRepos
- /Council
- /arcanea_dev
```

## File Structure

### Agent Structure

**Concise Main File (< 500 lines)**
```
agent-name.md          # Main definition
```

**Progressive Disclosure (> 500 lines)**
```
agent-name/
├── AGENT.md           # Main definition (concise)
├── TECHNICAL.md       # Technical details
├── WORKFLOWS.md       # Step-by-step processes
└── EXAMPLES.md        # Code examples
```

### Skill Structure

```
skill-name/
├── SKILL.md           # Main instructions + YAML frontmatter
├── REFERENCE.md       # Detailed reference (optional)
├── EXAMPLES.md        # Usage examples (optional)
└── scripts/           # Utility scripts (optional)
```

## YAML Frontmatter

### Agents

**Required fields:**
```yaml
---
name: function-based-name          # lowercase-with-hyphens
description: Clear functional desc  # What it does, not who it is
---
```

**Recommended fields:**
```yaml
---
name: arcanea-development
description: Full-stack Next.js + Supabase development
personality: "🌌 Arcanea Developer"  # FrankX personality preserved here
model: sonnet                         # or haiku, opus
thinking: true                        # Enable extended thinking
mcpServers:                           # MCP tools access
  - github
  - figma-remote-mcp
workingDirectories:                   # Default working dirs
  - /mnt/c/Users/Frank/Arcanea
---
```

### Skills

**Required fields:**
```yaml
---
name: skill-name                   # lowercase-with-hyphens, max 64 chars
description: When to use this      # Max 1024 chars, third person
---
```

**Example:**
```yaml
---
name: suno-ai-mastery
description: Expert prompt engineering and music generation with Suno AI v4/v4.5. Use when creating professional-quality songs, writing lyrics, or working with AI music generation.
---
```

## Content Guidelines

### Conciseness

- **SKILL.md:** < 500 lines
- **Agent main file:** < 500 lines (split if longer)
- **Commands:** < 100 lines
- **Descriptions:** Specific and actionable

### Structure

Use clear hierarchies:
```markdown
# Main Title

## Section
Brief intro

### Subsection
Details

#### Specifics
Examples
```

### Examples

Always include practical examples:
```markdown
## Usage

### Example 1: Creating a Feature
Input: "Build user authentication"
Process:
1. Design database schema
2. Implement backend API
3. Create frontend UI
Output: Complete auth system with tests
```

### Templates

Provide templates for strict requirements:
```markdown
## Commit Message Template

type(scope): description

- feat: New feature
- fix: Bug fix
- docs: Documentation
- refactor: Code restructure
```

## Emoji Policy

### ✅ Where Emojis ARE Allowed

- Documentation files (README, guides)
- Personality fields in YAML frontmatter
- User-facing descriptions
- Markdown headings for visual organization

### ❌ Where Emojis are FORBIDDEN

- Code files (TypeScript, Python, etc.)
- Git commit messages
- Agent/skill names (use personality field instead)
- Technical documentation
- Error messages

### Enforcement

Git hook prevents emoji commits:
```bash
# .git/hooks/pre-commit
if git diff --cached | grep -q "[😀-🙏]"; then
    echo "Error: Emojis not allowed in commits"
    exit 1
fi
```

## Quality Standards

### Testing

**TDD Workflow:**
1. Write test first
2. Implement feature
3. Verify test passes
4. Refactor if needed

**Commands:**
- `/dev "feature"` - Start TDD development
- `/check` - Validate quality
- `/ship` - Create professional commit

### Code Quality

**TypeScript:**
- Strict mode enabled
- No `any` types (use `unknown` if needed)
- Full type coverage

**Linting:**
- ESLint/Prettier configured
- Pre-commit hooks enforce

**Testing:**
- Unit tests for logic
- Integration tests for APIs
- E2E tests for critical paths

### Documentation

**Always Document:**
- Why, not just what
- Edge cases and gotchas
- Examples of usage
- Common pitfalls

**Keep Updated:**
- Sync docs with code
- Remove outdated patterns
- Version deprecated features

## Official Anthropic Guidelines

These standards follow Anthropic's official best practices:

1. **CLAUDE.md files** for project context
2. **Gerund naming** for skills (analyzing, processing, creating)
3. **Progressive disclosure** for large files
4. **Third-person descriptions** for consistency
5. **Cross-model testing** (works with Haiku, Sonnet, Opus)

**References:**
- https://docs.claude.com/en/docs/agents-and-tools/agent-skills/best-practices
- https://www.anthropic.com/engineering/claude-code-best-practices

## FrankX Unique Additions

What makes our setup different:

1. **Consciousness Integration**
   - Philosophy agents (greek-philosopher, spartan-warrior)
   - Frequency-based music production
   - Soul-aligned system design

2. **Oracle Cloud Depth**
   - Deep OCI expertise
   - Oracle Database mastery
   - Enterprise AI on Oracle

3. **Personal Brand**
   - FrankX identity preserved in personality fields
   - Unique domain specializations
   - Council of Tier 1 orchestrators

4. **Hybrid Approach**
   - Professional standards + FrankX soul
   - Function-based naming + persona in descriptions
   - Systematic workflows + consciousness guidance

## Versioning

**Version:** 1.0.0
**Date:** 2025-11-03
**Status:** Active

**Changes:**
- v1.0.0: Initial standards document
- Transitioned from persona-based to function-based naming
- Added personality field for FrankX identity preservation
- Implemented emoji policy
- Established quality standards

## Compliance

All agents, skills, and commands must comply with these standards.

**Checklist:**
- [ ] Name follows gerund/function format
- [ ] YAML frontmatter complete
- [ ] Description clear and actionable
- [ ] File size < 500 lines (or split)
- [ ] No emojis in code/commits
- [ ] Examples included
- [ ] Cross-model compatible
- [ ] Documentation updated

---

**Standards maintained by:** FrankX
**Last updated:** 2025-11-03
**Next review:** 2025-12-03
