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

// type Allergies = 'Gluten' | ' Lactose' | 'Nuts' | 'Shellfish' | 'None';

export class CreateMealDto {
  @IsNotEmpty()
  @IsString()
  name: string;

  @IsNotEmpty()
  @IsNumber(
    { allowInfinity: false, allowNaN: false },
    { message: 'Value must be a number.' },
  )
  price: number;

  @IsNotEmpty()
  @IsString()
  @Length(10, 200, {
    message: 'Description must be between 10 and 200 characters long.',
  })
  description: string;

  @IsNotEmpty()
  @IsString()
  imageUrl: string;

  // taking: can we just use the isin option only

  @IsNotEmpty()
  @IsArray({ message: 'Value must be an array.' })
  @IsIn(['Breakfast', 'Lunch', 'Dinner', 'Starter', 'Desert'], {
    each: true,
    message: 'Invalid Meals types.',
  })
  types: string[];

  @IsNotEmpty()
  @IsBoolean()
  fasting: boolean;

  // taking: can we just use the isin option only

  @IsNotEmpty()
  @IsOptional()
  @IsString()
  // @IsIn(['Gluten', 'Lactose', 'Nuts', 'Shellfish'], {
  //   message: 'Invalid allergy type.',
  // })
  allergy: string;

  @IsNotEmpty()
  @IsString()
  origin: string;
}
