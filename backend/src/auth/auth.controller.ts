import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UsePipes,
  ValidationPipe,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { LoginAuthDto } from './dto/login.auth.dto';
import { SignupAuthDto } from './dto/signup.auth.dto';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('/signup')
  @UsePipes(new ValidationPipe())
  Signup(@Body() signupAuthDto: SignupAuthDto) {
    return this.authService.signUp(signupAuthDto);
  }

  @Post('/login')
  @UsePipes(new ValidationPipe())
  Login(@Body() loginAuthDto: LoginAuthDto) {
    return this.authService.login(loginAuthDto);
  }
}
