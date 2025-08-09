import {
  IsString,
  IsNotEmpty,
  MinLength,
  IsNumber,
  IsBoolean,
} from 'class-validator';

export class UpdateTaskDto {

  @IsString()
  @IsNotEmpty()
  title: string;

  @IsString()
  description: string;

  @IsBoolean()
  @IsNotEmpty()
  is_completed: boolean;
}