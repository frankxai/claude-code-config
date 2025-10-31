# Next.js & Vercel Best Practices

This document captures proven patterns and best practices for Next.js development, based on V0's system and industry standards.

## Table of Contents

1. [Context Gathering](#context-gathering)
2. [File Organization](#file-organization)
3. [Code Patterns](#code-patterns)
4. [Database Integration](#database-integration)
5. [AI Integration](#ai-integration)
6. [Performance](#performance)
7. [Security](#security)

## Context Gathering

### Search Hierarchy

Use this systematic approach for maximum efficiency:

1. **GrepRepo** - Quick keyword/pattern searches
2. **LSRepo** - Understand file structure
3. **ReadFile** - Examine specific files
4. **SearchRepo** - Comprehensive fallback

### Search Strategy: Broad → Specific → Verify

```
❌ BAD: Immediately edit first file found
✅ GOOD: Search all matches → Understand relationships → Verify approach → Edit
```

### Critical Rules

**Don't Stop at First Match:**
- Multiple files found? Examine ALL of them
- Found a component? Check if it's the right variant
- Look beyond obvious: parents, wrappers, utilities, similar patterns

**Understand Full System Before Changes:**

| Scenario | What to Check First |
|----------|-------------------|
| Layout issues | Parents, wrappers, global styles |
| Adding features | Existing similar implementations |
| State changes | Where state lives and flows |
| API work | Existing patterns, error handling |
| Styling | Theme systems, utility classes, component variants |
| New dependencies | Existing imports - utilities may exist |
| Types/validation | Existing schemas, interfaces, validation |
| Testing | Test setup and patterns |
| Routing | Existing route structure, navigation patterns |

**Use Parallel Tool Calls:**
- Reading 3 files? → 3 parallel ReadFile calls
- No dependencies? → Execute simultaneously
- Dependencies exist? → Sequential only, NO placeholders

## File Organization

### Naming Conventions

```
✅ Components: login-form.tsx (kebab-case file, PascalCase export)
✅ Pages: app/dashboard/page.tsx
✅ API Routes: app/api/auth/route.ts
✅ Actions: actions/user-actions.ts
✅ Utils: lib/format-date.ts
```

### Project Structure

```
app/
├── (auth)/
│   ├── login/
│   │   └── page.tsx
│   └── signup/
│       └── page.tsx
├── dashboard/
│   ├── page.tsx
│   └── settings/
│       └── page.tsx
├── api/
│   └── users/
│       └── route.ts
├── layout.tsx
└── page.tsx

components/
├── ui/              # shadcn components
│   ├── button.tsx
│   └── card.tsx
├── auth/
│   └── login-form.tsx
└── dashboard/
    └── stats-card.tsx

lib/
├── db.ts
├── utils.ts
└── validations.ts

actions/
├── auth-actions.ts
└── user-actions.ts

hooks/
├── use-user.ts
└── use-toast.ts
```

### Component Organization

```typescript
// ❌ BAD: One large file
// app/dashboard/page.tsx (500 lines)

// ✅ GOOD: Split into components
// app/dashboard/page.tsx
import { StatsCards } from '@/components/dashboard/stats-cards'
import { RecentActivity } from '@/components/dashboard/recent-activity'
import { UserProfile } from '@/components/dashboard/user-profile'

export default async function DashboardPage() {
  const user = await getCurrentUser()

  return (
    <main>
      <UserProfile user={user} />
      <StatsCards userId={user.id} />
      <RecentActivity userId={user.id} />
    </main>
  )
}
```

## Code Patterns

### File Editing

**Preferred Method: Partial Edits**

```typescript
// ... existing code ...

// <CHANGE> Adding authentication check
export async function getUserData(userId: string) {
  const session = await auth()
  if (!session) throw new Error('Unauthorized')

  return db.user.findUnique({ where: { id: userId } })
}

// ... existing code ...
```

**Rules:**
- ALWAYS read file before editing
- Use `// ... existing code ...` for unchanged sections
- Include `// <CHANGE>` comments (2-5 words explaining change)
- Only write parts that need changing
- System auto-merges with original code

### Server vs Client Components

```typescript
// ✅ Server Component (default)
async function UserDashboard({ userId }: Props) {
  const user = await db.user.findUnique({ where: { id: userId } })
  return <div>{user.name}</div>
}

// ✅ Client Component (interactive)
'use client'
function ThemeToggle() {
  const [theme, setTheme] = useState('light')
  return <button onClick={() => setTheme(t => t === 'light' ? 'dark' : 'light')} />
}

// ✅ Client with server data
async function Page() {
  const data = await fetchData() // Server
  return <InteractiveComponent data={data} /> // Pass to client
}
```

### Data Fetching

```typescript
// ✅ GOOD: Server Component
async function Posts() {
  const posts = await db.post.findMany()
  return <PostList posts={posts} />
}

// ✅ GOOD: Client with SWR
'use client'
function Posts() {
  const { data: posts } = useSWR('/api/posts', fetcher)
  return <PostList posts={posts} />
}

// ❌ BAD: useEffect fetching
'use client'
function Posts() {
  const [posts, setPosts] = useState([])
  useEffect(() => {
    fetch('/api/posts').then(r => r.json()).then(setPosts)
  }, [])
  return <PostList posts={posts} />
}
```

### Server Actions

```typescript
// actions/user-actions.ts
'use server'

import { revalidatePath } from 'next/cache'
import { z } from 'zod'

const updateProfileSchema = z.object({
  name: z.string().min(2),
  email: z.string().email(),
})

export async function updateProfile(formData: FormData) {
  const session = await auth()
  if (!session) throw new Error('Unauthorized')

  const data = updateProfileSchema.parse({
    name: formData.get('name'),
    email: formData.get('email'),
  })

  await db.user.update({
    where: { id: session.user.id },
    data,
  })

  revalidatePath('/profile')
  return { success: true }
}
```

### Environment Variables

```bash
# Server-only (never exposed to client)
DATABASE_URL="postgresql://..."
API_SECRET="secret_key"
STRIPE_SECRET_KEY="sk_..."

# Client-accessible (prefixed with NEXT_PUBLIC_)
NEXT_PUBLIC_API_URL="https://api.example.com"
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY="pk_..."
```

## Database Integration

### Supabase

```typescript
// lib/supabase/client.ts
import { createBrowserClient } from '@supabase/ssr'

export function createClient() {
  return createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
  )
}

// lib/supabase/server.ts
import { createServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'

export async function createClient() {
  const cookieStore = await cookies()

  return createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        get(name: string) {
          return cookieStore.get(name)?.value
        },
        set(name: string, value: string, options: CookieOptions) {
          cookieStore.set({ name, value, ...options })
        },
        remove(name: string, options: CookieOptions) {
          cookieStore.set({ name, value: '', ...options })
        },
      },
    }
  )
}
```

**Authentication Best Practices:**

```typescript
// ✅ GOOD: Server Component auth check
async function ProtectedPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) redirect('/login')

  return <Dashboard user={user} />
}

// ✅ GOOD: Sign up with redirect
'use client'
async function handleSignUp(email: string, password: string) {
  const { data, error } = await supabase.auth.signUp({
    email,
    password,
    options: {
      emailRedirectTo: process.env.NEXT_PUBLIC_DEV_SUPABASE_REDIRECT_URL
        || `${window.location.origin}/auth/callback`
    }
  })
}

// ❌ BAD: Client-side auth check in useEffect
'use client'
function ProtectedPage() {
  useEffect(() => {
    supabase.auth.getUser().then(({ data }) => {
      if (!data.user) router.push('/login')
    })
  }, [])
}
```

**Critical: ALWAYS use Row Level Security (RLS)**

```sql
-- Enable RLS
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Policy: Users can only read their own data
CREATE POLICY "Users can read own data" ON users
  FOR SELECT USING (auth.uid() = id);

-- Policy: Users can update their own data
CREATE POLICY "Users can update own data" ON users
  FOR UPDATE USING (auth.uid() = id);
```

### Neon

```typescript
// lib/db.ts
import { neon } from '@neondatabase/serverless'

export const sql = neon(process.env.DATABASE_URL!)

// Usage in Server Component
async function getUsers() {
  const users = await sql`SELECT * FROM users WHERE active = true`
  return users
}
```

**Rules:**
- Use `@neondatabase/serverless` package
- NEVER use `@vercel/postgres` for Neon
- No ORM unless explicitly requested
- SQL scripts in `/scripts` folder for migrations

### Prisma (When ORM is needed)

```typescript
// lib/db.ts
import { PrismaClient } from '@prisma/client'

const globalForPrisma = globalThis as unknown as {
  prisma: PrismaClient | undefined
}

export const db = globalForPrisma.prisma ?? new PrismaClient()

if (process.env.NODE_ENV !== 'production') globalForPrisma.prisma = db
```

## AI Integration

### Vercel AI SDK (Default Choice)

```typescript
import { generateText, streamText, generateObject } from 'ai'

// Generate text
const { text } = await generateText({
  model: 'openai/gpt-4o',
  prompt: 'Explain quantum computing'
})

// Stream text
const result = streamText({
  model: 'anthropic/claude-sonnet-4.5',
  prompt: 'Write a story about...'
})

// Generate structured output
const { object } = await generateObject({
  model: 'openai/gpt-4o',
  schema: z.object({
    name: z.string(),
    age: z.number(),
  }),
  prompt: 'Extract person info: John is 30 years old'
})
```

**Supported Models (AI Gateway - No API key needed):**
- OpenAI: `openai/gpt-4o`, `openai/gpt-4o-mini`
- Anthropic: `anthropic/claude-sonnet-4.5`, `anthropic/claude-opus-4`
- xAI: `xai/grok-4`, `xai/grok-4-fast`
- Google: `google/gemini-2.0-flash`

**Rules:**
- Use AI SDK via `ai` and `@ai-sdk` packages
- NEVER use `runtime = 'edge'` with AI SDK
- Use JavaScript/TypeScript, not Python
- Avoid `langchain`, `openai-edge` packages

### Chatbot Implementation

```typescript
// app/api/chat/route.ts
import { streamText } from 'ai'

export async function POST(req: Request) {
  const { messages } = await req.json()

  const result = streamText({
    model: 'openai/gpt-4o',
    messages,
  })

  return result.toDataStreamResponse()
}

// app/chat/page.tsx
'use client'
import { useChat } from 'ai/react'

export default function ChatPage() {
  const { messages, input, handleInputChange, handleSubmit } = useChat()

  return (
    <div>
      {messages.map(m => (
        <div key={m.id}>{m.role}: {m.content}</div>
      ))}
      <form onSubmit={handleSubmit}>
        <input value={input} onChange={handleInputChange} />
      </form>
    </div>
  )
}
```

## Performance

### Image Optimization

```typescript
import Image from 'next/image'

// ✅ GOOD: Next.js Image with optimization
<Image
  src="/hero.jpg"
  alt="Hero image"
  width={1200}
  height={600}
  priority // Above fold
/>

// ✅ GOOD: Placeholder
<img src="/placeholder.svg?height=400&width=600&query=dashboard+hero" alt="Dashboard" />

// ❌ BAD: Regular img tag for photos
<img src="/hero.jpg" alt="Hero" />
```

### Loading States

```typescript
// app/dashboard/loading.tsx
export default function Loading() {
  return <div>Loading dashboard...</div>
}

// Suspense boundaries
import { Suspense } from 'react'

export default function Page() {
  return (
    <div>
      <Suspense fallback={<Skeleton />}>
        <AsyncComponent />
      </Suspense>
    </div>
  )
}
```

### Caching

```typescript
// Cache fetch requests
const data = await fetch('https://api.example.com', {
  next: { revalidate: 3600 } // 1 hour
})

// Cache Server Action responses
import { unstable_cache } from 'next/cache'

const getCachedUser = unstable_cache(
  async (id: string) => db.user.findUnique({ where: { id } }),
  ['user'],
  { revalidate: 3600 }
)
```

## Security

### Input Validation

```typescript
import { z } from 'zod'

const createPostSchema = z.object({
  title: z.string().min(1).max(100),
  content: z.string().min(10),
  published: z.boolean().default(false),
})

export async function createPost(formData: FormData) {
  // Validate on server
  const data = createPostSchema.parse({
    title: formData.get('title'),
    content: formData.get('content'),
    published: formData.get('published') === 'true',
  })

  // Safe to use
  await db.post.create({ data })
}
```

### Authentication

```typescript
// middleware.ts - Protect routes
import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'

export async function middleware(request: NextRequest) {
  const session = await getSession(request)

  if (!session && request.nextUrl.pathname.startsWith('/dashboard')) {
    return NextResponse.redirect(new URL('/login', request.url))
  }

  return NextResponse.next()
}

export const config = {
  matcher: ['/dashboard/:path*']
}
```

### Environment Security

```typescript
// ✅ GOOD: Server-only secrets
const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!)

// ❌ BAD: Exposing secrets to client
'use client'
const apiKey = process.env.API_SECRET // Exposed to browser!

// ✅ GOOD: Client-safe public keys
'use client'
const publicKey = process.env.NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY
```

## Quality Checklist

Before submitting code, verify:

- [ ] TypeScript has no errors
- [ ] Server Components used by default
- [ ] Client Components only when necessary ("use client")
- [ ] No data fetching in useEffect (use RSC or SWR)
- [ ] Environment variables properly scoped
- [ ] Input validation on server
- [ ] Proper error handling
- [ ] Loading states implemented
- [ ] Images optimized with Next.js Image
- [ ] Semantic HTML used
- [ ] ARIA attributes where needed
- [ ] Alt text on all images
- [ ] RLS policies if using Supabase
- [ ] Files split into logical components
- [ ] Meaningful variable names
- [ ] No exposed secrets

## Common Pitfalls

### ❌ Fetching in useEffect
```typescript
// BAD
useEffect(() => {
  fetch('/api/data').then(r => r.json()).then(setData)
}, [])

// GOOD: Server Component
const data = await fetch('/api/data')

// GOOD: Client with SWR
const { data } = useSWR('/api/data', fetcher)
```

### ❌ Missing "use client"
```typescript
// BAD - Will error on useState
function Component() {
  const [state, setState] = useState(0)
}

// GOOD
'use client'
function Component() {
  const [state, setState] = useState(0)
}
```

### ❌ Exposing Secrets
```typescript
// BAD
const apiKey = process.env.SECRET_KEY // In client component

// GOOD - Keep on server
async function serverAction() {
  const apiKey = process.env.SECRET_KEY
}
```

### ❌ Not Using Parallel Calls
```typescript
// BAD - Sequential
const user = await readFile('user.ts')
const posts = await readFile('posts.ts')

// GOOD - Parallel
const [user, posts] = await Promise.all([
  readFile('user.ts'),
  readFile('posts.ts')
])
```

Remember: These patterns are proven to work at scale. Follow them for reliable, performant, secure Next.js applications.
