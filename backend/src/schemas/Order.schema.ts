import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';

// type Allergies = 'Gluten' | 'Lactose' | 'Nuts' | 'Shellfish' | 'None'; // to be edited
// type types = 'Breakfast' | 'Lunch' | 'Dinner' | 'Starter' | 'Desert'; // to be edited

import {
  IsString,
  IsNumber,
  MaxLength,
  IsOptional,
  ValidateNested,
} from 'class-validator';
import { Type } from 'class-transformer';

class KeyValidation {
  @IsString()
  @MaxLength(20)
  key: string;
}

class ValueValidation {
  @IsNumber()
  @IsOptional()
  value: number;
}

@Schema({ timestamps: true })
export class Order {
  @Prop({ required: true, unique: true })
  id: number;

  @Prop({
    required: true,
    unique: false,
    validate: {
      validator: (value: string) => /^\d{10}$/.test(value), //0987654321
      message: 'Phone number must be a 10-digit number. Ex: 0987654321',
    },
  })
  phone: string;

  @Prop({ required: true })
  total_price: number;

  @Prop({ required: true, type: Map })
  @ValidateNested({ each: true })
  @Type(() => KeyValidation)
  meals: Map<string, ValueValidation>;
  //   @Prop({ required: true, type: Map, of: String, to: Number })
  //   meals: Map<string, number>;

  @Prop({ required: false, default: false })
  completed: boolean;

  @Prop({ required: true })
  location: string;

  @Prop({ required: false })
  remark: string;
}

export const OrderSchema = SchemaFactory.createForClass(Order);
