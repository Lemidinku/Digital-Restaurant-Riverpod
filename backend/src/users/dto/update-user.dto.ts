import { PartialType } from '@nestjs/mapped-types';
import { CreateUserDto } from './create-user.dto';
import { IsOptional, IsString, Length } from 'class-validator';

export class UpdateUserDto extends PartialType(CreateUserDto) {
  @IsOptional()
  @IsString()
  @Length(10, 10, {
    message: 'Phone number must be a 10-digit number. Ex: 0987654321',
  })
  phone: string;

  @IsOptional()
  @IsString()
  @Length(6, 10, { message: 'Password must be at least 6 characters long' })
  password: string;

  @IsOptional()
  @IsString()
  location: string;
}
