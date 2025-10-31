# Next.js Skills Quick Reference

## 🚀 Quick Commands

### Invoke Skills
```bash
# Expert guidance for any Next.js task
/skill nextjs-expert

# Full agent team for complex projects
/skill nextjs-agent-team

# Upgrade to Next.js 16
/skill nextjs-upgrade-assistant
```

## 📋 Cheat Sheet

### When to Use Each Skill

| Task | Use This | Example |
|------|----------|---------|
| Build a component | nextjs-expert | "Create a product card with Server Components" |
| Debug an error | nextjs-expert | "Fix hydration error in my dashboard" |
| Full app build | nextjs-agent-team | "Build a blog with auth and payments" |
| Performance issues | nextjs-agent-team | "Performance Agent: optimize my app" |
| Upgrade Next.js | nextjs-upgrade-assistant | "Upgrade from 15 to 16" |
| Learn patterns | nextjs-expert | "Show me Server Actions best practices" |

### Agent Team Shortcuts

```bash
# Architecture planning
/skill nextjs-agent-team
"Architecture Agent: design a SaaS dashboard"

# Performance optimization
/skill nextjs-agent-team
"Performance Agent: audit and optimize"

# Security review
/skill nextjs-agent-team
"Security Agent: secure my API endpoints"

# UI improvements
/skill nextjs-agent-team
"UI/UX Agent: make this component responsive"
```

## 🎯 Common Patterns

### Server Component (Default)
```typescript
// app/posts/page.tsx
async function getPosts() {
  const res = await fetch('https://api.example.com/posts', {
    next: { revalidate: 3600 }
  })
  return res.json()
}

export default async function PostsPage() {
  const posts = await getPosts()
  return <PostsList posts={posts} />
}
```

### Client Component (Interactive)
```typescript
'use client'
import { useState } from 'react'

export function Counter() {
  const [count, setCount] = useState(0)
  return <button onClick={() => setCount(count + 1)}>{count}</button>
}
```

### Server Action (Mutations)
```typescript
'use server'
import { revalidatePath } from 'next/cache'

export async function createPost(formData: FormData) {
  const data = {
    title: formData.get('title'),
    content: formData.get('content'),
  }
  await db.post.create({ data })
  revalidatePath('/posts')
}
```

### Metadata (SEO)
```typescript
export const metadata = {
  title: 'My Page',
  description: 'Page description',
  openGraph: {
    title: 'My Page',
    images: ['/og-image.jpg'],
  },
}
```

## 🔌 MCP Servers

### Check Status
```bash
claude mcp list
# Should show: next-devtools-mcp ✓ Connected
```

### Start Dev Server (enables built-in MCP)
```bash
npm run dev
# Built-in Next.js MCP auto-connects in Next.js 16+
```

## 🐛 Quick Fixes

### Hydration Error
```typescript
// Add suppressHydrationWarning for time/dates
<time suppressHydrationWarning>{new Date().toString()}</time>
```

### Cache Not Updating
```typescript
import { revalidatePath, revalidateTag } from 'next/cache'

// After mutation
revalidatePath('/posts')
// Or
revalidateTag('posts')
```

### Server Action Fails
```typescript
// Ensure 'use server' is first line
'use server'

// Return only serializable data
return { success: true, data: JSON.parse(JSON.stringify(result)) }
```

## 📚 Resources

- Read full docs: `cat ~/.claude/skills/README-NEXTJS-SKILLS.md`
- Next.js Docs: https://nextjs.org/docs
- Invoke skills for detailed help

---

**Pro Tip:** Always run `npm run dev` to enable both MCP servers for full capabilities!
