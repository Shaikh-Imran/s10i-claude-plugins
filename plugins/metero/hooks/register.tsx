import { atom, read, update } from 'claude-code'
import type { Register } from 'claude-code'

const tick = atom({ plugin: 'metero', key: 'tick' } as const, 0)

const fmt = (n: number | undefined) =>
  n === undefined ? '?' : n >= 1000 ? `${(n / 1000).toFixed(n >= 100000 ? 0 : 1)}k` : `${n}`

const bar = (pct: number, width = 20) => {
  const filled = Math.max(0, Math.min(width, Math.round((pct / 100) * width)))
  return '█'.repeat(filled) + '░'.repeat(width - filled)
}

async function refresh($: any) {
  await update($, tick, (n: number) => n + 1)
}

export const register: Register = on => {
  on('session.start', async ($, e, next) => {
    await refresh($).catch(() => {})
    return next(e)
  })

  on('turn.complete', async ($, e, next) => {
    await refresh($).catch(() => {})
    return next(e)
  })

  on('ui.render', { component: 'AbovePrompt' }, async ($, e, next) => {
    await read($, tick)
    if (e.props.hasSurvey) return next(e)

    const u = await $.session.usage()
    const model = await $.session.model()
    const pct = u.context.percent ?? 0
    const { Box, Text } = $.ui.resolve(e)
    const color = pct >= 85 ? 'red' : pct >= 60 ? 'yellow' : 'green'

    const parts: string[] = []
    if (u.cost) parts.push(`$${u.cost.usd.toFixed(2)}`)
    for (const r of u.rateLimits) parts.push(`${r.kind} ${Math.round(r.percentUsed)}%`)

    return (
      <Box>
        <Text color={color}>{bar(pct)} {pct}%</Text>
        <Text dimColor>
          {' '}{fmt(u.context.tokens)}/{fmt(u.context.window)} tokens · {model}
          {parts.length ? ' · ' + parts.join(' · ') : ''}
        </Text>
      </Box>
    )
  })
}
