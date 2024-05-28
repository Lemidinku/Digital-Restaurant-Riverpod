import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UsePipes,
  ValidationPipe,
  UseGuards,
  Req,
  Query,
} from '@nestjs/common';
import { MealsService } from './meals.service';
import { CreateMealDto } from './dto/create-meal.dto';
import { UpdateMealDto } from './dto/update-meal.dto';

import { RolesGuard } from '../auth/roles.guard';
import { UserRole } from '../enums/roles.enum';
import { Roles } from '../auth/roles.decorator';

@Controller('meals')
export class MealsController {
  constructor(private readonly mealsService: MealsService) {}

  @Post()
  @UsePipes(new ValidationPipe())
  @UseGuards(RolesGuard)
  @Roles(UserRole.ADMIN)
  create(@Body() createMealDto: CreateMealDto, @Req() req: any) {
    return this.mealsService.create(createMealDto);
  }

  @Patch(':id')
  @UsePipes(new ValidationPipe())
  @UseGuards(RolesGuard)
  @Roles(UserRole.ADMIN)
  update(@Param('id') id: string, @Body() updateMealDto: UpdateMealDto) {
    return this.mealsService.update(+id, updateMealDto, { new: true });
  }

  @Get()
  findAll(@Query() queryParams: object) {
    return this.mealsService.findAll(queryParams);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.mealsService.findOne(+id);
  }

  @Delete(':id')
  @UseGuards(RolesGuard)
  @Roles(UserRole.ADMIN)
  remove(@Param('id') id: string) {
    return this.mealsService.remove(+id);
  }
}
