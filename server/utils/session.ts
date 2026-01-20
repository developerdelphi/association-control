import jwt from 'jsonwebtoken'
import { H3Event } from 'h3'

const SESSION_COOKIE = 'auth_token'
const SECRET = process.env.JWT_SECRET || 'super-secret-key-change-me'

export const createUserSession = (event: H3Event, user: any) => {
  const token = jwt.sign(
    { 
      id: user.id, 
      role: user.role, 
      associacaoId: user.associacaoId,
      name: user.name,
      email: user.email
    },
    SECRET,
    { expiresIn: '7d' }
  )

  setCookie(event, SESSION_COOKIE, token, {
    httpOnly: true,
    secure: process.env.NODE_ENV === 'production',
    maxAge: 60 * 60 * 24 * 7, // 1 week
    path: '/'
  })
}

export const getUserFromSession = (event: H3Event) => {
  const token = getCookie(event, SESSION_COOKIE)
  if (!token) return null

  try {
    return jwt.verify(token, SECRET)
  } catch (e) {
    return null
  }
}

export const clearUserSession = (event: H3Event) => {
  deleteCookie(event, SESSION_COOKIE)
}

export const requireAuth = (event: H3Event) => {
  const user = event.context.user
  if (!user) {
    throw createError({
      statusCode: 401,
      statusMessage: 'Unauthorized'
    })
  }
  return user
}
