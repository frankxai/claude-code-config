# ⚙️ Customization Guide

Make this Claude Code configuration your own.

## Quick Customization

### 1. Personal Instructions (CLAUDE.md)

Edit `~/.claude/CLAUDE.md`:

```bash
nano ~/.claude/CLAUDE.md
```

#### Project Paths

Update with your actual projects:

```markdown
## Project Paths
- **Main Project**: `/Users/you/projects/my-app`
- **Work Backend**: `/Users/you/work/api`
- **Side Project**: `/Users/you/hobby/game`
```

On Windows/WSL, use:
```markdown
- **Windows Project**: `/mnt/c/Users/YourName/Projects/app`
- **WSL Project**: `/home/you/projects/app`
```

#### Code Preferences

```markdown
## Preferences
- **Framework Choices**: Next.js, FastAPI, Django
- **Styling**: Tailwind CSS, shadcn/ui
- **State Management**: Zustand, React Query
- **Backend**: Supabase, PostgreSQL, Redis
- **AI/ML**: OpenAI GPT-4, Claude, Anthropic
- **Testing**: Vitest, Playwright, Jest
```

#### Custom Instructions

```markdown
## Custom Instructions

### When Writing Code
- Always use TypeScript strict mode
- Prefer functional components with hooks
- Write JSDoc comments for all functions
- Use Zod for runtime validation

### When Committing
- Follow Conventional Commits (feat:, fix:, etc.)
- Include ticket numbers: "feat: add login (#123)"
- Keep commits atomic and focused

### Communication
- Be extra concise - I value brevity
- Skip explanations, show me the code
- Suggest improvements proactively
```

### 2. Local Settings (settings.local.json)

Edit `~/.claude/settings.local.json`:

```bash
nano ~/.claude/settings.local.json
```

#### Add MCP Servers

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_your_token"
      }
    },
    "linear": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-linear"],
      "env": {
        "LINEAR_API_KEY": "lin_api_your_key"
      }
    },
    "notion": {
      "command": "npx",
      "args": ["-y", "@notionhq/client-mcp"],
      "env": {
        "NOTION_API_KEY": "secret_your_key"
      }
    }
  }
}
```

#### Machine-Specific Overrides

```json
{
  "workMachine": true,
  "autoSave": true,
  "preferredEditor": "cursor",
  "customPaths": {
    "workspace": "/Users/you/workspace"
  }
}
```

## Advanced Customization

### Custom Agents

#### Creating a Domain Expert

```bash
nano ~/.claude/agents/python-backend-expert.md
```

```markdown
# Python Backend Expert

You are a senior Python backend developer specialized in FastAPI, SQLAlchemy, and async patterns.

## Expertise

- FastAPI with Pydantic v2
- SQLAlchemy 2.0 (async)
- PostgreSQL with asyncpg
- Redis caching
- Celery task queues
- Docker containerization

## Workflow

### When Building APIs:
1. Design Pydantic schemas first
2. Create SQLAlchemy models
3. Implement repository pattern
4. Write service layer logic
5. Add API endpoints
6. Write tests (pytest + httpx)
7. Add OpenAPI documentation

### Code Style:
- Use type hints everywhere
- Follow PEP 8 and Black formatting
- Write docstrings (Google style)
- Prefer async/await over sync
- Use dependency injection

### Testing:
- pytest for all tests
- httpx for async API testing
- Factory Boy for test fixtures
- Aim for 80%+ coverage

## Tools

Primary:
- pytest (testing)
- ruff (linting)
- mypy (type checking)
- black (formatting)

Support:
- Docker (containerization)
- PostgreSQL (database)
- Redis (caching)

## Example Patterns

### FastAPI Endpoint
\`\`\`python
from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession

router = APIRouter(prefix="/api/v1")

@router.get("/users/{user_id}")
async def get_user(
    user_id: int,
    db: AsyncSession = Depends(get_db)
) -> UserResponse:
    user = await user_service.get_by_id(db, user_id)
    return UserResponse.from_orm(user)
\`\`\`
```

#### Creating a Framework Specialist

```bash
nano ~/.claude/agents/nextjs-expert.md
```

```markdown
# Next.js Expert

You are a Next.js expert focused on App Router, Server Components, and modern React patterns.

## Expertise

- Next.js 14+ App Router
- React Server Components
- Server Actions
- Streaming and Suspense
- Incremental Static Regeneration
- Edge Runtime optimization

## Patterns

### Route Structure
\`\`\`
app/
├── (auth)/           # Route group
│   ├── login/
│   └── signup/
├── (dashboard)/
│   ├── layout.tsx    # Nested layout
│   └── page.tsx
└── api/
    └── route.ts      # API route
\`\`\`

### Server Component
\`\`\`typescript
// app/page.tsx - Server Component by default
import { db } from '@/lib/db'

export default async function Page() {
  const data = await db.query.users.findMany()
  return <UserList users={data} />
}
\`\`\`

### Server Action
\`\`\`typescript
// app/actions.ts
'use server'

export async function createUser(formData: FormData) {
  const name = formData.get('name')
  await db.insert(users).values({ name })
  revalidatePath('/users')
}
\`\`\`

## Tools

- TypeScript for all code
- Tailwind CSS for styling
- Zod for validation
- Server Actions over API routes
- React Suspense for loading states
```

### Custom Slash Commands

#### Quick Commit Command

```bash
nano ~/.claude/commands/quick-commit.md
```

```markdown
Analyze git status and git diff, then:
1. Create a clear, conventional commit message
2. Stage all changes
3. Commit with the message
4. Push to current branch

Use format: `type(scope): description`
Types: feat, fix, docs, style, refactor, test, chore
```

Usage: `/quick-commit`

#### Test Runner Command

```bash
nano ~/.claude/commands/test.md
```

```markdown
Run the project's test suite:
1. Detect test framework (Jest, Vitest, Pytest, etc.)
2. Run all tests
3. If failures, show detailed output
4. Suggest fixes for failing tests
5. Optionally fix and re-run
```

Usage: `/test`

#### Deploy Command

```bash
nano ~/.claude/commands/deploy.md
```

```markdown
Deploy the current project:
1. Run build to check for errors
2. Run tests to verify functionality
3. Check git status (should be clean)
4. Ask which environment (staging/production)
5. Execute deployment (Vercel, Railway, etc.)
6. Verify deployment success
7. Provide deployment URL
```

Usage: `/deploy`

### Custom Skills

#### Your Company's Stack

```bash
mkdir -p ~/.claude/skills/company-stack
nano ~/.claude/skills/company-stack/SKILL.md
```

```markdown
# Company Stack Expertise

## Our Tech Stack

### Frontend
- Next.js 14 (App Router only)
- TypeScript (strict mode)
- Tailwind CSS + shadcn/ui
- React Query for data fetching
- Zustand for state management

### Backend
- Next.js API Routes
- Supabase (auth, database, storage)
- Prisma ORM
- PostgreSQL database

### Infrastructure
- Vercel for hosting
- Supabase for backend services
- GitHub for version control
- Linear for project management

## Coding Standards

### File Structure
\`\`\`
src/
├── app/              # Next.js App Router
├── components/       # React components
│   ├── ui/          # shadcn components
│   └── features/    # Feature components
├── lib/             # Utilities
├── hooks/           # Custom hooks
├── types/           # TypeScript types
└── styles/          # Global styles
\`\`\`

### Naming Conventions
- Components: PascalCase (`UserProfile.tsx`)
- Utilities: camelCase (`formatDate.ts`)
- Constants: SCREAMING_SNAKE_CASE (`API_URL`)
- Types: PascalCase with `Type` suffix (`UserType`)

### Component Pattern
\`\`\`typescript
interface ComponentProps {
  prop1: string
  prop2?: number
}

export function Component({ prop1, prop2 = 0 }: ComponentProps) {
  // Component logic
  return <div>...</div>
}
\`\`\`

## Common Patterns

### Data Fetching (Server Component)
\`\`\`typescript
import { createServerComponentClient } from '@/lib/supabase-server'

export default async function Page() {
  const supabase = createServerComponentClient()
  const { data } = await supabase.from('users').select('*')
  return <UserList users={data} />
}
\`\`\`

### Form Handling (Server Action)
\`\`\`typescript
'use server'
import { z } from 'zod'

const schema = z.object({
  email: z.string().email(),
  password: z.string().min(8)
})

export async function handleSubmit(formData: FormData) {
  const validated = schema.parse({
    email: formData.get('email'),
    password: formData.get('password')
  })
  // Handle form
}
\`\`\`

## Deployment

### Pre-Deployment Checklist
- [ ] All tests passing
- [ ] No TypeScript errors
- [ ] No ESLint errors
- [ ] Environment variables set
- [ ] Database migrations run
- [ ] Build succeeds locally

### Deployment Process
1. Push to main branch
2. Vercel auto-deploys
3. Supabase migrations run
4. Verify deployment at preview URL
5. Promote to production if tests pass
```

### Hooks and Automation

#### Pre-Commit Hook

Edit `~/.claude/settings.json`:

```json
{
  "hooks": {
    "beforeToolCall": {
      "Bash(git commit*)": {
        "command": "npm run lint && npm run type-check",
        "continueOnError": false
      }
    }
  }
}
```

#### Auto-Format on Save

```json
{
  "hooks": {
    "afterToolCall": {
      "Write(*.ts)": {
        "command": "npx prettier --write {{filepath}}"
      },
      "Write(*.tsx)": {
        "command": "npx prettier --write {{filepath}}"
      }
    }
  }
}
```

### Permission Customization

Edit `~/.claude/settings.json`:

#### Ask Before Destructive Operations

```json
{
  "permissionRules": [
    {
      "tool": "Bash(rm *)",
      "permission": "ask",
      "comment": "Confirm before deleting files"
    },
    {
      "tool": "Bash(git push --force*)",
      "permission": "ask",
      "comment": "Confirm force pushes"
    }
  ]
}
```

#### Auto-Allow Safe Operations

```json
{
  "permissionRules": [
    {
      "tool": "Bash(npm install*)",
      "permission": "allow",
      "comment": "Auto-allow npm installs"
    },
    {
      "tool": "Bash(git status*)",
      "permission": "allow"
    }
  ]
}
```

## Platform-Specific Customization

### macOS

```markdown
## Project Paths (macOS)
- **Main**: `/Users/yourname/projects/app`
- **Work**: `/Users/yourname/work/backend`

## Preferences
- **Terminal**: iTerm2 with zsh
- **Package Manager**: Homebrew
- **Node Version Manager**: nvm
```

### Windows/WSL

```markdown
## Project Paths (Windows/WSL)
- **Main**: `/mnt/c/Users/YourName/Projects/app`
- **WSL Native**: `/home/you/projects/app`

## Preferences
- **Terminal**: Windows Terminal with Ubuntu
- **Package Manager**: apt for system, npm for Node
- **Path Conversion**: Automatic via /mnt/c mapping
```

### Linux

```markdown
## Project Paths (Linux)
- **Main**: `/home/you/projects/app`
- **System**: `/opt/app`

## Preferences
- **Terminal**: Alacritty or Kitty
- **Package Manager**: apt / dnf / pacman
- **Node Version Manager**: fnm or asdf
```

## Team Customization

### Shared Team Config

Create a team repo:

```bash
git clone https://github.com/your-org/claude-config-team.git
cd claude-config-team
./install.sh
```

Add to `~/.claude/CLAUDE.md`:

```markdown
## Team Standards

Follow team config from:
`/path/to/claude-config-team`

Team-specific agents:
- company-backend-expert
- company-frontend-expert
- company-devops-expert
```

### Override Team Defaults

In `~/.claude/settings.local.json`:

```json
{
  "teamConfig": "/path/to/claude-config-team",
  "overrides": {
    "preferredEditor": "cursor",
    "autoCommit": false
  }
}
```

## Environment-Specific Configuration

### Development Environment

```json
{
  "env": "development",
  "autoCommit": true,
  "verboseLogging": true,
  "testOnSave": true
}
```

### Production Environment

```json
{
  "env": "production",
  "autoCommit": false,
  "requireApproval": true,
  "testOnSave": true,
  "deploymentChecks": true
}
```

## Troubleshooting Customization

### Config Not Loading

```bash
# Verify file syntax
cat ~/.claude/settings.json | jq .

# Check file permissions
ls -la ~/.claude/

# View Claude logs
tail -f ~/.claude/debug/*.log
```

### Conflicts Between Configs

Priority order:
1. `settings.local.json` (highest)
2. `~/.claude/settings.json`
3. Project `.claude/settings.json`
4. Default settings (lowest)

### Testing Changes

```bash
# Backup current config
cp -r ~/.claude ~/.claude.backup

# Make changes
nano ~/.claude/settings.json

# Test with simple command
# If broken, restore:
rm -rf ~/.claude
mv ~/.claude.backup ~/.claude
```

## Best Practices

1. **Keep Private Configs Private**: Never commit CLAUDE.md or settings.local.json
2. **Document Custom Patterns**: Add comments to your agents and skills
3. **Version Control**: Sync public configs to your fork regularly
4. **Test Incrementally**: Add one customization at a time
5. **Share with Team**: Useful patterns → team config repo

## Next Steps

1. **Personalize CLAUDE.md** with your projects and preferences
2. **Add Your Tools** to settings.local.json
3. **Create First Custom Agent** for your workflow
4. **Build Team Config** if working with others
5. **Iterate and Improve** based on usage

---

[← Agents Guide](./AGENTS_GUIDE.md) | [Skills Guide](./SKILLS_GUIDE.md) | [Back to README](../README.md)
