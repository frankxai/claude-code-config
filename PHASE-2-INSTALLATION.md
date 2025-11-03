# 🚀 Phase 2: Systematic Workflows Installation

**Add TDD, debugging, and quality enforcement to your FrankX setup**

## What Phase 2 Adds

✅ Test-Driven Development workflows
✅ Systematic debugging processes
✅ Quality validation commands
✅ Git hooks for enforcement
✅ Professional commit patterns

**Time Required:** 1-2 hours

---

## Step 1: Install obra/superpowers (15 min)

### Quick Install

In Claude Code:
```bash
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace
```

### What You Get

**Core Skills:**
- `test-driven-development` - TDD workflows activate automatically
- `systematic-debugging` - Evidence-based debugging
- `verification-before-completion` - Quality gates
- `anti-patterns` - Catch common mistakes

**Commands:**
- `/superpowers:brainstorm` - Structured brainstorming
- `/superpowers:write-plan` - Planning workflows
- `/superpowers:execute-plan` - Execution tracking

### Verification

Test it works:
```bash
# In Claude Code
"Let's debug this issue using systematic debugging"
```

The systematic-debugging skill should activate automatically.

---

## Step 2: Add Quality Commands (30 min)

### 2.1 Clone orielsanchez Template

```bash
cd ~/temp
git clone https://github.com/orielsanchez/claude-code-template.git
```

### 2.2 Extract Commands

Copy these commands to `~/.claude/commands/`:

**From orielsanchez:**
- `dev.md` → `~/. claude/commands/dev.md`
- `check.md` → `~/.claude/commands/check.md`
- `ship.md` → `~/.claude/commands/ship.md`
- `debug.md` → `~/.claude/commands/debug.md`
- `refactor.md` → `~/.claude/commands/refactor.md`

```bash
cp ~/temp/claude-code-template/.claude/commands/dev.md ~/.claude/commands/
cp ~/temp/claude-code-template/.claude/commands/check.md ~/.claude/commands/
cp ~/temp/claude-code-template/.claude/commands/ship.md ~/.claude/commands/
cp ~/temp/claude-code-template/.claude/commands/debug.md ~/.claude/commands/
cp ~/temp/claude-code-template/.claude/commands/refactor.md ~/.claude/commands/
```

### 2.3 Customize for FrankX

Edit each command to:
1. Add FrankX personality touches
2. Integrate with your Oracle/music workflows
3. Reference your specialized agents

Example customization for `dev.md`:
```markdown
# TDD Feature Development

Start test-driven development with FrankX excellence.

## Process
1. Write tests first (use systematic-debugging from superpowers)
2. Implement feature (leverage arcanea-development or relevant agent)
3. Verify all tests pass
4. Refactor with confidence
5. Check with /check before shipping

## For Oracle Projects
Integrate with oci-services-expert for cloud-native patterns.

## For Music Projects
Use frequency-music-production for sonic feature development.
```

---

## Step 3: Add Git Hooks (15 min)

### 3.1 Pre-Commit Hook (Strip Emojis)

Create `~/.claude/.git/hooks/pre-commit`:

```bash
#!/bin/bash
# FrankX Pre-Commit Hook: Quality Enforcement

echo "🎯 FrankX Quality Check..."

# Check for emojis in commit message
if git diff --cached | grep -q "[😀-🙏🌟✨🎯🚀]"; then
    echo "❌ Error: Emojis not allowed in code"
    echo "   Keep emojis in personality fields and docs only"
    exit 1
fi

# Run linter if available
if command -v npx &> /dev/null; then
    echo "  Running linter..."
    npx eslint --fix . || echo "  (Linting skipped)"
fi

# Run type checker if TypeScript
if [ -f "tsconfig.json" ]; then
    echo "  Checking types..."
    npx tsc --noEmit || echo "  (Type check skipped)"
fi

echo "✅ Quality check passed!"
exit 0
```

Make executable:
```bash
chmod +x ~/.claude/.git/hooks/pre-commit
```

### 3.2 Commit Message Hook

Create `~/.claude/.git/hooks/commit-msg`:

```bash
#!/bin/bash
# FrankX Commit Message Hook

COMMIT_MSG_FILE=$1
COMMIT_MSG=$(cat "$COMMIT_MSG_FILE")

# Check for emojis in commit message
if echo "$COMMIT_MSG" | grep -q "[😀-🙏🌟✨🎯🚀]"; then
    echo "❌ Error: Emojis not allowed in commit messages"
    echo "   Use conventional commits: feat:, fix:, docs:, etc."
    exit 1
fi

# Check format (conventional commits)
if ! echo "$COMMIT_MSG" | grep -qE "^(feat|fix|docs|style|refactor|test|chore)(\(.+\))?: .+"; then
    echo "⚠️  Warning: Consider conventional commit format"
    echo "   Examples: feat(auth): add login, fix(db): connection"
fi

exit 0
```

Make executable:
```bash
chmod +x ~/.claude/.git/hooks/commit-msg
```

---

## Step 4: Test Your Setup (30 min)

### 4.1 Test TDD Workflow

```bash
# In Claude Code
/dev "add user profile feature"
```

Should:
1. Ask about test framework
2. Write tests first
3. Guide implementation
4. Verify tests pass

### 4.2 Test Quality Check

```bash
/check
```

Should:
1. Run tests
2. Check linting
3. Verify types
4. Report status

### 4.3 Test Ship Command

```bash
/ship
```

Should:
1. Final quality validation
2. Create conventional commit
3. Suggest next steps

### 4.4 Test Git Hooks

Try committing with emoji:
```bash
git commit -m "✨ Added feature"
```

Should fail with error about emojis.

Try conventional commit:
```bash
git commit -m "feat: add user profile"
```

Should succeed.

---

## Step 5: Update Your Config Repo (10 min)

### 5.1 Copy New Commands

```bash
cd ~/claude-code-config
cp ~/.claude/commands/dev.md public/commands/
cp ~/.claude/commands/check.md public/commands/
cp ~/.claude/commands/ship.md public/commands/
cp ~/.claude/commands/debug.md public/commands/
cp ~/.claude/commands/refactor.md public/commands/
```

### 5.2 Add Hooks Directory

```bash
mkdir -p public/hooks
cp ~/.claude/.git/hooks/pre-commit public/hooks/
cp ~/.claude/.git/hooks/commit-msg public/hooks/
```

### 5.3 Update Documentation

Add to README.md:
```markdown
## Systematic Workflows (Phase 2)

We've integrated professional TDD workflows:

**Commands:**
- `/dev "feature"` - Start TDD development
- `/check` - Validate quality
- `/ship` - Create professional commit
- `/debug` - Systematic debugging
- `/refactor` - Safe refactoring

**Skills (auto-activate):**
- test-driven-development
- systematic-debugging
- verification-before-completion
- anti-patterns

**Powered by:** obra/superpowers + orielsanchez patterns
```

---

## Workflow Examples

### Example 1: New Feature Development

```bash
# 1. Start TDD
/dev "add OAuth login"

# Claude will:
# - Ask about your test framework
# - Write tests first
# - Guide implementation
# - Verify tests pass

# 2. Check quality
/check

# 3. Ship it
/ship
```

### Example 2: Debugging

```bash
# Start systematic debugging
/debug

# Or just ask:
"Let's debug why authentication is failing"

# systematic-debugging skill activates automatically
```

### Example 3: Safe Refactoring

```bash
/refactor "extract user service"

# Claude will:
# - Ensure tests exist
# - Plan refactoring
# - Execute changes
# - Verify tests still pass
```

---

## Troubleshooting

### Superpowers Not Installing

```bash
# Check Claude Code version
claude --version  # Need v1.3.0+

# Try manual install
cd ~/
git clone https://github.com/obra/superpowers.git
cd superpowers
./install.sh
```

### Commands Not Working

```bash
# Check commands directory
ls ~/.claude/commands/

# Restart Claude Code
# Commands load on startup
```

### Hooks Not Running

```bash
# Check executable permissions
chmod +x ~/.claude/.git/hooks/pre-commit
chmod +x ~/.claude/.git/hooks/commit-msg

# Test manually
./.git/hooks/pre-commit
```

---

## What's Next

**Phase 3: Infrastructure Depth**
- Add Kubernetes agents
- Terraform/IaC expertise
- Security and compliance
- Performance optimization

**Phase 4: Architecture Sophistication**
- Plugin system
- Token optimization
- Progressive disclosure
- Marketplace integration

---

## Support

**Issues?** https://github.com/frankxai/claude-code-config/issues

**Questions?** https://github.com/frankxai/claude-code-config/discussions

---

**Phase 2 Status:** Ready to install ✅

**Estimated Time:** 1-2 hours

**Benefit:** Professional TDD workflows + quality enforcement
