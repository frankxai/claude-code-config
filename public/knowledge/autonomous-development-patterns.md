# Autonomous Development Patterns

Advanced patterns for autonomous and semi-autonomous development workflows. Based on proven approaches from Devin AI, Windsurf, and other leading AI development tools.

## Table of Contents

1. [Core Principles](#core-principles)
2. [Context Gathering Strategies](#context-gathering-strategies)
3. [Decision-Making Frameworks](#decision-making-frameworks)
4. [Code Modification Patterns](#code-modification-patterns)
5. [Testing Strategies](#testing-strategies)
6. [Environment Handling](#environment-handling)
7. [Refactoring Workflows](#refactoring-workflows)

## Core Principles

### 1. Information-First Strategy

**NEVER assume. ALWAYS verify.**

```
❌ BAD: Assume library is available
import { someFunction } from 'well-known-library'

✅ GOOD: Check first
1. Search package.json for library
2. If not found, check if it should be added
3. Ask user or add to dependencies
4. Then import
```

**Key Rule from Devin**: "NEVER assume that a given library is available, even if it is well known."

### 2. Contextual Code Mimicry

**Match the existing codebase style automatically.**

Instead of imposing external standards:
1. **Analyze existing patterns** in the codebase
2. **Replicate conventions** (naming, structure, patterns)
3. **Maintain coherence** with existing code

```typescript
// Existing codebase uses:
const getUserById = async (id: string) => { ... }
const getPostById = async (id: string) => { ... }

// ✅ GOOD: Follow the pattern
const getCommentById = async (id: string) => { ... }

// ❌ BAD: Impose different style
async function fetchComment(commentId: string) { ... }
```

### 3. Conservative Tool Usage

**From Windsurf**: "Only call tools when they are absolutely necessary."

Before using a tool, ask:
- Do I already have this information in context?
- Can I infer this from existing knowledge?
- Is this tool call essential to proceed?

```
❌ BAD: Excessive tool usage
- Read file to check if it exists
- Read file again to see imports
- Read file a third time to understand structure

✅ GOOD: Efficient approach
- Read file once
- Extract all needed information
- Cache in memory for session
```

### 4. Plan Before Execute

**Dual-mode operation** from Devin:
- **Planning Mode**: Gather context, understand scope
- **Execution Mode**: Make precise changes

```
Planning Phase:
1. Understand the full scope
2. Identify all affected files
3. Plan the sequence of changes
4. Anticipate side effects

Execution Phase:
1. Make changes systematically
2. Update all references
3. Verify changes
4. Test
```

## Context Gathering Strategies

### Systematic Reference Tracking

When modifying code, use LSP tools to find ALL references:

```
Workflow:
1. Identify what you're changing (function, class, interface)
2. Find ALL references across codebase
3. Analyze impact of change on each reference
4. Update ALL references comprehensively
5. Verify no broken references remain
```

**Why**: Prevents fragmentation in large refactors.

### Multi-Layer Context Building

Build context in layers:

**Layer 1: Direct Context**
- File being modified
- Imports of that file
- Direct dependencies

**Layer 2: Related Context**
- Files that import this file
- Related utilities
- Shared types/interfaces

**Layer 3: Pattern Context**
- Similar patterns elsewhere
- Existing conventions
- Related features

**Layer 4: Architectural Context**
- Overall file structure
- Design patterns in use
- Technology choices

### Before-After Analysis

Before modifying code:

```typescript
// 1. Read current implementation
const currentCode = await readFile('component.tsx')

// 2. Understand context
const imports = extractImports(currentCode)
const dependencies = checkDependencies(imports)
const usagePatterns = findUsagePatterns('component')

// 3. Plan modifications
const modifications = planChanges({
  current: currentCode,
  dependencies,
  patterns: usagePatterns
})

// 4. Execute with full context
applyModifications(modifications)

// 5. Verify all references still work
verifyReferences('component')
```

## Decision-Making Frameworks

### Critical Reflection Points

From Devin: Use structured thinking before:

1. **Git Operations**
   ```
   Before commit:
   - What files are being committed?
   - Are any secrets included? ❌
   - Is the commit message clear?
   - Does this belong in one commit or should be split?
   ```

2. **Code Transitions** (major refactors)
   ```
   Before refactoring:
   - What's the scope of impact?
   - Are tests in place?
   - Can this be done incrementally?
   - What's the rollback plan?
   ```

3. **Completion Claims**
   ```
   Before marking as complete:
   - Does it actually work?
   - Are all edge cases handled?
   - Are tests passing?
   - Is documentation updated?
   ```

### Approach Selection Framework

When multiple approaches are possible:

```markdown
## Approach Analysis

**Option 1: [Name]**
- Implementation complexity: [Low/Medium/High]
- Maintenance burden: [Low/Medium/High]
- Performance impact: [Positive/Neutral/Negative]
- Aligns with existing patterns: [Yes/No]
- Risk level: [Low/Medium/High]

**Option 2: [Name]**
[Same analysis]

**Recommendation**: [Option X]
**Reasoning**: [Why this option is best given the context]
```

### Safety-First Decision Making

From Windsurf - Hard boundaries on automation:

**NEVER auto-run:**
- Destructive commands (`rm -rf`, `DROP TABLE`)
- System-level changes (`sudo` commands)
- Irreversible operations (force push, hard reset)
- Commands that cost money (cloud deployments)
- Network operations without explicit permission

**ALWAYS ask before:**
- Installing dependencies
- Making schema changes
- Deploying to production
- Modifying configuration files
- External API calls

## Code Modification Patterns

### Precision-First Coding

From Replit: "Your code modifications MUST be precise and accurate WITHOUT creative extensions unless explicitly asked."

```typescript
// User: "Add a loading state to the button"

// ❌ BAD: Creative extension
<Button
  loading={loading}
  disabled={loading || disabled}
  onClick={handleClick}
  // ADDED: Success animation
  onSuccess={showSuccessAnimation}
  // ADDED: Error handling
  onError={showErrorToast}
>

// ✅ GOOD: Precise change
<Button
  loading={loading}
  disabled={loading}
  onClick={handleClick}
>
```

**Rule**: Only implement what was explicitly requested.

### Systematic Reference Updates

When renaming or moving:

```typescript
// Step 1: Find all references
const references = await findAllReferences('OldComponentName')

// Step 2: Group by file
const fileGroups = groupByFile(references)

// Step 3: Update each file
for (const file of fileGroups) {
  updateReferencesInFile(file, 'OldComponentName', 'NewComponentName')
}

// Step 4: Update imports
updateAllImports('old-path', 'new-path')

// Step 5: Verify
const remaining = await findAllReferences('OldComponentName')
if (remaining.length > 0) {
  console.error('Missed references:', remaining)
}
```

### Incremental Modification Strategy

For large changes:

```
Phase 1: Preparation
- Add new code alongside old
- Ensure both work simultaneously
- Add feature flags if needed

Phase 2: Migration
- Gradually switch references to new code
- Monitor for issues
- Keep old code as fallback

Phase 3: Cleanup
- Remove old code once fully migrated
- Clean up feature flags
- Update documentation
```

## Testing Strategies

### Test-First Validation

**From Devin**: "NEVER modify tests to pass; instead, assume implementation bugs."

```typescript
// ❌ BAD: Test failing? Change the test.
test('user can login', () => {
  // Test expects redirect to /dashboard
  // But app redirects to /home
  // So change test to expect /home
  expect(location.pathname).toBe('/home') // ❌ Wrong!
})

// ✅ GOOD: Test failing? Fix the implementation.
test('user can login', () => {
  expect(location.pathname).toBe('/dashboard')
  // If this fails, fix the redirect logic, not the test
})
```

**Principle**: Tests define correct behavior. Implementation must match tests, not vice versa.

### Comprehensive Test Coverage

Before completing a feature:

```
✓ Unit tests for new functions
✓ Integration tests for workflows
✓ Edge cases covered
✓ Error cases handled
✓ Regression tests for bugs fixed
```

### Test-Driven Debugging

When fixing bugs:

```
1. Write a failing test that reproduces the bug
2. Verify the test actually fails
3. Fix the implementation
4. Verify the test now passes
5. Keep the test to prevent regression
```

## Environment Handling

### Environment Pragmatism

From Devin: "Instead of fixing local environment issues independently, report them and find workarounds."

```
❌ BAD: Try to fix user's local environment
"I'll install Python 3.11 for you..."
"Let me configure your Docker setup..."

✅ GOOD: Work within constraints
"I see Python 3.11 isn't available locally.
Options:
1. Run tests in CI instead
2. Use Python 3.9 (already installed)
3. Document requirement for user to install

I'll use option 1 (CI) to proceed."
```

**Respect System Boundaries**: Don't assume ability to modify user's system.

### Immediate Runnable Code

From Windsurf: "Generated code must be immediately executable with all dependencies included."

```typescript
// ❌ BAD: Missing dependencies
import { something } from 'not-installed-package'

// ✅ GOOD: Check and install first
// First, add to package.json:
{
  "dependencies": {
    "not-installed-package": "^1.0.0"
  }
}

// Then use:
import { something } from 'not-installed-package'
```

## Refactoring Workflows

### Safe Refactoring Pattern

```
1. Ensure tests exist and pass
2. Make small, incremental changes
3. Run tests after each change
4. Commit working states frequently
5. Never break existing functionality
```

### Large-Scale Refactoring

```
Phase 1: Analysis
- Understand current architecture
- Identify all affected areas
- Map dependencies
- Plan migration path

Phase 2: Preparation
- Add tests if missing
- Create new abstractions
- Keep old code working

Phase 3: Gradual Migration
- Move piece by piece
- Test continuously
- Monitor for issues

Phase 4: Cleanup
- Remove old code
- Update documentation
- Final verification
```

### Refactoring Safety Checklist

Before refactoring:
- [ ] Tests exist and pass
- [ ] I understand all affected code
- [ ] I have a rollback plan
- [ ] Changes can be done incrementally
- [ ] No functionality will break
- [ ] All references have been found
- [ ] Documentation will be updated

## Batched Tool Operations

**From Lovable**: "For maximum efficiency, whenever you need to perform multiple independent operations, always invoke all relevant tools simultaneously."

```typescript
// ❌ BAD: Sequential operations
await readFile('a.ts')
await readFile('b.ts')
await readFile('c.ts')

// ✅ GOOD: Parallel operations
await Promise.all([
  readFile('a.ts'),
  readFile('b.ts'),
  readFile('c.ts')
])
```

**Benefits**:
- Reduced latency
- Improved workflow efficiency
- Better user experience

## Memory and Context Management

### Persistent Memory System

From Windsurf: Preserve context across sessions proactively.

**What to remember**:
- Project-specific patterns
- User preferences
- Architecture decisions
- Important constraints
- Past decisions and rationale

**When to save memory**:
- After important decisions
- When learning project patterns
- After user clarifications
- Before conversation might end

### Context-Aware File Reading

From Lovable: "NEVER read files already in the 'useful-context' section."

```
Before reading a file:
1. Check if already in context
2. If yes, use cached version
3. If no, read and add to context
4. Mark as useful-context for future reference
```

## Autonomous Work Principles

### Agentic Independence with Collaboration

From Windsurf: "Work both independently and collaboratively with a USER."

**Independent Work**:
- Gathering context
- Finding solutions
- Implementing straightforward changes
- Running tests
- Finding documentation

**Collaborative Work**:
- Major architectural decisions
- Ambiguous requirements
- Design choices
- Deployment decisions
- Breaking changes

### Progress Communication

Keep user informed without overwhelming:

```
✅ GOOD: Concise updates
"Implementing authentication... Found 3 files to update."
"Updated auth logic. Running tests..."
"Tests passing. Authentication complete."

❌ BAD: Verbose updates
"I'm now going to implement authentication by first reading
the current implementation, then I'll analyze the patterns..."
```

## Quality Standards

### Code Quality Checklist

Before completion:
- [ ] Follows existing code patterns
- [ ] All references updated
- [ ] Tests pass
- [ ] No unused imports
- [ ] No debugging code left
- [ ] Proper error handling
- [ ] TypeScript errors resolved
- [ ] Documentation updated

### Self-Review Process

```
1. Read the changed code as if reviewing a PR
2. Check for logic errors
3. Verify edge cases handled
4. Ensure performance acceptable
5. Confirm security considerations
6. Validate accessibility
7. Review for maintainability
```

## Anti-Patterns to Avoid

### ❌ Assumption-Driven Development
```
Don't assume:
- Libraries are installed
- Functions exist
- User wants extra features
- Current approach is optimal
```

### ❌ Test Modification to Pass
```
Don't change tests to match broken code.
Change code to match correct tests.
```

### ❌ Breaking References
```
Don't change names/signatures without updating all references.
Use LSP tools to find ALL usages.
```

### ❌ Environment Overreach
```
Don't try to fix user's system.
Work within given constraints.
```

### ❌ Premature Optimization
```
Don't optimize before measuring.
Focus on correctness first.
```

## Success Metrics

You're being autonomous effectively when:
- ✅ Code works on first try
- ✅ No broken references
- ✅ Tests pass without modification
- ✅ Follows existing patterns
- ✅ User doesn't need to fix your work
- ✅ Changes are complete and thorough
- ✅ Security and safety maintained

## Remember

**Information first. Precision in execution. Safety always.**

Autonomy means making good decisions independently, not making all decisions independently.
