import {
  IsNotEmpty,
  IsString,
  Length,
  IsOptional,
  IsNumber,
  maxLength,
} from 'class-validator';

export class CreateOrderDto {
  @IsNotEmpty()
  @IsString()
  @Length(10, 10, {
    message: 'Phone number must be a 10-digit number. Ex: 0987654321',
  })
  phone: string;

  @IsNotEmpty()
  @IsNumber()
  total_price: number;

  @IsNotEmpty()
  meals: Map<string, number>;

  @IsString()
  @IsNotEmpty()
  location: string;

  @IsOptional()
  @IsString()
  @Length(10, 200, {
    message: 'Remark must be between 10 and 200 characters long.',
  })
  remark: string;
}
