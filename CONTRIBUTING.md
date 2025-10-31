# Contributing to Claude Code Config

Thank you for considering contributing! This project thrives on community contributions of agents, skills, commands, and improvements.

## How to Contribute

### 1. Types of Contributions

We welcome:

- **New Agents** - Specialized autonomous assistants for specific domains
- **New Skills** - Knowledge modules for specific expertise areas
- **New Commands** - Slash commands for quick workflows
- **Templates** - Project templates and starter kits
- **Knowledge** - Curated knowledge bases and best practices
- **Documentation** - Improvements to guides and examples
- **Bug Fixes** - Corrections to existing configs
- **Improvements** - Enhancements to scripts and workflows

### 2. Contribution Process

#### Fork and Clone

```bash
# Fork the repo on GitHub, then:
git clone https://github.com/YOUR_USERNAME/claude-code-config.git
cd claude-code-config
```

#### Create a Branch

```bash
git checkout -b feature/your-contribution-name
```

#### Make Your Changes

Add your contribution to the appropriate directory:

- Agents → `public/agents/`
- Skills → `public/skills/`
- Commands → `public/commands/`
- Templates → `public/templates/`
- Knowledge → `public/knowledge/`
- Docs → `docs/`

#### Test Your Contribution

```bash
# Install to test
./install.sh

# Verify in Claude Code
# For agents: Use Task tool with your agent
# For skills: Invoke with Skill tool
# For commands: Use /your-command
```

#### Commit Your Changes

```bash
git add .
git commit -m "feat: add [your contribution]"
```

Follow [Conventional Commits](https://www.conventionalcommits.org/):
- `feat:` - New feature (agent, skill, command)
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `refactor:` - Code restructuring
- `test:` - Test additions

#### Push and Create PR

```bash
git push origin feature/your-contribution-name
```

Then create a Pull Request on GitHub.

## Contribution Guidelines

### Agents

**Good agents are:**
- Focused on a specific domain or task type
- Well-documented with clear capabilities
- Include practical examples
- Specify which tools they use
- Have a clear workflow pattern

**Agent Template:**

```markdown
# Agent Name

[One-line description]

## Core Identity

You are a [role] specialized in [domain]...

## Capabilities

- Specific capability 1
- Specific capability 2
- Specific capability 3

## Workflow

1. Step 1
2. Step 2
3. Step 3

## Tools

Primary tools used...

## Examples

### Example Task 1
Input: ...
Output: ...
```

### Skills

**Good skills are:**
- Comprehensive knowledge in a domain
- Include practical code examples
- Provide troubleshooting guidance
- Reference best practices
- Link to external resources

**Skill Template:**

```markdown
# Skill Name

[Description of expertise]

## Knowledge Areas

- Area 1
- Area 2

## When to Use

Use this skill when...

## Core Concepts

### Concept 1
Detailed explanation with examples...

## Best Practices

1. Practice 1
2. Practice 2

## Examples

\`\`\`language
Code example...
\`\`\`

## Resources

- [Resource 1](url)
```

### Commands

**Good commands are:**
- Clear, actionable workflows
- Focused on a specific task
- Include all necessary steps
- Handle edge cases

**Command Template:**

```markdown
[Clear instructions for what Claude should do when this command is invoked]

Workflow:
1. Step 1
2. Step 2
3. Step 3

Success criteria:
- Criterion 1
- Criterion 2
```

### Templates

**Good templates are:**
- Complete project starters
- Well-documented
- Follow best practices
- Include setup instructions

### Knowledge

**Good knowledge bases are:**
- Focused on a specific topic
- Well-structured with sections
- Include practical examples
- Reference authoritative sources
- Keep up-to-date

## Code of Conduct

### Our Standards

- **Be respectful** - Treat all contributors with respect
- **Be collaborative** - Work together constructively
- **Be inclusive** - Welcome diverse perspectives
- **Be helpful** - Provide constructive feedback
- **Be professional** - Maintain high standards

### Our Responsibilities

Project maintainers will:
- Review contributions promptly
- Provide constructive feedback
- Maintain code quality
- Keep documentation current
- Foster a welcoming community

## Review Process

### What We Look For

1. **Quality** - Well-written, tested, documented
2. **Usefulness** - Provides clear value
3. **Compatibility** - Works with existing setup
4. **Documentation** - Adequately explained
5. **Examples** - Includes usage examples

### Timeline

- **Initial review**: Within 1 week
- **Feedback cycle**: Ongoing until approved
- **Merge**: Once approved and CI passes

## Getting Help

### Questions

- **GitHub Discussions**: For general questions
- **GitHub Issues**: For bug reports
- **Pull Request Comments**: For contribution-specific questions

### Finding Contribution Ideas

Check:
- [Issues labeled "good first issue"](https://github.com/frankxai/claude-code-config/labels/good%20first%20issue)
- [Issues labeled "help wanted"](https://github.com/frankxai/claude-code-config/labels/help%20wanted)
- [Project roadmap](https://github.com/frankxai/claude-code-config/projects)

## Recognition

Contributors will be:
- Listed in CONTRIBUTORS.md
- Credited in release notes
- Recognized in README (for major contributions)

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Thank You!

Your contributions make this project better for everyone. Thank you for being part of the Claude Code community!

---

**Questions?** Open a [GitHub Discussion](https://github.com/frankxai/claude-code-config/discussions)

**Found a bug?** Open a [GitHub Issue](https://github.com/frankxai/claude-code-config/issues)

**Ready to contribute?** Fork, code, and submit a PR!
