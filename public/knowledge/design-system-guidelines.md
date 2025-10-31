# Design System Guidelines

Comprehensive design system rules based on V0's proven patterns for creating beautiful, consistent, and accessible user interfaces.

## Table of Contents

1. [Color System](#color-system)
2. [Typography](#typography)
3. [Layout Structure](#layout-structure)
4. [Tailwind Implementation](#tailwind-implementation)
5. [Visual Elements](#visual-elements)
6. [Accessibility](#accessibility)
7. [Responsive Design](#responsive-design)

## Color System

### Core Rules

**ALWAYS use exactly 3-5 colors total. NO exceptions.**

### Required Color Structure

```
1 Primary Brand Color    (e.g., blue-600)
+
2-3 Neutrals            (white, gray-100-900, black, off-white)
+
1-2 Accent Colors       (complementary or analogous to primary)
=
3-5 Total Colors MAX
```

### Color Selection Principles

**DO:**
- Choose colors appropriate for the design brief
- Use semantic color tokens: `bg-background`, `text-foreground`
- Ensure proper contrast ratios (WCAG AA minimum)
- Test colors in both light and dark modes

**DON'T:**
- Use purple or violet prominently (unless explicitly requested)
- Exceed 5 total colors without explicit permission
- Use random color choices without design rationale

### Color Override Rules

**CRITICAL: When you override a component's background color, you MUST override its text color too.**

```css
/* ❌ BAD - Text may be unreadable */
.card {
  @apply bg-blue-600;
}

/* ✅ GOOD - Ensures proper contrast */
.card {
  @apply bg-blue-600 text-white;
}
```

### Gradient Rules

**Default: Avoid gradients entirely unless explicitly requested.**

When gradients are necessary:
- Use only as subtle accents, NEVER for primary elements
- Maximum 2-3 color stops, no complex gradients
- Use analogous colors only:
  - ✅ blue → teal
  - ✅ purple → pink
  - ✅ orange → red
- NEVER mix opposing temperatures:
  - ❌ pink → green
  - ❌ orange → blue
  - ❌ red → cyan

```css
/* ✅ GOOD: Analogous colors */
background: linear-gradient(to right, #3b82f6, #06b6d4);

/* ❌ BAD: Opposing temperatures */
background: linear-gradient(to right, #ec4899, #10b981);
```

## Typography

### Core Rules

**ALWAYS limit to maximum 2 font families total.**

### Required Font Structure

```
1 Font for Headings     (can use multiple weights: 400, 600, 700, 900)
+
1 Font for Body Text    (typically 400, 600)
=
2 Font Families MAX
```

**More than 2 fonts = Visual chaos + Slower loading**

### Typography Implementation

**Line Height:**
- Body text: 1.4-1.6 (use `leading-relaxed` or `leading-6`)
- Headings: 1.1-1.3 (use `leading-tight` or `leading-none`)

**Font Sizes:**
- NEVER use decorative fonts for body text
- NEVER use fonts smaller than 14px for body text
- Minimum 16px for comfortable reading

```css
/* ✅ GOOD Typography Hierarchy */
h1: text-4xl font-bold leading-tight
h2: text-3xl font-bold leading-tight
h3: text-2xl font-semibold leading-snug
body: text-base leading-relaxed
small: text-sm leading-normal
```

### Next.js Font Integration

```typescript
// app/layout.tsx
import { Inter, JetBrains_Mono } from 'next/font/google'

const inter = Inter({
  subsets: ['latin'],
  variable: '--font-sans',
})

const jetbrainsMono = JetBrains_Mono({
  subsets: ['latin'],
  variable: '--font-mono',
})

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" className={`${inter.variable} ${jetbrainsMono.variable}`}>
      <body>{children}</body>
    </html>
  )
}
```

```css
/* app/globals.css */
@import 'tailwindcss';

@theme inline {
  --font-sans: var(--font-inter);
  --font-mono: var(--font-jetbrains-mono);
}
```

**Usage in components:**

```tsx
<h1 className="font-sans">Heading in Inter</h1>
<code className="font-mono">Code in JetBrains Mono</code>
```

### Text Balance & Pretty

Use Tailwind's text balancing utilities for optimal line breaks:

```tsx
{/* ✅ Headings - Prevent orphans */}
<h1 className="text-4xl font-bold text-balance">
  The Future of Web Development
</h1>

{/* ✅ Body text - Optimal readability */}
<p className="text-base leading-relaxed text-pretty">
  Long paragraph content here...
</p>
```

## Layout Structure

### Mobile-First Approach

**ALWAYS design mobile-first, then enhance for larger screens.**

```tsx
{/* ✅ GOOD: Mobile-first */}
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3">

{/* ❌ BAD: Desktop-first */}
<div className="grid grid-cols-3 md:grid-cols-1">
```

### Layout Method Priority

Use in this exact order:

1. **Flexbox** - For most layouts
   ```tsx
   <div className="flex items-center justify-between">
   ```

2. **CSS Grid** - Only for complex 2D layouts
   ```tsx
   <div className="grid grid-cols-3 gap-4">
   ```

3. **Absolute/Fixed Positioning** - Only when absolutely necessary
   ```tsx
   <div className="absolute top-0 right-0">
   ```

**NEVER use floats for layout.**

### Spacing Patterns

**Prefer Tailwind spacing scale over arbitrary values:**

```tsx
{/* ✅ GOOD: Tailwind scale */}
<div className="p-4 mx-2 py-6 gap-4">

{/* ❌ BAD: Arbitrary values */}
<div className="p-[16px] mx-[8px] py-[24px] gap-[16px]">
```

**Use gap classes for spacing:**

```tsx
{/* ✅ GOOD: Gap for flex/grid spacing */}
<div className="flex gap-4">
  <div>Item 1</div>
  <div>Item 2</div>
</div>

{/* ❌ BAD: Margin on children */}
<div className="flex">
  <div className="mr-4">Item 1</div>
  <div>Item 2</div>
</div>
```

## Tailwind Implementation

### Required Tailwind Patterns

**Semantic Classes (Preferred):**
```tsx
<div className="flex items-center justify-between text-center">
```

**Responsive Prefixes:**
```tsx
<div className="text-base md:text-lg lg:text-xl">
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3">
```

**Design Tokens (Always use):**
```tsx
{/* ✅ GOOD: Semantic tokens */}
<div className="bg-background text-foreground border-border">

{/* ❌ BAD: Direct colors */}
<div className="bg-white text-black border-gray-200">
```

### Semantic Design Token System

Define in `app/globals.css`:

```css
@import 'tailwindcss';

@theme inline {
  /* Fonts */
  --font-sans: var(--font-geist-sans);
  --font-mono: var(--font-geist-mono);

  /* Colors */
  --color-background: 0 0% 100%;
  --color-foreground: 222.2 84% 4.9%;
  --color-card: 0 0% 100%;
  --color-card-foreground: 222.2 84% 4.9%;
  --color-popover: 0 0% 100%;
  --color-popover-foreground: 222.2 84% 4.9%;
  --color-primary: 222.2 47.4% 11.2%;
  --color-primary-foreground: 210 40% 98%;
  --color-secondary: 210 40% 96.1%;
  --color-secondary-foreground: 222.2 47.4% 11.2%;
  --color-muted: 210 40% 96.1%;
  --color-muted-foreground: 215.4 16.3% 46.9%;
  --color-accent: 210 40% 96.1%;
  --color-accent-foreground: 222.2 47.4% 11.2%;
  --color-destructive: 0 84.2% 60.2%;
  --color-destructive-foreground: 210 40% 98%;
  --color-border: 214.3 31.8% 91.4%;
  --color-input: 214.3 31.8% 91.4%;
  --color-ring: 222.2 84% 4.9%;

  /* Radius */
  --radius: 0.5rem;
}

.dark {
  --color-background: 222.2 84% 4.9%;
  --color-foreground: 210 40% 98%;
  /* ... dark mode values ... */
}
```

**Usage:**
```tsx
<div className="bg-background text-foreground">
<Card className="bg-card text-card-foreground border-border">
<Button className="bg-primary text-primary-foreground">
```

### Tailwind Best Practices

**DO:**
- Prefer spacing scale: `p-4`, `gap-6`, `mx-2`
- Use semantic classes: `items-center`, `justify-between`
- Apply responsive prefixes: `md:grid-cols-2`, `lg:text-xl`
- Use design tokens: `bg-background`, `text-foreground`

**DON'T:**
- Mix margin/padding with gap on same element
- Use `space-*` utility classes (deprecated pattern)
- Use arbitrary values when scale values exist
- Apply direct colors when tokens exist

## Visual Elements

### Icons

**Implementation Rules:**

```tsx
{/* ✅ GOOD: Use project's icon library */}
import { User, Settings, LogOut } from 'lucide-react'

<User className="h-5 w-5" />
<Settings className="h-5 w-5" />

{/* ✅ GOOD: Consistent sizing */}
Icon sizes: 16px (h-4 w-4), 20px (h-5 w-5), 24px (h-6 w-6)

{/* ❌ BAD: Emojis as icons */}
<span>👤</span> {/* Don't use emojis! */}
```

### Images

**Next.js Image Optimization:**

```tsx
import Image from 'next/image'

{/* ✅ GOOD: Optimized images */}
<Image
  src="/hero.jpg"
  alt="Hero section background"
  width={1200}
  height={600}
  priority // For above-fold images
  className="object-cover"
/>

{/* ✅ GOOD: Placeholders */}
<img
  src="/placeholder.svg?height=400&width=600&query=modern+dashboard"
  alt="Dashboard preview"
/>

{/* ❌ BAD: Regular img for photos */}
<img src="/hero.jpg" alt="Hero" />
```

### What NOT to Create

**NEVER generate:**
- Abstract gradient circles as filler
- Blurry squares or decorative blobs
- Complex SVG illustrations manually
- Emoji-based icon systems

**DO generate:**
- Meaningful, contextual imagery
- Proper icon implementations
- Structured layouts
- Real content previews

## Accessibility

### Semantic HTML

```tsx
{/* ✅ GOOD: Semantic structure */}
<main className="container mx-auto">
  <header className="border-b">
    <nav aria-label="Main navigation">
      <ul className="flex gap-4">
        <li><a href="/">Home</a></li>
      </ul>
    </nav>
  </header>

  <article className="prose">
    <h1>Article Title</h1>
    <section>
      <h2>Section Title</h2>
    </section>
  </article>
</main>

{/* ❌ BAD: Div soup */}
<div className="container">
  <div className="border-b">
    <div className="flex gap-4">
      <div><a href="/">Home</a></div>
    </div>
  </div>
</div>
```

### ARIA Attributes

```tsx
{/* Buttons */}
<button aria-label="Close dialog" onClick={onClose}>
  <X className="h-4 w-4" />
</button>

{/* Navigation */}
<nav aria-label="Main navigation">

{/* Landmarks */}
<aside aria-label="Sidebar navigation">

{/* Live regions */}
<div role="alert" aria-live="polite">
  Form submitted successfully!
</div>
```

### Screen Reader Support

```tsx
{/* ✅ GOOD: Screen reader only text */}
<button>
  <span className="sr-only">Open menu</span>
  <Menu className="h-6 w-6" aria-hidden="true" />
</button>

{/* ✅ GOOD: Alt text */}
<img src="/logo.png" alt="Company Logo - Acme Corp" />

{/* ✅ GOOD: Empty alt for decorative */}
<img src="/decorative-pattern.svg" alt="" role="presentation" />
```

### Color Contrast

**Minimum Requirements (WCAG AA):**
- Normal text: 4.5:1 contrast ratio
- Large text (18px+ or 14px+ bold): 3:1 contrast ratio

```tsx
{/* ✅ GOOD: High contrast */}
<p className="text-foreground">Easy to read text</p>

{/* ⚠️ Check contrast */}
<p className="text-muted-foreground">Muted text - verify ratio</p>

{/* ❌ BAD: Low contrast */}
<p className="text-gray-300">On white background - fails</p>
```

## Responsive Design

### Breakpoint Strategy

```tsx
{/* Mobile: base (< 768px) */}
{/* Tablet: md (≥ 768px) */}
{/* Desktop: lg (≥ 1024px) */}
{/* Wide: xl (≥ 1280px) */}

{/* ✅ GOOD: Progressive enhancement */}
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">

{/* Container sizing */}
<div className="w-full md:w-3/4 lg:w-2/3 xl:w-1/2">

{/* Typography scaling */}
<h1 className="text-2xl md:text-3xl lg:text-4xl xl:text-5xl">
```

### Component Patterns

```tsx
{/* ✅ GOOD: Responsive navigation */}
<nav className="hidden md:flex gap-4">
  <a href="/about">About</a>
  <a href="/contact">Contact</a>
</nav>
<button className="md:hidden" aria-label="Open menu">
  <Menu />
</button>

{/* ✅ GOOD: Responsive spacing */}
<section className="px-4 py-8 md:px-8 md:py-12 lg:px-16 lg:py-16">

{/* ✅ GOOD: Responsive grid gap */}
<div className="grid grid-cols-2 gap-2 md:gap-4 lg:gap-6">
```

## Design Quality Checklist

Before finalizing any design, verify:

- [ ] Uses exactly 3-5 colors (1 primary + 2-3 neutrals + 1-2 accents)
- [ ] Maximum 2 font families
- [ ] No gradients unless explicitly requested
- [ ] Mobile-first responsive design
- [ ] Uses Tailwind spacing scale (not arbitrary values)
- [ ] Semantic design tokens applied
- [ ] Proper color contrast (WCAG AA)
- [ ] Semantic HTML structure
- [ ] ARIA attributes where needed
- [ ] Alt text on all meaningful images
- [ ] Screen reader support (sr-only class)
- [ ] Consistent icon sizing
- [ ] No emojis as icons
- [ ] Text balance/pretty applied to headings
- [ ] Layout uses flexbox/grid (not floats)
- [ ] Gap classes for spacing (not margin on children)

## Design Philosophy

> **"Ship something interesting rather than boring, but never ugly."**

### Balance These Principles:

1. **Consistency** - Follow the design system strictly
2. **Creativity** - Make it interesting and engaging
3. **Usability** - Ensure it's functional and accessible
4. **Performance** - Keep it fast and optimized

### When in Doubt:

- Simpler is better than complex
- Readable is better than decorative
- Accessible is better than flashy
- Fast is better than feature-rich

Remember: These guidelines exist to help you create professional, accessible, and beautiful designs consistently. Follow them, and you'll build interfaces that users love.
