import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';
import * as jwt from 'jsonwebtoken';

@Injectable()
export class JwtMiddleware implements NestMiddleware {
  use(req: Request, res: Response, next: NextFunction) {
    const token = req.headers['authorization'];

    if (token) {
      // Extract token from the "Bearer" header
      const tokenValue = token.replace('Bearer ', '');

      try {
        const decoded = jwt.verify(tokenValue, process.env.JWT_SECRET);
        req['user'] = decoded;
      } catch (error) {
        // Handle token verification error
        return res.status(401).json({ message: 'Invalid token' });
      }
    } else {
      // Handle missing token error
      return res.status(401).json({ message: 'Missing token' });
    }

    next();
  }
}
