import { IsNotEmpty, IsBoolean } from 'class-validator';

export class UpdateOrderDto {
  @IsNotEmpty()
  @IsBoolean()
  completed: boolean;
}
