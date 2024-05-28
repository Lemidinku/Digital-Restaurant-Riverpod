import {
  IsNotEmpty,
  IsString,
  IsNumber,
  Length,
  IsArray,
  IsIn,
  IsBoolean,
  IsOptional,
} from 'class-validator';

export class UpdateMealDto {
  @IsNotEmpty()
  @IsOptional()
  @IsString()
  name: string;

  @IsNotEmpty()
  @IsOptional()
  @IsNumber(
    { allowInfinity: false, allowNaN: false },
    { message: 'Value must be a number.' },
  )
  price: number;

  @IsNotEmpty()
  @IsOptional()
  @IsString()
  @Length(10, 200, {
    message: 'Description must be between 10 and 200 characters long.',
  })
  description: string;

  @IsNotEmpty()
  @IsOptional()
  imageUrl: string;

  // taking: can we just use the isin option only

  @IsNotEmpty()
  @IsOptional()
  @IsArray({ message: 'Value must be an array.' })
  @IsIn(['Breakfast', 'Lunch', 'Dinner', 'Starter', 'Desert'], {
    each: true,
    message: 'Invalid Meals types.',
  })
  types: string[];

  @IsNotEmpty()
  @IsOptional()
  @IsBoolean()
  fasting: boolean;

  // taking: can we just use the isin option only

  @IsNotEmpty()
  @IsOptional()
  @IsString()
  // @IsIn(['Gluten', 'Lactose', 'Nuts', 'Shellfish', 'None'], {
  //   message: 'Invalid allergy type.',
  // })
  allergies: string;

  @IsNotEmpty()
  @IsOptional()
  @IsString()
  origin: string;
}
