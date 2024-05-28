import { Injectable } from '@nestjs/common';
import { CreateMealDto } from './dto/create-meal.dto';
import { UpdateMealDto } from './dto/update-meal.dto';
import { InjectModel } from '@nestjs/mongoose';
import { Meal } from 'src/schemas/Meal.schema';
import { Model } from 'mongoose';

@Injectable()
export class MealsService {
  constructor(@InjectModel(Meal.name) private MealModel: Model<Meal>) {}

  async create(createMealDto: CreateMealDto): Promise<Meal> {
    const lastMeal = await this.MealModel.findOne().sort({ id: -1 }).exec();
    const nextId = lastMeal ? +lastMeal.id + 1 : 1;

    const createdMeal = new this.MealModel({
      ...createMealDto,
      id: nextId,
    });
    return createdMeal.save();
  }

  async update(
    id: number,
    updateMealDto: UpdateMealDto,
    options?: any,
  ): Promise<Meal | null> {
    try {
      return await this.MealModel.findOneAndUpdate(
        { id: id },
        updateMealDto,
        options,
      );
    } catch (error) {
      throw new Error(`Error updating user with id ${id}: ${error.message}`);
    }
  }

  async findAll(queryParams): Promise<any[]> {
    console.log('you are in findAll');
    // console.log('queryParams', queryParams);
    try {
      let filter: any = {};
      let filteredTypes = null;
      let filteredAllergy = null;

      if (queryParams.origin) {
        filter.origin = queryParams.origin;
      }

      if (queryParams.fasting === 'true') {
        filter.fasting = 'true';
      }

      if (queryParams.allergy) {
        // filter.allergies = queryParams.allergies;
        filteredAllergy = queryParams.allergy;
      }

      if (queryParams.types) {
        console.log('queryParams.types', queryParams.types);
        filteredTypes = queryParams.types.split(',');
      }

      let meals: any[] = [];
      if (queryParams.types && queryParams.allergy) {
        meals = await this.MealModel.find({
          ...filter,
          types: { $in: filteredTypes },
          allergy: { $ne: filteredAllergy },
        }).exec();
      } else if (queryParams.types) {
        meals = await this.MealModel.find({
          ...filter,
          types: { $in: filteredTypes },
        }).exec();
      } else if (queryParams.allergy) {
        meals = await this.MealModel.find({
          ...filter,
          allergy: { $ne: filteredAllergy },
        }).exec();
      } else {
        meals = await this.MealModel.find(filter).exec();
      }
      return meals;
    } catch (error) {
      throw new Error(`Error finding all meals: ${error.message}`);
    }
  }

  async findOne(id: number) {
    try {
      return this.MealModel.findOne({ id: id });
    } catch (error) {
      throw new Error(`Error finding meal with id ${id}: ${error.message}`);
    }
  }

  remove(id: number) {
    return this.MealModel.deleteOne({ id: id });
  }
}
