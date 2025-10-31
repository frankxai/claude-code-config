# Next.js Skills Suite for Claude Code

**Version:** 1.0
**Created:** 2025-10-24
**Author:** FrankX AI Systems

## 🎯 Overview

A comprehensive suite of Claude Code skills for Next.js development, leveraging the new Next.js 16 MCP servers for enhanced development capabilities.

## 📦 What's Included

### 1. **nextjs-expert.md**
   - **Purpose:** Deep Next.js expertise and patterns
   - **Use When:** Building features, debugging, optimizing
   - **Key Features:**
     - Server Components & Client Components patterns
     - Server Actions implementation
     - Data fetching & caching strategies
     - Metadata & SEO optimization
     - Performance best practices
     - MCP integration for real-time insights

### 2. **nextjs-agent-team.md**
   - **Purpose:** Specialized agent team for comprehensive projects
   - **Use When:** Complex features requiring multiple specializations
   - **Agents:**
     - 🎯 Architecture Agent - System design
     - 💻 Implementation Agent - Code generation
     - 🎨 UI/UX Agent - Styling & accessibility
     - ⚡ Performance Agent - Optimization
     - 🔒 Security Agent - Protection & validation
     - 🧪 Testing Agent - Quality assurance
     - 📚 Documentation Agent - Knowledge sharing

### 3. **nextjs-upgrade-assistant.md**
   - **Purpose:** Automated migration to Next.js 16
   - **Use When:** Upgrading from Next.js 15 or earlier
   - **Features:**
     - Step-by-step upgrade process
     - Configuration migration
     - Code transformations
     - Testing & validation
     - Rollback procedures
     - Common issues & solutions

## 🚀 Quick Start

### Activate a Single Skill

In Claude Code, invoke the skill command:

```bash
/skill nextjs-expert
```

Then ask your Next.js question or request:
- "Build a blog with Server Components"
- "Optimize this component's performance"
- "Implement authentication with Server Actions"

### Activate the Agent Team

```bash
/skill nextjs-agent-team
```

Then describe your project:
- "Build a complete e-commerce platform"
- "Create a SaaS dashboard with auth"
- "Optimize my existing Next.js app"

The appropriate agents will activate based on your needs.

### Upgrade to Next.js 16

```bash
/skill nextjs-upgrade-assistant
```

The assistant will guide you through the upgrade process step by step.

## 🔌 MCP Server Integration

These skills leverage two powerful MCP servers:

### Next DevTools MCP (Already Installed ✅)
- Comprehensive documentation access
- Migration helpers and codemods
- Best practices and patterns
- Framework-specific guidance

### Built-in Next.js MCP Server (Auto-connects in Next.js 16+ dev mode)
- Real-time application state
- Runtime error monitoring
- Performance metrics
- Server Actions inspection
- Component hierarchy analysis

## 📚 Skill Combinations

### For New Projects

1. **Start with Architecture:**
   ```bash
   /skill nextjs-agent-team
   "Design a blog platform with authentication"
   ```
   Activates: Architecture → Implementation → UI/UX → Security → Testing

2. **Build Features:**
   ```bash
   /skill nextjs-expert
   "Implement server-side pagination for blog posts"
   ```

3. **Optimize:**
   ```bash
   /skill nextjs-agent-team
   "Optimize performance and Core Web Vitals"
   ```
   Activates: Performance Agent

### For Existing Projects

1. **Upgrade First:**
   ```bash
   /skill nextjs-upgrade-assistant
   ```

2. **Then Enhance:**
   ```bash
   /skill nextjs-expert
   "Add new features using Next.js 16 patterns"
   ```

3. **Optimize:**
   ```bash
   /skill nextjs-agent-team
   "Performance audit and optimization"
   ```

### For Debugging

1. **Diagnose:**
   ```bash
   /skill nextjs-expert
   "Debug hydration error in user dashboard"
   ```

2. **Fix with Context:**
   The skill will query both MCP servers for real-time insights and documentation

## 🎓 Learning Path

### Beginner → Expert

**Week 1-2: Fundamentals**
- Use `nextjs-expert` to learn core concepts
- Build simple pages with Server Components
- Implement basic data fetching

**Week 3-4: Advanced Patterns**
- Use `nextjs-agent-team` to see expert workflows
- Implement Server Actions for mutations
- Add authentication and authorization

**Week 5-6: Production Ready**
- Performance optimization with Performance Agent
- Security hardening with Security Agent
- Comprehensive testing with Testing Agent

**Ongoing: Stay Updated**
- Use `nextjs-upgrade-assistant` for version upgrades
- Query next-devtools-mcp for latest patterns
- Monitor with built-in MCP during development

## 💡 Pro Tips

### 1. Always Run Dev Server for Full MCP Access
```bash
npm run dev
```
This enables the built-in Next.js MCP server for real-time insights.

### 2. Combine Skills for Complex Tasks
```bash
/skill nextjs-agent-team
"Create a feature using nextjs-expert patterns"
```

### 3. Use Specific Agents for Targeted Help
```bash
/skill nextjs-agent-team
"Performance Agent: audit my app"
```

### 4. Leverage MCP Documentation
The skills automatically query next-devtools-mcp, but you can also:
- Ask about specific Next.js APIs
- Request code examples
- Get migration guidance

### 5. Save Custom Patterns
Build on these skills by:
- Adding project-specific patterns
- Creating custom agent workflows
- Documenting your architecture decisions

## 🔧 Configuration

### Global Installation (Already Done ✅)
- Next DevTools MCP: Installed globally via Claude MCP manager
- Skills: Located in `~/.claude/skills/`
- Available across all projects

### Project-Specific Configuration

Add to your project's `.claude/` directory for project-specific patterns:

```bash
# In your Next.js project
mkdir -p .claude/skills
cp ~/.claude/skills/nextjs-expert.md .claude/skills/
# Edit to add project-specific patterns
```

## 📊 Skill Comparison

| Skill | Best For | Complexity | MCP Usage |
|-------|----------|------------|-----------|
| nextjs-expert | Single features, debugging, learning | Medium | High |
| nextjs-agent-team | Full projects, complex features | High | Very High |
| nextjs-upgrade-assistant | Version migration | Medium | Medium |

## 🎯 Use Cases

### E-Commerce Platform
```bash
/skill nextjs-agent-team
"Build an e-commerce platform with:
- Product catalog with search
- Shopping cart with Server Actions
- Stripe payment integration
- Admin dashboard
- SEO optimization"
```

Activates: All agents in sequence

### Blog with CMS
```bash
/skill nextjs-expert
"Create a blog using Contentful CMS with:
- ISR for posts
- Dynamic sitemap
- RSS feed
- Related posts feature"
```

### Dashboard with Real-time Data
```bash
/skill nextjs-agent-team
"Build a SaaS dashboard with:
- Authentication (NextAuth.js)
- Real-time data updates
- Charts and analytics
- User management
- API rate limiting"
```

Activates: Architecture → Implementation → Security → Performance

### Performance Optimization
```bash
/skill nextjs-agent-team
"Performance Agent: Full audit and optimization"
```

Activates: Performance Agent only

## 🐛 Troubleshooting

### Skills Not Appearing
```bash
# List all skills
ls ~/.claude/skills/

# Verify skill format
cat ~/.claude/skills/nextjs-expert.md
```

### MCP Not Connected
```bash
# Check MCP status
claude mcp list

# Should show:
# ✓ next-devtools-mcp: npx next-devtools-mcp
# ✓ Built-in Next.js MCP (when dev server running)
```

### Skill Not Working as Expected
- Ensure you're invoking with `/skill <name>`
- Check that dev server is running for full MCP access
- Verify Next.js version (16+ recommended)

## 🔄 Maintenance

### Updating Skills
```bash
# Pull latest versions
cd ~/.claude/skills
# Update files as needed
```

### Adding Custom Skills
```bash
# Create new skill
nano ~/.claude/skills/my-custom-nextjs-skill.md

# Follow skill format from existing skills
```

### Sharing Skills
```bash
# Share with team
cp ~/.claude/skills/nextjs-*.md /path/to/team/repo/.claude/skills/
```

## 📈 Metrics

Track your productivity improvements:

- **Development Speed:** Faster feature implementation with agent team
- **Code Quality:** Better patterns from expert guidance
- **Performance:** Improved Core Web Vitals from Performance Agent
- **Security:** Fewer vulnerabilities from Security Agent
- **Test Coverage:** Higher coverage from Testing Agent

## 🎉 Success Stories

These skills are designed to help you:
- ✅ Build production-ready Next.js apps faster
- ✅ Follow best practices automatically
- ✅ Avoid common pitfalls
- ✅ Stay updated with latest patterns
- ✅ Scale your development workflow

## 📚 Additional Resources

- [Next.js Documentation](https://nextjs.org/docs)
- [Next.js 16 Release Notes](https://nextjs.org/blog/next-16)
- [React Server Components](https://react.dev/reference/rsc/server-components)
- [Vercel Platform Docs](https://vercel.com/docs)

## 🤝 Contributing

To enhance these skills:
1. Add new patterns to `nextjs-expert.md`
2. Create specialized agents in `nextjs-agent-team.md`
3. Update migration steps in `nextjs-upgrade-assistant.md`
4. Share improvements with the community

## 📝 Changelog

### Version 1.0 (2025-10-24)
- Initial release
- Three comprehensive skills
- Full MCP integration
- Agent team system
- Upgrade assistant

---

**Built by FrankX AI Systems for the Next.js community** 🚀

For questions or improvements, invoke the skills and ask!
