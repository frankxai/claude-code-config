# Next.js Project Template - .claude.md

This is a template `.claude.md` file for Next.js projects. Copy this to the root of your Next.js project and customize as needed.

---

# [Your Project Name]

> Brief description of what this project does

## Tech Stack

- **Framework**: Next.js 15+ (App Router)
- **Language**: TypeScript
- **Styling**: Tailwind CSS v4
- **UI Components**: shadcn/ui
- **Database**: [Supabase / Neon / Prisma + PostgreSQL]
- **Authentication**: [Supabase Auth / NextAuth.js]
- **Deployment**: Vercel

## Project Structure

```
app/
├── (auth)/          # Authentication routes (login, signup)
├── (marketing)/     # Public marketing pages
├── dashboard/       # Protected dashboard area
├── api/            # API routes
└── layout.tsx      # Root layout

components/
├── ui/             # shadcn components (auto-generated)
├── auth/           # Authentication components
├── dashboard/      # Dashboard-specific components
└── marketing/      # Marketing page components

lib/
├── db.ts           # Database client
├── auth.ts         # Authentication utilities
├── utils.ts        # Helper functions
└── validations.ts  # Zod schemas

actions/
├── auth-actions.ts
└── [feature]-actions.ts

hooks/
├── use-user.ts
└── use-[feature].ts
```

## Development Guidelines

### File Editing

When modifying files, prefer **partial edits** using this pattern:

```typescript
// ... existing code ...

// <CHANGE> Brief description of change
[your new/modified code here]

// ... existing code ...
```

### Context Gathering

Before making changes:

1. **Search broadly** - Use GrepRepo to find all relevant files
2. **Examine all matches** - Don't stop at the first result
3. **Understand relationships** - Check parent components, utilities, patterns
4. **Verify approach** - Ensure you're editing the right files

### Component Patterns

```typescript
// ✅ Server Component (default)
async function UserDashboard({ userId }: Props) {
  const user = await db.user.findUnique({ where: { id: userId } })
  return <DashboardView user={user} />
}

// ✅ Client Component (when needed)
'use client'
function InteractiveChart({ data }: Props) {
  const [selected, setSelected] = useState(null)
  return <Chart data={data} onSelect={setSelected} />
}
```

### Data Fetching

```typescript
// ✅ Server Component - Direct fetch
async function Page() {
  const data = await db.posts.findMany()
  return <PostList posts={data} />
}

// ✅ Client Component - SWR
'use client'
function Page() {
  const { data } = useSWR('/api/posts', fetcher)
  return <PostList posts={data} />
}

// ❌ Never fetch in useEffect
```

### Server Actions

```typescript
'use server'

import { revalidatePath } from 'next/cache'
import { z } from 'zod'

const schema = z.object({
  title: z.string().min(1),
  content: z.string(),
})

export async function createPost(formData: FormData) {
  const session = await auth()
  if (!session) throw new Error('Unauthorized')

  const data = schema.parse({
    title: formData.get('title'),
    content: formData.get('content'),
  })

  await db.post.create({
    data: { ...data, authorId: session.user.id }
  })

  revalidatePath('/dashboard')
  return { success: true }
}
```

## Design System

### Colors

We use exactly **3-5 colors**:
- **Primary**: [Your primary brand color]
- **Neutrals**: white, gray scale, black
- **Accent**: [Your accent color]

All colors use semantic design tokens defined in `app/globals.css`:

```tsx
// ✅ Use tokens
<div className="bg-background text-foreground border-border">

// ❌ Don't use direct colors
<div className="bg-white text-black border-gray-200">
```

### Typography

We use **2 font families**:
- **Headings**: [Font name] (weights: 400, 600, 700)
- **Body**: [Font name] (weights: 400, 600)

```tsx
<h1 className="font-sans text-4xl font-bold">
<code className="font-mono text-sm">
```

### Spacing

Use Tailwind's spacing scale:

```tsx
// ✅ Good
<div className="p-4 gap-6 mx-2">

// ❌ Bad
<div className="p-[16px] gap-[24px] mx-[8px]">
```

### Responsive Design

Mobile-first approach:

```tsx
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3">
<h1 className="text-2xl md:text-3xl lg:text-4xl">
```

## Database

### [If using Supabase]

```typescript
// lib/supabase/client.ts
import { createBrowserClient } from '@supabase/ssr'

export function createClient() {
  return createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
  )
}

// lib/supabase/server.ts - Use in Server Components/Actions
```

**Security Rules:**
- ALWAYS use Row Level Security (RLS)
- Never expose service role key to client
- Validate all inputs on server

### [If using Neon]

```typescript
// lib/db.ts
import { neon } from '@neondatabase/serverless'

export const sql = neon(process.env.DATABASE_URL!)

// Usage
const users = await sql`SELECT * FROM users WHERE id = ${id}`
```

### [If using Prisma]

```typescript
// lib/db.ts
import { PrismaClient } from '@prisma/client'

const globalForPrisma = globalThis as unknown as {
  prisma: PrismaClient | undefined
}

export const db = globalForPrisma.prisma ?? new PrismaClient()

if (process.env.NODE_ENV !== 'production') globalForPrisma.prisma = db
```

## Authentication

### [If using Supabase Auth]

```typescript
// Middleware protection
export async function middleware(request: NextRequest) {
  const supabase = createServerClient(...)
  const { data: { user } } = await supabase.auth.getUser()

  if (!user && request.nextUrl.pathname.startsWith('/dashboard')) {
    return NextResponse.redirect(new URL('/login', request.url))
  }
}

// Server Component auth check
async function ProtectedPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) redirect('/login')

  return <Dashboard user={user} />
}
```

## Environment Variables

```bash
# Database
DATABASE_URL="postgresql://..."
NEXT_PUBLIC_SUPABASE_URL="https://..."
NEXT_PUBLIC_SUPABASE_ANON_KEY="..."
SUPABASE_SERVICE_ROLE_KEY="..." # Server-only

# Authentication
NEXTAUTH_URL="http://localhost:3000"
NEXTAUTH_SECRET="..." # Server-only

# Payments
STRIPE_SECRET_KEY="sk_..." # Server-only
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY="pk_..."

# AI (if using)
OPENAI_API_KEY="sk-..." # Server-only
```

## Key Dependencies

```json
{
  "dependencies": {
    "next": "^15.0.0",
    "react": "^19.0.0",
    "react-dom": "^19.0.0",
    "typescript": "^5.3.3",

    "@supabase/ssr": "^0.1.0",
    "@supabase/supabase-js": "^2.39.0",

    "zod": "^3.22.4",
    "swr": "^2.2.4",

    "tailwindcss": "^4.0.0",
    "class-variance-authority": "^0.7.0",
    "clsx": "^2.1.0",
    "tailwind-merge": "^2.2.0",

    "lucide-react": "^0.300.0"
  }
}
```

## Scripts

```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "type-check": "tsc --noEmit"
  }
}
```

## Best Practices Checklist

When working on this project, always:

- [ ] Read files before editing them
- [ ] Use partial edits with `// ... existing code ...`
- [ ] Search all matches, not just the first one
- [ ] Use Server Components by default
- [ ] Only add "use client" when absolutely necessary
- [ ] Validate all inputs on the server with Zod
- [ ] Use semantic design tokens (bg-background, etc.)
- [ ] Follow mobile-first responsive design
- [ ] Implement proper loading states
- [ ] Add meaningful error handling
- [ ] Include accessibility attributes (ARIA, alt text)
- [ ] Test in both light and dark modes
- [ ] Ensure proper color contrast
- [ ] Use TypeScript strictly
- [ ] Keep components small and focused

## Common Patterns

### Form with Server Action

```typescript
// components/forms/create-post-form.tsx
'use client'

import { useFormStatus } from 'react-dom'
import { createPost } from '@/actions/post-actions'

function SubmitButton() {
  const { pending } = useFormStatus()
  return (
    <button disabled={pending}>
      {pending ? 'Creating...' : 'Create Post'}
    </button>
  )
}

export function CreatePostForm() {
  return (
    <form action={createPost}>
      <input name="title" required />
      <textarea name="content" required />
      <SubmitButton />
    </form>
  )
}
```

### Protected Route

```typescript
// app/dashboard/page.tsx
import { redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase/server'

export default async function DashboardPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) redirect('/login')

  return <Dashboard user={user} />
}
```

### SWR Hook

```typescript
// hooks/use-posts.ts
import useSWR from 'swr'

const fetcher = (url: string) => fetch(url).then(r => r.json())

export function usePosts() {
  const { data, error, isLoading, mutate } = useSWR('/api/posts', fetcher)

  return {
    posts: data,
    isLoading,
    isError: error,
    refresh: mutate,
  }
}
```

## Testing Approach

```typescript
// Prefer testing user-facing behavior
// Use Playwright for E2E tests
// Use Jest + Testing Library for component tests
```

## Deployment

**Vercel** (Recommended):
1. Push to GitHub
2. Import repository in Vercel
3. Add environment variables
4. Deploy

**Environment Variables in Vercel:**
- Add all variables from `.env.local`
- Use Vercel integrations for supported services
- Keep secrets server-only (no NEXT_PUBLIC_ prefix)

## Notes

[Add any project-specific notes, quirks, or important context here]

## Resources

- [Next.js Documentation](https://nextjs.org/docs)
- [Tailwind CSS](https://tailwindcss.com/docs)
- [shadcn/ui](https://ui.shadcn.com)
- [Supabase Docs](https://supabase.com/docs)
- [Vercel AI SDK](https://sdk.vercel.ai/docs)

---

**Remember**: Follow the patterns in `.claude/knowledge/nextjs-best-practices.md` and `.claude/knowledge/design-system-guidelines.md` for consistency across the project.
