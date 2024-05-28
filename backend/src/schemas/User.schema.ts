import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { UserRole } from '../enums/roles.enum';
@Schema()
export class User {
  @Prop({ required: true, unique: true })
  id: number;

  @Prop({ required: true, unique: true })
  username: string;

  @Prop({
    required: true,
    unique: true,
    validate: {
      validator: (value: string) => /^\d{10}$/.test(value), //0987654321
      message: 'Phone number must be a 10-digit number. Ex: 0987654321',
    },
  })
  phone: string;

  @Prop({ required: true, minlength: 6 })
  password: string;

  @Prop({ required: false })
  location: string;

  @Prop({ type: [String], enum: UserRole, default: [UserRole.USER] })
  roles: UserRole[];
}

export const UserSchema = SchemaFactory.createForClass(User);
