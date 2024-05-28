import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { User } from '../schemas/User.schema';
import { Model } from 'mongoose';

@Injectable()
export class UsersService {
  constructor(@InjectModel(User.name) private UserModel: Model<User>) {}

  async findOne(id: number): Promise<User | null> {
    try {
      return await this.UserModel.findOne({ id: id });
    } catch (error) {
      throw new Error(`Error finding user with id ${id}: ${error.message}`);
    }
  }

  async remove(id: number): Promise<object | string> {
    try {
      return this.UserModel.deleteOne({ id: id }).exec();
    } catch (error) {
      throw new Error(`Error removing user with id ${id}: ${error.message}`);
    }
  }
}
