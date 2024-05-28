import { Module } from '@nestjs/common';
import { MealsService } from './meals.service';
import { MealsController } from './meals.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { Meal, MealSchema } from 'src/schemas/Meal.schema';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: Meal.name, schema: MealSchema }]),
  ],
  controllers: [MealsController],
  providers: [MealsService],
})
export class MealsModule {}
