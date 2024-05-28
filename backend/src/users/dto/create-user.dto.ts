import { IsNotEmpty, IsString, Length, IsOptional } from 'class-validator';

export class CreateUserDto {
  @IsNotEmpty()
  @IsString()
  username: string;

  @IsNotEmpty()
  @IsString()
  @Length(10, 10, {
    message: 'Phone number must be a 10-digit number. Ex: 0987654321',
  })
  phone: string;

  @IsNotEmpty()
  @IsString()
  @Length(6, 10, { message: 'Password must be at least 6 characters long' })
  password: string;

  @IsOptional()
  @IsString()
  location: string;
}
