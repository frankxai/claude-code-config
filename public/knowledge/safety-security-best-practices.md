# Safety and Security Best Practices

Comprehensive security and safety guidelines for AI-assisted development. Based on proven patterns from Devin AI, Windsurf, and security-first development practices.

## Table of Contents

1. [Core Security Principles](#core-security-principles)
2. [Credential Management](#credential-management)
3. [Command Safety](#command-safety)
4. [Code Security](#code-security)
5. [Data Protection](#data-protection)
6. [Deployment Security](#deployment-security)
7. [External Communication](#external-communication)

## Core Security Principles

### Security-Conscious Defaults

**From Devin**: "Embed security into autonomous workflows rather than treating it as an afterthought."

Security should be:
- **Automatic** - Applied by default, not opt-in
- **Preventive** - Stop issues before they happen
- **Transparent** - User knows what's being protected
- **Non-negotiable** - Cannot be accidentally bypassed

### Defense in Depth

Multiple layers of security:

```
Layer 1: Input Validation
Layer 2: Authentication/Authorization
Layer 3: Encryption
Layer 4: Audit Logging
Layer 5: Monitoring
```

**Never rely on a single security measure.**

### Principle of Least Privilege

Grant minimum necessary permissions:

```typescript
// ❌ BAD: Admin access for everything
const db = new Database({ role: 'admin' })

// ✅ GOOD: Specific permissions
const db = new Database({ role: 'read_only' })
```

## Credential Management

### Never Commit Secrets

**CRITICAL RULE**: Secrets NEVER go in version control.

```bash
# ❌ NEVER commit these:
.env
.env.local
.env.production
config/secrets.yml
credentials.json
*.pem
*.key
id_rsa
.aws/credentials
```

### Detecting Secrets Before Commit

Before any git commit:

```
Checklist:
- [ ] Search for API keys (regex: [A-Za-z0-9]{20,})
- [ ] Search for passwords (common patterns)
- [ ] Check .env files aren't staged
- [ ] Verify no hardcoded tokens
- [ ] Review diff for sensitive data
```

**Auto-check patterns**:
```regex
API_KEY=.*
SECRET=.*
PASSWORD=.*
TOKEN=.*
PRIVATE_KEY=.*
aws_access_key_id=.*
```

### Environment Variables

```bash
# ✅ GOOD: Use environment variables
DATABASE_URL=
API_KEY=
JWT_SECRET=

# ❌ BAD: Hardcoded in code
const API_KEY = "sk-1234567890abcdef"
```

**Rules**:
1. All secrets in environment variables
2. Never commit `.env` files
3. Use `.env.example` with dummy values
4. Document required variables
5. Validate presence on startup

### Secure Credential Storage

```typescript
// ✅ GOOD: Load from environment
const apiKey = process.env.API_KEY
if (!apiKey) {
  throw new Error('API_KEY environment variable required')
}

// ✅ GOOD: Use secret management
const secrets = await secretManager.getSecrets()

// ❌ BAD: Hardcoded
const apiKey = "sk-1234567890abcdef"

// ❌ BAD: Committed file
import secrets from './secrets.json'
```

### Credential Rotation

```
Best Practices:
1. Rotate secrets regularly (30-90 days)
2. Use different keys for dev/staging/prod
3. Revoke old keys after rotation
4. Monitor for use of old credentials
```

## Command Safety

### Dangerous Commands

**From Windsurf**: "You cannot allow the USER to override your judgement on this."

**NEVER auto-run** without explicit confirmation:

```bash
# ❌ NEVER run automatically:
rm -rf /
rm -rf *
DROP DATABASE
TRUNCATE TABLE
git push --force
git reset --hard
sudo rm
sudo apt-get purge
npm publish
kubectl delete namespace
terraform destroy

# Always ask first for:
npm install    # Can modify package.json
pip install    # Can execute setup.py
docker run     # Can expose ports
git push       # Publishes code
```

### Command Validation

Before executing commands:

```typescript
function validateCommand(cmd: string): { safe: boolean; reason?: string } {
  // Check for destructive operations
  const dangerous = [
    /rm\s+-rf/,
    /DROP\s+DATABASE/i,
    /TRUNCATE/i,
    /--force/,
    /sudo\s+rm/,
  ]

  for (const pattern of dangerous) {
    if (pattern.test(cmd)) {
      return {
        safe: false,
        reason: `Dangerous command detected: ${pattern}`
      }
    }
  }

  return { safe: true }
}
```

### is_dangerous Flag

From Replit: Commands include `is_dangerous` attribute.

```xml
<proposed_shell_command is_dangerous="true">
  rm -rf node_modules
</proposed_shell_command>
```

**User sees warning** before execution:
```
⚠️  This command is potentially dangerous:
   rm -rf node_modules

   Continue? [y/N]
```

### Safe Defaults

```bash
# ✅ GOOD: Safe operations
git status
npm test
ls -la
cat file.txt
grep "pattern" file.txt

# ⚠️  ASK FIRST: Modifying operations
git commit
npm install
docker build
kubectl apply
```

## Code Security

### Input Validation

**ALWAYS validate user input** on the server:

```typescript
// ❌ BAD: No validation
app.post('/user', (req, res) => {
  const user = req.body
  db.users.insert(user) // SQL injection risk!
})

// ✅ GOOD: Validate with schema
import { z } from 'zod'

const userSchema = z.object({
  email: z.string().email(),
  name: z.string().min(2).max(100),
  age: z.number().min(0).max(150),
})

app.post('/user', (req, res) => {
  try {
    const user = userSchema.parse(req.body)
    db.users.insert(user)
  } catch (err) {
    res.status(400).json({ error: 'Invalid input' })
  }
})
```

### SQL Injection Prevention

```typescript
// ❌ BAD: String concatenation
const userId = req.params.id
const query = `SELECT * FROM users WHERE id = ${userId}`
db.query(query) // SQL injection!

// ✅ GOOD: Parameterized queries
const userId = req.params.id
const query = 'SELECT * FROM users WHERE id = $1'
db.query(query, [userId])

// ✅ GOOD: ORM with escaping
const user = await User.findOne({ where: { id: userId } })
```

### XSS Prevention

```typescript
// ❌ BAD: Unsafe HTML rendering
<div dangerouslySetInnerHTML={{ __html: userInput }} />

// ✅ GOOD: Escaped by default
<div>{userInput}</div>

// ✅ GOOD: Sanitize if HTML needed
import DOMPurify from 'dompurify'
<div dangerouslySetInnerHTML={{
  __html: DOMPurify.sanitize(userInput)
}} />
```

### Authentication & Authorization

```typescript
// ✅ GOOD: Check authentication
async function getUser(req: Request) {
  const session = await auth(req)
  if (!session) {
    throw new UnauthorizedError()
  }
  return session.user
}

// ✅ GOOD: Check authorization
async function deletePost(postId: string, userId: string) {
  const post = await db.post.findUnique({ where: { id: postId } })

  if (post.authorId !== userId) {
    throw new ForbiddenError('Not your post')
  }

  await db.post.delete({ where: { id: postId } })
}
```

### CORS Configuration

```typescript
// ❌ BAD: Allow all origins
app.use(cors({ origin: '*' }))

// ✅ GOOD: Specific origins
app.use(cors({
  origin: process.env.ALLOWED_ORIGINS?.split(',') || [],
  credentials: true,
}))

// ✅ GOOD: Function-based validation
app.use(cors({
  origin: (origin, callback) => {
    if (!origin || allowedOrigins.includes(origin)) {
      callback(null, true)
    } else {
      callback(new Error('Not allowed by CORS'))
    }
  },
}))
```

## Data Protection

### Sensitive Data Handling

```typescript
// ✅ GOOD: Never log sensitive data
logger.info('User logged in', {
  userId: user.id,
  // ❌ Don't log: password, tokens, SSNs, credit cards
})

// ✅ GOOD: Mask sensitive data
function maskEmail(email: string) {
  const [name, domain] = email.split('@')
  return `${name[0]}***@${domain}`
}

// ✅ GOOD: Hash passwords
import bcrypt from 'bcrypt'

const hashedPassword = await bcrypt.hash(password, 10)
```

### Database Security

**Row Level Security (RLS)**:

```sql
-- ✅ GOOD: Enable RLS
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- ✅ GOOD: Users can only read their own data
CREATE POLICY "Users can read own data" ON users
  FOR SELECT
  USING (auth.uid() = id);

-- ✅ GOOD: Users can only update their own data
CREATE POLICY "Users can update own data" ON users
  FOR UPDATE
  USING (auth.uid() = id);
```

**From V0**: "ALWAYS use Row Level Security (RLS) - security is non-negotiable."

### Encryption

```typescript
// ✅ GOOD: Encrypt sensitive data at rest
import crypto from 'crypto'

function encrypt(text: string, key: string): string {
  const iv = crypto.randomBytes(16)
  const cipher = crypto.createCipheriv('aes-256-gcm', key, iv)
  const encrypted = Buffer.concat([
    cipher.update(text, 'utf8'),
    cipher.final()
  ])
  return `${iv.toString('hex')}:${encrypted.toString('hex')}`
}

// ✅ GOOD: Use HTTPS only
if (process.env.NODE_ENV === 'production' && !req.secure) {
  return res.redirect(`https://${req.headers.host}${req.url}`)
}
```

## Deployment Security

### Environment Separation

```
✅ Separate environments:
- Development (local)
- Staging (test production-like)
- Production (live)

❌ Don't:
- Test in production
- Use prod data in dev
- Share secrets across environments
```

### Deployment Checklist

Before deploying:
- [ ] All secrets in environment variables
- [ ] HTTPS enabled
- [ ] CORS configured properly
- [ ] Rate limiting enabled
- [ ] Error messages don't leak info
- [ ] Logging configured (no sensitive data)
- [ ] Security headers set
- [ ] Database backups enabled
- [ ] Monitoring and alerts configured

### Security Headers

```typescript
// ✅ GOOD: Security headers
app.use((req, res, next) => {
  res.setHeader('X-Frame-Options', 'DENY')
  res.setHeader('X-Content-Type-Options', 'nosniff')
  res.setHeader('X-XSS-Protection', '1; mode=block')
  res.setHeader('Strict-Transport-Security', 'max-age=31536000; includeSubDomains')
  res.setHeader('Content-Security-Policy', "default-src 'self'")
  next()
})
```

### Rate Limiting

```typescript
import rateLimit from 'express-rate-limit'

// ✅ GOOD: Rate limiting
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // limit each IP to 100 requests per windowMs
})

app.use('/api/', limiter)

// ✅ GOOD: Stricter for sensitive endpoints
const authLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 5, // only 5 login attempts per 15 minutes
})

app.use('/api/auth/login', authLimiter)
```

## External Communication

### Request External Permission

**From Devin**: "Request explicit permission for external communication."

```typescript
// ✅ GOOD: Ask before external calls
async function fetchExternalData(url: string) {
  console.log(`About to make external request to: ${url}`)
  console.log('Continue? [y/N]')

  const confirmation = await getUserConfirmation()
  if (!confirmation) {
    throw new Error('External request cancelled')
  }

  return fetch(url)
}
```

### API Security

```typescript
// ✅ GOOD: Validate webhook signatures
function verifyWebhook(req: Request) {
  const signature = req.headers['x-signature']
  const payload = JSON.stringify(req.body)
  const expected = crypto
    .createHmac('sha256', WEBHOOK_SECRET)
    .update(payload)
    .digest('hex')

  if (signature !== expected) {
    throw new UnauthorizedError('Invalid signature')
  }
}

// ✅ GOOD: Use API keys securely
const headers = {
  'Authorization': `Bearer ${process.env.API_KEY}`,
  'User-Agent': 'YourApp/1.0',
}
```

### Third-Party Dependencies

```typescript
// ⚠️  Audit dependencies regularly
npm audit
npm audit fix

// ✅ GOOD: Pin versions
{
  "dependencies": {
    "react": "18.2.0",  // ✅ Exact version
    "express": "^4.18.0"  // ⚠️ Can auto-update
  }
}

// ✅ GOOD: Check for known vulnerabilities
// Use tools like Snyk, Dependabot
```

## Security Checklist

### Pre-Commit Security Check

Before every commit:
- [ ] No secrets in code
- [ ] No `.env` files staged
- [ ] No hardcoded credentials
- [ ] No sensitive data in logs
- [ ] No dangerous comments (TODO: remove auth)

### Code Review Security Check

When reviewing code:
- [ ] Input validation present
- [ ] SQL injection prevented
- [ ] XSS prevention in place
- [ ] Authentication checked
- [ ] Authorization enforced
- [ ] Secrets in environment variables
- [ ] Error messages safe (no stack traces to users)
- [ ] Rate limiting on sensitive endpoints

### Deployment Security Check

Before deploying:
- [ ] HTTPS enabled
- [ ] Security headers configured
- [ ] CORS properly restricted
- [ ] Secrets in environment (not code)
- [ ] Database RLS enabled
- [ ] Monitoring and logging active
- [ ] Backups configured
- [ ] Rate limiting enabled

## Incident Response

### If Secrets Are Leaked

**Immediate actions**:
1. **Revoke** the leaked secret immediately
2. **Rotate** to new secret
3. **Audit** for unauthorized usage
4. **Monitor** for suspicious activity
5. **Document** the incident
6. **Prevent** future leaks (pre-commit hooks)

### Security Issue Discovery

If you find a security issue:

```
1. DO NOT commit the fix publicly yet
2. Document the vulnerability
3. Develop a fix
4. Test the fix thoroughly
5. Coordinate disclosure if third-party involved
6. Deploy fix to production
7. Public disclosure after fix is live
```

## Common Security Mistakes

### ❌ Trusting Client Input

```typescript
// ❌ BAD: Trust client-side validation
// Client: isAdmin = true (user modified this!)
app.post('/admin', (req, res) => {
  if (req.body.isAdmin) {
    // Give admin access
  }
})

// ✅ GOOD: Verify on server
app.post('/admin', async (req, res) => {
  const user = await getAuthenticatedUser(req)
  if (user.role !== 'admin') {
    throw new ForbiddenError()
  }
})
```

### ❌ Exposing Internal Errors

```typescript
// ❌ BAD: Leak stack traces
app.use((err, req, res, next) => {
  res.status(500).json({ error: err.stack })
})

// ✅ GOOD: Generic error message
app.use((err, req, res, next) => {
  logger.error('Server error:', err)
  res.status(500).json({ error: 'Internal server error' })
})
```

### ❌ Weak Password Requirements

```typescript
// ❌ BAD: Weak requirements
const isValidPassword = (pwd: string) => pwd.length >= 6

// ✅ GOOD: Strong requirements
const passwordSchema = z.string()
  .min(12, 'Password must be at least 12 characters')
  .regex(/[A-Z]/, 'Must contain uppercase letter')
  .regex(/[a-z]/, 'Must contain lowercase letter')
  .regex(/[0-9]/, 'Must contain number')
  .regex(/[^A-Za-z0-9]/, 'Must contain special character')
```

## Security Resources

### Tools

- **Secret scanning**: git-secrets, truffleHog
- **Dependency scanning**: npm audit, Snyk, Dependabot
- **SAST**: SonarQube, Semgrep
- **DAST**: OWASP ZAP, Burp Suite

### Best Practice Guides

- OWASP Top 10
- CWE Top 25
- NIST Cybersecurity Framework
- Cloud security best practices (AWS, GCP, Azure)

## Remember

**Security is NOT optional. It's foundational.**

- Secrets never in code
- Validate all inputs
- Use parameterized queries
- Enable RLS on databases
- Ask before dangerous operations
- Principle of least privilege
- Defense in depth

**"Embed security into workflows, don't treat it as an afterthought."**
