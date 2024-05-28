import { IsNotEmpty, IsString, Length } from 'class-validator';

export class LoginAuthDto {
  @IsNotEmpty()
  @IsString()
  username: string;

  @IsNotEmpty()
  @IsString()
  @Length(6, 10, { message: 'Password must be at least 6 characters long' })
  password: string;
}
