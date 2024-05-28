import { Injectable, HttpStatus, HttpException} from '@nestjs/common';
import { SignupAuthDto } from './dto/signup.auth.dto';
import { InjectModel } from '@nestjs/mongoose';
import { User } from 'src/schemas/User.schema';
import { Model } from 'mongoose';
import * as bcrypt from 'bcrypt';
import { JwtService } from '@nestjs/jwt';
import { LoginAuthDto } from './dto/login.auth.dto';

@Injectable()
export class AuthService {
  constructor(
    @InjectModel(User.name)
    private userModel: Model<User>,
    private jwtService: JwtService,
  ) {}

  async signUp(signUpDto: SignupAuthDto): Promise<object> {
    // const { username, phone, password } = signUpDto;
    console.log("user registration")
    const hashedPassword = await bcrypt.hash(signUpDto.password, 10);

    signUpDto.password = hashedPassword;
    const lastUser = await this.userModel.findOne().sort({ id: -1 }).exec();
    const nextId = lastUser ? +lastUser.id + 1 : 1;

    try {
      const createdUser = new this.userModel({
        ...signUpDto,
        id: nextId,
      });
      await createdUser.save();

      return { success: true, message: 'User created successfully' };
    } catch (error) {
      console.log(error.code)
      if (error.code === 11000) {
        return {success: false, message: "Credintials already taken"}
      }
      return { success: false, message: error.message };
    }
  }

  async login(loginAuthDto: LoginAuthDto): Promise<object | null> {
    try {
      const user = await this.userModel.findOne({
        username: loginAuthDto.username,
      });

      if (!user) {
        return { success: false, message: 'User not found' };
      }

      if (!(await bcrypt.compare(loginAuthDto.password, user.password))) {
        return { success: false, message: 'Password is incorrect' };
      }

      const token = this.jwtService.sign({
        id: user.id,
        username: user.username,
        phone: user.phone,
        roles: user.roles,
      });
      const returned_user = { id: user.id,username: user.username, phone: user.phone, role:user.roles[0] }
      return { success: true, message: 'User logged in successfully', user: returned_user, token: token};
    } 
    catch (error) {
      throw new Error(`Error finding user with id: ${error.message}`);
    }
  }
}
