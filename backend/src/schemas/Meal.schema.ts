import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';

// type Allergies = 'Gluten' | 'Lactose' | 'Nuts' | 'Shellfish' | 'None'; // to be edited
// type types = 'Breakfast' | 'Lunch' | 'Dinner' | 'Starter' | 'Desert'; // to be edited

@Schema()
export class Meal {
  @Prop({ required: true, unique: true })
  id: number;
  @Prop({ required: true })
  name: string;

  @Prop({ required: true })
  price: number;

  @Prop({ required: true, minLength: 10, maxLength: 200 })
  description: string;

  @Prop({ required: true })
  imageUrl: string;

  @Prop({ required: true })
  types: string[];

  @Prop({ required: true })
  fasting: boolean;

  @Prop({ required: false })
  allergy: string;

  @Prop({ required: true })
  origin: string;
}

export const MealSchema = SchemaFactory.createForClass(Meal);
